# Command Transactions #

## TransactionCommand ##

`TransactionCommand` is a `Command` specialization whose `YATransactionCommand` implementation is initialized with an underlying `Command` object and a `TransactionCommandDelegate` delegate. When the underlying command completes, `YATransactionCommand` is guaranteed to invoke its delegate with exactly one of `commandTransactionDidSucceed:` or `commandTransaction:didFailWithError:`.

`TransactionCommand` makes available a read-only `transaction` property. Because this transaction property is available upon creation (before execution) and is then supplied back to the delegate after execution via the `TransactionCommandDelegate` methods, it allows clients to identify and relate transactional operation completions.


## CommandTransaction ##

`CommandTransaction` is merely a token whose value should not be interpreted or evaluated. The only valid operations upon a `CommandTransaction` are to store and compare for pointer equality with another `CommandTransaction` object. This is useful to relate the completion of a transaction to the overall operation.

For example, when the user pulls down to refresh in the conversation list, the view controller creates a conversation refresh command and stores its `CommandTransaction`. When the view controller receives a transaction completion event for that same transaction (identified by the supplied `CommandTransaction`), it triggers the closing animation of the pull-to-refresh UI. Because one client may be the transaction delegate for multiple overlapping commands, it must use the `CommandTransaction` to relate completing commands to specific user interactions.


## Command Creators ##

Clients typically use a command creator such as `ConversationCommandFactory` to actually create `Command` objects.

To make a command transactional, the manufacturing method in the command creator needs to be changed to accept the `CommandTransactionDelegate` parameter, compose the underlying command into a `TransactionCommand` using `TransactionCommandInstanceFactory`, and return the newly created command's `transaction` property to the client as a `CommandTransaction`.


## Lifecycle ##

It's safe for clients to hold strong references to `TransactionCommand` and `CommandTransaction`.

Further, clients do not need to resign transaction delegation (`YATransactionCommand` holds a strong reference to its delegate until the transaction is complete, which is safe because the transaction is guaranteed to complete, at which time `YATransactionCommand` will break the reference cycle).