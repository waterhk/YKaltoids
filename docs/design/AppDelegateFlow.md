# AppDelegate Flow #

The AppDelegate performs critical setup operations for our application including creating the App Factory, causing 
top level components to be constructed and initialized with their dependencies (and so on down the chain), setting 
the root view controller, checking for the presence or absence of session information, retrieving session crumbs and 
deciding if the current user needs to enter the FTU flow or be taken directly to conversation list. Without a fully 
functional AppDelegate, the user will never see iOS Hub. For this reason we need to take care to ensure that the 
steps taken by the AppDelegate are done properly. In order to meet this requirement relatively minor changes need 
to be made to the way the AppDelegate currently executes. Unit tests then need to be added to make sure this flow 
is not inadvertently broken in the future.

## Changes to injectWith... #

AppDelegate invokes the AppFactory with itself as the back reference. The AppFactory method in turns calls into the 
AppDelegate's injectable method. We use this method since we do not have a straightforward means to construct the AppDelegate 
ourselves. This method is really only for setting dependencies and should not be overloaded with additional bootstrap 
logic as it is today.

This will require moving the following pieces into their own methods:

* Logic to decide if the application needs to be reset
* Logic to set root view controller
* Logic to request crumbs or launch the FTU flow

Currently the crumbs are retrieved by making a delegate call to sessionManagerDidSucceed. For the sake of clarity, a new 
method should be added which is properly named and has a single focus - retrieving crumbs. The sessionManagerDidSucceed 
method should call this new method.

## Changes to application:didFinishLaunchingWithOptions:

After the AppDelegate gets injected with its dependencies, it should call the newly created methods to reset the application 
if required and request crumbs or launch the FTU flow. These operations should be method calls, not just a paste of the existing 
logic from injectWith... into application:didFinishLaunchingWithOptions.

## Refactoring of registerOrVerify #

Currently the AppDelegate has an inappropriately named method that is used to either take the user from the login to registration 
during the FTU flow, or silently complete the crumb retrieval process. This method should be renamed to make its intentions clear. 

## Changes to crumbService:didReceiveCrumb:guid: #

After the crumb and guid have been set on authInfoProvider, the new method to set the root view controller needs to be called. 
Setting the root view controller, which in turn causes the conversation list view controller to be loaded, needs to be done 
after the crumbs have been retrieved.

Once the root view controller is set the newly renamed version of registerOrVerify needs to be called.

## Launching the FTU Flow #

The newly added method which launches the FTU flow will also need to call the new method to set the root view controller before 
presenting the login view controller as a modal view controller. One gotcha is that when the tab bar controller is set as the 
root view controller, the conversation list view controller will attempt to load conversations. If possible this should be 
avoided when launching the FTU flow.

## Unit tests to add

Since the AppDelegate is critical to the application launching successfully we should add unit tests for the steps 
it will take.

Below are some examples of things we should test. Please do not consider this an exhaustive list.

* method to reset application works if reset was selected
* method to reset application works if registration did not complete successfully
* method to reset application does nothing if reset was not selected and registration succeeded
* root view controller is set before login screen is presented
* root view controller is set once crumbs are received
* ftu flow is launched if no user exists
* registration did complete flag is set to YES after the user profile screen is dismissed
* registration did complete flag is set to NO before registration begins
* during ftu flow, crumbs are requested after the user logs in

## APNS/Push Notifications #

In the very near future our application will need to register for push notifications. Doing so should happen after a 
successful login. Once login is complete the session manager delegate sessionManagerDidSucceed: is called. Registering 
for push here will provide an easy post login hook.