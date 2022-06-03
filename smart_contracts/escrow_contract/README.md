### Escrow smart contract on Near blockchain using Rust language.
  * [Near Blockchain](https://near.org/)  
  * [Rust Language](https://www.rust-lang.org/) 
  
&nbsp;&nbsp; It has four states to complete this escrow contract.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. NotInitiated,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. AwaitingPayment,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. AwaitingDelivery,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. Complete, 
	
Functon "new" initializes the smart contract by assinging Buyer's Near id, Buyer's Near Id and Agreed Price. 

Buyer and Seller use "init_escrow" function to sign in and change the state from "NotInitiated" to "AwaitingPayment".
    	
Buyer uses "deposite" function to tranfer the tokens to this smart contract and changes the state from "AwaitingPayment" to "AwaitingDelivery".
    	
Buyer uses "confirm_delivery" function to transfer the tokens from this contract to seller and changes the state from "AwaitingDelivery" to "Complete".
    	
Owner of this contract uses "withdraw" function to canel this transaction.
    	
Owner of this contract uses "reset" function to reset Buyer id, Seller id, agreed Price and the state back to NotInitiated.
    	
Function "get_all_data" returns all the data of this contract.
