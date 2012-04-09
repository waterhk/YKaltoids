# ContactRepository #

ContactRepository is a façade for the native address book. As a domain layer above the native implementation, ContactRepository frees the rest of the app from managing background tasks and Core Foundation memory.

## Usage ##

Clients of ContactRepository should:

* get contacts via the `contacts` accessor
	* return value
		* `NSArray*` of `YAContact*` objects
		* empty non-`nil` array indicates user's address book has no contacts
		* `nil` indicates contacts have not yet been loaded; ContactRepository automatically schedules asynchronous loading of contacts in this case, and clients should handle contacts change notification (see below) to respond
	* *note* this flat array may evolve into a more complex type, or additional entrypoints may be added to ContactRepository (e.g., for sorting, finding by name/address/number/native record ID)

* handle contacts change notifications
	* implement (or have a delegate implement) `ContactRepositorySubscriber`:
		* `- (void) contactRepositoryDidLoadContacts:(id<ContactRepository>)contactRepository`
	* subscribe to contacts change notifications via `addSubscriber:(id<ContactRepositorySubscriber>)subscriber`
	* when no longer interested in change notifications, unsubscribe via `removeSubscriber:(id<ContactRepositorySubscriber>)subscriber`
		* your object must unsubscribe before it is destroyed (so unsubscribe at least by `dealloc`)

## Under the Hood ##

ContactRepository is composed of several internal components. These are **not intended for direct use by clients**.

### Dependency Tree ###

The dependency tree is defined in `ContactRepository.aff`.

* `contactRepository` (façade to native address book)
	* `contactStore` (caches contacts and staleness flag)
	* `addressBookObserver` (notifies contactRepository when native address book has changed, triggering async re-load)
	* `addressBookLoadCommandInstanceFactory` => `addressBookLoadCommand` (abstracts load operation into Command pattern to aid in background threading)
		* `addressBookLoader` (reads from native address book into domain model objects)
		* `mainThreader` (thunks load completion callback to delegate back onto main thread)
	* `contactCommandQueue` (manages queue of background thread contacts operations)
