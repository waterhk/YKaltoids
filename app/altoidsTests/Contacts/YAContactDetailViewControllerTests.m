//
//  YAContactDetailViewControllerTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import <objc/runtime.h>
#import "AppFactory.h"
#import "YAContactDetailViewController.h"
#import "ContactDetailTableViewDataSource.h"
#import "ConversationComposeViewController.h"
#import "ConversationMessageListViewControllerCreator.h"
#import "ParticipantInfoCreator.h"
#import "MessageListViewController.h"
#import "YAContact.h"
#import "YAParticipantInfo.h"
#import "YAConversation.h"
#import "YAContactEndpoint.h"

@interface YAContactDetailViewControllerTests : YATestCase
{
    YAContactDetailViewController* vc;
    id dataSourceInstanceFactoryMock;
    id composeVCInstanceFactoryMock;
    id participantInfoCreatorMock;
    id messageListVCCreatorMock;

    id dataSourceMock;
    id dataSourceNiceMock;
    id tableViewMock;
    
    YAContact* testContact;
    YAContactEndpoint* testContactEndpoint;
    YAParticipantInfo* testParticipantInfo;
    id testConversationMock;
}
@end

@implementation YAContactDetailViewControllerTests

- (void) setUp
{
    dataSourceInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(ContactDetailTableViewDataSourceInstanceFactory)];
    composeVCInstanceFactoryMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewControllerInstanceFactory)];
    participantInfoCreatorMock = [OCMockObject mockForProtocol:@protocol(ParticipantInfoCreator)];
    messageListVCCreatorMock = [OCMockObject mockForProtocol:@protocol(ConversationMessageListViewControllerCreator)];

    dataSourceMock = [OCMockObject mockForProtocol:@protocol(ContactDetailTableViewDataSource)];
    dataSourceNiceMock = [OCMockObject niceMockForProtocol:@protocol(ContactDetailTableViewDataSource)];
    tableViewMock = [OCMockObject mockForClass:[UITableView class]];

    testConversationMock = [OCMockObject mockForClass:[YAConversation class]];
    testContact = [[YAContact alloc] init];
    testContactEndpoint = [[YAContactEndpoint alloc] init];
    testParticipantInfo = [[YAParticipantInfo alloc] init];

    vc = [[YAContactDetailViewController alloc] init];  // we can't use the real initter, or it will require fully stubbing an NSBundle
    [vc setContact:testContact];
    [vc setContactDetailTableViewDataSourceInstanceFactory:dataSourceInstanceFactoryMock];
    [vc setConversationComposeViewControllerInstanceFactory:composeVCInstanceFactoryMock];
    [vc setParticipantInfoCreator:participantInfoCreatorMock];
    [vc setConversationMessageListViewControllerCreator:messageListVCCreatorMock];
}


//
// initWithNibName:bundle:contact:
//

- (void) testInitWithNibNameBundleContactShouldSetProperties
{
    NSString* testNibName = @"test nib name";
    NSBundle* testBundle = [[NSBundle alloc] init];
    
    vc = [[YAContactDetailViewController alloc] initWithNibName:testNibName bundle:testBundle contact:testContact];

    STAssertEquals(testNibName, [vc nibName], nil);
    STAssertEquals(testBundle, [vc nibBundle], nil);
    STAssertEquals(testContact, [vc contact], nil);
}

//
// viewDidLoad
//

- (void) testViewDidLoadShouldSetTitleToContact_Info
{
    [vc tableView];         // this causes viewDidLoad to be invoked, without unnaturally making viewDidLoad reentrant as a result of the [self tableView] in it
    STAssertEquals(kContactViewTitle, [[vc navigationItem] title], nil);
}

//
// viewWillAppear
//

- (void) testViewWillAppearShouldCreateDataSourceWithInitedContactAndSetsAsDataSourceProperty
{
    [[[dataSourceInstanceFactoryMock expect] andReturn:dataSourceNiceMock] createContactDetailTableViewDataSourceWithDelegate:vc contact:testContact selectedAddress:nil];

    [vc viewWillAppear:YES];
    STAssertEquals(dataSourceNiceMock, [vc dataSource], nil);
    [dataSourceInstanceFactoryMock verify];
}

- (void) testViewWillAppearShouldSetDataSourceOfTableViewAndLoadDataSource
{
    [[[dataSourceInstanceFactoryMock stub] andReturn:dataSourceNiceMock] createContactDetailTableViewDataSourceWithDelegate:vc contact:testContact selectedAddress:nil];
    [(id<ContactDetailTableViewDataSource>)[dataSourceNiceMock expect] load];

    [vc viewWillAppear:YES];
    STAssertEquals(dataSourceNiceMock, [[vc tableView] dataSource], nil);
    [dataSourceNiceMock verify];
}

//
// viewDidDisappear
//

- (void) testViewDidDisappearShouldNilDataSourceOfTableView
{
    [vc setDataSource:dataSourceNiceMock];
    [[vc tableView] setDataSource:dataSourceNiceMock];
    
    [vc viewDidDisappear:YES];
    STAssertNil([[vc tableView] dataSource], nil);
}

- (void) testViewDidDisappearShouldNilDataSourceProperty
{
    [vc setDataSource:dataSourceNiceMock];
    [[vc tableView] setDataSource:dataSourceNiceMock];
    
    [vc viewDidDisappear:YES];
    STAssertNil([vc dataSource], nil);
}

- (void) testViewDidDisappearShouldUnloadDataSource
{
    [(id<ContactDetailTableViewDataSource>)[dataSourceMock expect] unload];
    [vc setDataSource:dataSourceMock];

    [vc viewDidDisappear:YES];
    [dataSourceMock verify];
}

//
// didReceiveMemoryWarning
//

- (void) testViewDidReceiveMemoryWarningShouldNotifyDataSource
{
    [[dataSourceMock expect] didReceiveMemoryWarning];
    [vc setDataSource:dataSourceMock];
    
    [vc didReceiveMemoryWarning];
    [dataSourceMock verify];
}

//
// viewController
//

- (void) testViewControllerDoesReturnSelf
{
    STAssertEquals(vc, [vc viewController], nil);
}

//
// contactDetailTableViewDataSource:didLoadContact
//

- (void) testContactDetailTableViewDataSourceDidLoadContactShouldUpdateContactProperty
{
    YAContact* newContact = [[YAContact alloc] init];
    [vc contactDetailTableViewDataSource:nil didLoadContact:newContact];
    STAssertEquals(newContact, [vc contact], nil);
}

- (void) testContactDetailTableViewDataSourceDidLoadContactShouldReloadTableView
{
    [[tableViewMock expect] reloadData];

    [self swizzleSelector:@selector(tableView)
                  inClass:[YAContactDetailViewController class]
                withBlock:^(id self) { return tableViewMock; }
               asSelector:@selector(tableView)
                  inClass:[self class]
             executeBlock:^(void)
     {
         [vc contactDetailTableViewDataSource:nil didLoadContact:nil];
     }];
}


//
// tableViewDidSelectRowAtIndexPath
//

- (void) testTableViewDidSelectRowAtIndexPathShouldDeselectRowAndNotPresentModalVCWhenNoContactEndpointForGivenIndexPath
{
    NSIndexPath* indexPath = [[NSIndexPath alloc] init];

    [[tableViewMock expect] deselectRowAtIndexPath:indexPath animated:YES];
    [[[dataSourceMock expect] andReturn:nil] contactEndpointForIndexPath:indexPath];

    [vc setDataSource:dataSourceMock];

    [vc tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
    
    [dataSourceMock verify];
    [tableViewMock verify];
}

- (void) testTableViewDidSelectRowAtIndexPathShouldDeselectRowAndNotDieWhenComposeVCCannotBeCreated
{
    NSIndexPath* indexPath = [[NSIndexPath alloc] init];
    
    [[tableViewMock expect] deselectRowAtIndexPath:indexPath animated:YES];
    [[[dataSourceMock stub] andReturn:testContactEndpoint] contactEndpointForIndexPath:OCMOCK_ANY];
    [[participantInfoCreatorMock stub] participantInfoWithContactEndpoint:OCMOCK_ANY];
    [[[composeVCInstanceFactoryMock expect] andReturn:nil] createConversationComposeViewControllerWithDelegate:vc];

    [vc setDataSource:dataSourceMock];
    
    [vc tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
    
    [dataSourceMock verify];
    [tableViewMock verify];
}

- (void) testTableViewDidSelectRowAtIndexPathShouldDeselectRowAndPresentModalComposeVCWithSelfAsDelegateAndParticipantInfoCreatedWithContactEndpointFromDataSource
{
    NSIndexPath* indexPath = [[NSIndexPath alloc] init];
    NSArray* arrayOfParticipantInfo = [NSArray arrayWithObject:testParticipantInfo];
    id composeVCMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewController)];
    UIViewController* composeVC = [[UIViewController alloc] init];

    [[tableViewMock expect] deselectRowAtIndexPath:indexPath animated:YES];
    [[[dataSourceMock expect] andReturn:testContactEndpoint] contactEndpointForIndexPath:indexPath];
    [[[participantInfoCreatorMock expect] andReturn:testParticipantInfo] participantInfoWithContactEndpoint:testContactEndpoint];
    [[[composeVCInstanceFactoryMock expect] andReturn:composeVCMock] createConversationComposeViewControllerWithDelegate:vc];
    [[composeVCMock expect] setParticipants:arrayOfParticipantInfo];
    [[[composeVCMock expect] andReturn:composeVC] viewController];

    [vc setDataSource:dataSourceMock];
    
    // We must method swizzle to verify modal VC presentation because:
    // - the VC uses a base class method to modally present the compose VC, so I have no seam to mock and set an expectation to verify that the VC presents the compose VC
    // - in our unit test environment, presentModalViewController doesn't set the presentedViewController or modalViewController properties, so I can't verify it through side effects.
    __block UIViewController* swizzledPresentingViewController;
    id swizzler = ^(id self, UIViewController* viewController, BOOL animated)
    {
        swizzledPresentingViewController = viewController;
    };
    [self swizzleSelector:@selector(presentModalViewController:animated:) inClass:[YAContactDetailViewController class] withBlock:swizzler asSelector:@selector(presentModalViewController:animated:) inClass:[self class] executeBlock:^(void)
     {
         [vc tableView:tableViewMock didSelectRowAtIndexPath:indexPath];
     }];

    STAssertEquals(composeVC, swizzledPresentingViewController, nil);
    [dataSourceMock verify];
    [tableViewMock verify];
    [composeVCInstanceFactoryMock verify];
    [composeVCMock verify];
}

//
// conversationComposeViewController:didFinishWithResult:conversation:
//

- (void) testConversationComposeViewControllerDidFinishWithResultConversationShouldDismissComposeVCAndNotShowMessageListVCWhenComposeWasCancelled
{
    id composeVCMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewController)];
    id composeVCAccessorVCMock = [OCMockObject mockForClass:[UIViewController class]];

    [[[composeVCMock expect] andReturn:composeVCAccessorVCMock] viewController];
    [[composeVCAccessorVCMock expect] dismissModalViewControllerAnimated:YES];
    
    [vc conversationComposeViewController:composeVCMock didFinishWithResult:YAComposeResultCancelled conversation:testConversationMock];
    [composeVCMock verify];
    [composeVCAccessorVCMock verify];
}

- (void) testConversationComposeViewControllerDidFinishWithResultConversationShouldDismissComposeVCAndNotShowMessageListVCWhenComposeWasNotCancelledButGiveNoConversation
{
    id composeVCMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewController)];
    id composeVCAccessorVCMock = [OCMockObject mockForClass:[UIViewController class]];
    
    [[[composeVCMock expect] andReturn:composeVCAccessorVCMock] viewController];
    [[composeVCAccessorVCMock expect] dismissModalViewControllerAnimated:YES];
    
    [vc conversationComposeViewController:composeVCMock didFinishWithResult:YAComposeResultFailed conversation:nil];
    [composeVCMock verify];
    [composeVCAccessorVCMock verify];
}

- (void) testConversationComposeViewControllerDidFinishWithResultConversationShouldDismissComposeVCAndNotDieWhenMessageListVCCannotBeCreated
{
    id composeVCMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewController)];
    id composeVCAccessorVCMock = [OCMockObject mockForClass:[UIViewController class]];
    
    [[[composeVCMock expect] andReturn:composeVCAccessorVCMock] viewController];
    [[composeVCAccessorVCMock expect] dismissModalViewControllerAnimated:YES];
    [[[messageListVCCreatorMock expect] andReturn:nil] createWithConversation:testConversationMock];
    
    [vc conversationComposeViewController:composeVCMock didFinishWithResult:YAComposeResultSent conversation:testConversationMock];
    [composeVCMock verify];
    [composeVCAccessorVCMock verify];
    [messageListVCCreatorMock verify];
}

- (void) testConversationComposeViewControllerDidFinishWithResultConversationShouldDismissComposeVCAndPushMessageListVCForGivenConversationWhenConversationIsSent
{
    id composeVCMock = [OCMockObject mockForProtocol:@protocol(ConversationComposeViewController)];
    id composeVCAccessorVCMock = [OCMockObject mockForClass:[UIViewController class]];
    id messageListVCMock = [OCMockObject mockForProtocol:@protocol(MessageListViewController)];
    id messageListVCAccessorVCMock = [OCMockObject mockForClass:[UIViewController class]];
    id navigationControllerMock = [OCMockObject mockForClass:[UINavigationController class]];

    [[[composeVCMock expect] andReturn:composeVCAccessorVCMock] viewController];
    [[composeVCAccessorVCMock expect] dismissModalViewControllerAnimated:YES];
    [[[messageListVCCreatorMock expect] andReturn:messageListVCMock] createWithConversation:testConversationMock];
    [[[messageListVCMock expect] andReturn:messageListVCAccessorVCMock] viewController];
    [[navigationControllerMock expect] pushViewController:messageListVCAccessorVCMock animated:YES];

    // We have to swizzle to inject our own navigation controller; there's no seam to verify that we've pushed the new VC onto it
    id swizzler = (^UINavigationController*() { return navigationControllerMock; });
    [self swizzleSelector:@selector(navigationController) inClass:[YAContactDetailViewController class] withBlock:swizzler asSelector:@selector(navigationController) inClass:[self class] executeBlock:^(void)
     {
         [vc conversationComposeViewController:composeVCMock didFinishWithResult:YAComposeResultSent conversation:testConversationMock];
     }];

    [composeVCMock verify];
    [composeVCAccessorVCMock verify];
    [messageListVCCreatorMock verify];
    [messageListVCMock verify];
    [messageListVCAccessorVCMock verify];
    [navigationControllerMock verify];
}

@end
