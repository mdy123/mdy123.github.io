//  ----------  Escrow Contract on Near blockchain --------
//  ---------------   Near-SDK 4.0.0  ---------------------

use near_sdk::borsh::{self, BorshDeserialize, BorshSerialize};
use near_sdk::env::log_str;
use near_sdk::json_types::U128;
use near_sdk::serde::{Deserialize, Serialize};
use near_sdk::{env, near_bindgen, AccountId, Balance, PanicOnDefault, Promise};
use std::fmt;

#[derive(
    PartialEq, Clone, Copy, Serialize, Deserialize, BorshDeserialize, BorshSerialize, Debug,
)]
#[serde(crate = "near_sdk::serde")]
pub enum State {
    NotInitiated,
    AwaitingPayment,
    AwaitingDelivery,
    Complete,
}

#[derive(PartialEq, Clone, Copy, Serialize, Deserialize, BorshDeserialize, BorshSerialize)]
#[serde(crate = "near_sdk::serde")]
pub enum ErrorType {
    NeitherBuyerNorSellerNorOwner,
    NeitherBuyerNorSeller,
    NotTheBuyer,
    NotTheOwner,
    StateError(State),
    NotTheRightAmount,
}

impl fmt::Display for State {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            State::NotInitiated => write!(f, "NotInitiated"),
            State::AwaitingPayment => write!(f, "AwaitingPayment"),
            State::AwaitingDelivery => write!(f, "AwaitingDelivery"),
            State::Complete => write!(f, "Complete"),
        }
    }
}

impl fmt::Display for ErrorType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            ErrorType::NeitherBuyerNorSellerNorOwner => write!(f, "NeitherBuyerNorSellerNorOwner"),
            ErrorType::NeitherBuyerNorSeller => write!(f, "NeitherBuyerNorSeller"),
            ErrorType::NotTheBuyer => write!(f, "NotTheBuyer"),
            ErrorType::NotTheOwner => write!(f, "NotTheOwner"),
            ErrorType::StateError(state) => write!(f, "StateError({})", state),
            ErrorType::NotTheRightAmount => write!(f, "NotTheRightAmount"),
        }
    }
}

pub type Result<T> = core::result::Result<T, String>;

#[near_bindgen]
#[derive(
    PanicOnDefault, Serialize, Deserialize, BorshDeserialize, BorshSerialize, Clone, Debug,
)]
#[serde(crate = "near_sdk::serde")]
pub struct Escrow {
    owner: AccountId,
    buyer: AccountId,
    seller: AccountId,
    price: Balance,
    state: State,
    is_buyer_in: bool,
    is_seller_in: bool,
}
#[near_bindgen]
impl Escrow {
    #[init]
    pub fn new(buyer: AccountId, seller: AccountId, price: U128) -> Self {
        Self {
            owner: env::current_account_id(),
            buyer,
            seller,
            price: price.0 * 10u128.pow(24),
            state: State::NotInitiated,
            is_buyer_in: Default::default(),
            is_seller_in: Default::default(),
        }
    }

    // Buyer and Seller sign in function
    //Change NotInitiated to AwaitingPayment state.
    #[handle_result]
    pub fn init_escrow(&mut self) -> Result<()> {
        if self.buyer == env::predecessor_account_id() {
            if !self.is_buyer_in {
                self.is_buyer_in = true;
            }
            if self.is_buyer_in && self.is_seller_in {
                //chage state to State::Awaiting Payment
                self.set_state();
            }
            log_str("Change NotInitiated to AwaitingPayment state.");
            return Ok(());
        }
        if self.seller == env::predecessor_account_id() {
            if !self.is_seller_in {
                self.is_seller_in = true;
            }
            if self.is_buyer_in && self.is_seller_in {
                //Change from NotInitiated to AwaitingPayment state.
                self.set_state();
            }
            log_str("Change NotInitiated to AwaitingPayment state.");
            return Ok(());
        }

        Err(ErrorType::NeitherBuyerNorSeller.to_string())
    }

    //Buyer deposite function.
    //Change AwaitingPayment to  AwaitingDelivery state
    #[payable]
    #[handle_result]
    pub fn deposite(&mut self) -> Result<()> {
        let buyer = env::predecessor_account_id();
        if buyer != self.buyer {
            if env::attached_deposit() != 0u128 {
                self.pay_back(env::attached_deposit());
            };
            return Err(ErrorType::NotTheBuyer.to_string());
        }
        if self.state != State::AwaitingPayment {
            if env::attached_deposit() != 0u128 {
                self.pay_back(env::attached_deposit());
            };
            return Err(ErrorType::StateError(self.state).to_string());
        }
        log_str(&format!(
            "Deposit - {},  Price - {}",
            env::attached_deposit(),
            self.price
        ));
        log_str(&format!(
            "Equal or Not - {}",
            env::attached_deposit() == self.price
        ));
        if env::attached_deposit() != self.price {
            self.pay_back(env::attached_deposit());
            return Err(ErrorType::NotTheRightAmount.to_string());
        }

        //Change AwaitingPayment to  AwaitingDelivery state
        self.set_state();
        log_str("Change AwaitingPayment to  AwaitingDelivery state");
        Ok(())
    }

    //Buyer confirm delivery function.
    //change AwaitingDelivery to Complete state
    #[handle_result]
    pub fn confirm_delivery(&mut self) -> Result<()> {
        let buyer = env::predecessor_account_id();
        if buyer != self.buyer {
            return Err(ErrorType::NotTheBuyer.to_string());
        }

        if self.state != State::AwaitingDelivery {
            return Err(ErrorType::StateError(self.state).to_string());
        }

        // Transfer money from contract to seller
        Promise::new(self.seller.clone()).transfer(self.price);

        //change AwaitingDelivery to Complete state
        self.set_state();
        log_str("Change AwaitingDelivery to Complete state");
        Ok(())
    }

    // Contract owner withdraw function.
    //change state to Complete
    #[handle_result]
    pub fn withdraw(&mut self) -> Result<()> {
        let owner = env::predecessor_account_id();
        if owner != self.owner {
            return Err(ErrorType::NotTheOwner.to_string());
        }

        if self.state != State::Complete {
            if self.state == State::AwaitingDelivery {
                log_str(&format!("Pay deposite {} back to buyer.", self.price));
                self.pay_back(self.price);
            }

            log_str(&format!("Change {} to Complete state.", self.state));
            //change state to Complete
            self.state = State::Complete;
        } else {
            log_str(&format!(
                "Already complete. {}.",
                ErrorType::StateError(self.state)
            ));
            return Err(ErrorType::StateError(self.state).to_string());
        }

        Ok(())
    }

    // Contract owner reset buyer, seller, price , state, is_buyer_in
    // and is_seller_in function .
    #[handle_result]
    pub fn reset(&mut self, buyer: AccountId, seller: AccountId, price: U128) -> Result<&mut Self> {
        if env::predecessor_account_id() != self.owner {
            return Err(ErrorType::NotTheOwner.to_string());
        }

        self.buyer = buyer;
        self.seller = seller;
        self.price = price.0 * 10u128.pow(24);
        self.state = State::NotInitiated;
        self.is_buyer_in = Default::default();
        self.is_seller_in = Default::default();

        log_str(&format!("Reset all data \n {:?}", self));
        Ok(self)
    }

    // Get escrow contract data function.
    pub fn get_all_data(&self) -> &Escrow {
        log_str(&format!("All data \n {:?}", self));
        self
    }

    #[private]
    fn pay_back(&self, amount: Balance) -> Promise {
        Promise::new(env::predecessor_account_id()).transfer(amount)
    }

    #[private]
    fn set_state(&mut self) {
        self.state = match self.state {
            State::NotInitiated => State::AwaitingPayment,
            State::AwaitingPayment => State::AwaitingDelivery,
            State::AwaitingDelivery => State::Complete,
            State::Complete => return,
        }
    }
}
