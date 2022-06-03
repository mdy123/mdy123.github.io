### Escrow smart contract on Near blockchain using Rust language.
  * [Near Blockchain](https://near.org/)  
  * [Rust Language](https://www.rust-lang.org/) 
  
&nbsp; It has four states to complete this escrow contract.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. NotInitiated,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. AwaitingPayment,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. AwaitingDelivery,  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4. Complete, 
	
&nbsp; Functon "new" initializes the smart contract by assigning Buyer's Near id, Seller's Near Id and Agreed Price.  

&nbsp; Buyer and Seller use "init_escrow" function to sign in and change the state from "NotInitiated" to "AwaitingPayment".  

&nbsp; Buyer uses "deposite" function to tranfer the tokens to this smart contract and changes the state from "AwaitingPayment" to "AwaitingDelivery".  

&nbsp; Buyer uses "confirm_delivery" function to transfer the tokens from this contract to seller and changes the state from "AwaitingDelivery" to "Complete".  

&nbsp; Owner of this contract uses "withdraw" function to canel this transaction.  

&nbsp; Owner of this contract uses "reset" function to reset Buyer id, Seller id, agreed Price and the state back to NotInitiated.  

&nbsp; Function "get_all_data" returns all the data of this contract.  
