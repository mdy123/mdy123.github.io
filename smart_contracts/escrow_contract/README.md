### Escrow smart contract on Near blockchain using Rust language.
  * [Near Blockchain](https://near.org/)  
  * [Rust Language](https://www.rust-lang.org/) 
  
&nbsp; It has four states to complete this escrow contract.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. NotInitiated,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. AwaitingPayment,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. AwaitingDelivery,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. Complete, 
	
&nbsp; Functon "new" initializes the smart contract by assigning Buyer's Near id, Seller's Near Id and agreed Price.  
* near deploy --accountId owner.escrow.testnet --wasmFile target/wasm32-unknown-unknown/release/escrow.wasm --initFunction new --initArgs '{"buyer": "buyer.escrow.testnet", "seller": "seller.escrow.testnet", "price": "5"}'  
&nbsp; Buyer and Seller use "init_escrow" function to sign in and change the state from "NotInitiated" to "AwaitingPayment".  
* near call owner.escrow.testnet init_escrow '{}' --account-id buyer.escrow.testnet  
* near call owner.escrow.testnet init_escrow '{}' --account-id seller.escrow.testnet  
&nbsp; Buyer uses "deposite" function to tranfer the tokens to this smart contract and changes the state from "AwaitingPayment" to "AwaitingDelivery".  
* near call owner.escrow.testnet deposite '{}' --account-id buyer.escrow.testnet --amount 5  
&nbsp; Buyer uses "confirm_delivery" function to transfer the tokens from this contract to seller and changes the state from "AwaitingDelivery" to "Complete".  
* near call owner.escrow.testnet confirm_delivery '{}' --account-id buyer.escrow.testnet  
&nbsp; Owner of this contract uses "withdraw" function to canel this transaction.  
* near call owner.escrow.testnet withdraw '{}' --account-id owner.escrow.testnet  
&nbsp; Owner of this contract uses "reset" function to reset Buyer id, Seller id, agreed Price and the state back to NotInitiated.  
* near call owner.escrow.testnet reset '{}' --account-id owner.escrow.testnet  
&nbsp; Function "get_all_data" returns all the data of this contract.  
* near call owner.escrow.testnet get_all_data '{}' --account-id buyer.escrow.testnet  
