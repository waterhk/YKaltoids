//
//  YAContactDetailViewController.m
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactDetailViewController.h"
#import "AppFactory.h"
#import "ContactDetailTableViewDataSource.h"
#import "ConversationComposeViewController.h"
#import "ConversationMessageListViewControllerCreator.h"
#import "ParticipantInfoCreator.h"


@implementation YAContactDetailViewController

@synthesize dataSource = dataSource_,
            contact = contact_;
@synthesize contactDetailTableViewDataSourceInstanceFactory = contactDetailTableViewDataSourceInstanceFactory_,
            conversationComposeViewControllerInstanceFactory = conversationComposeViewControllerInstanceFactory_,
            conversationMessageListViewControllerCreator = conversationMessageListViewControllerCreator_,
            participantInfoCreator = participantInfoCreator_;


- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil contact:(YAContact*)contact
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        contact_ = contact;
    }
    return self;
}

- (void) viewDidLoad
{
    [[self navigationItem] setTitle:kContactViewTitle];
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    dataSource_ = [contactDetailTableViewDataSourceInstanceFactory_ createContactDetailTableViewDataSourceWithDelegate:self contact:contact_ selectedAddress:nil];
    [[self tableView] setDataSource:dataSource_];
    [dataSource_ load];

    [super viewWillAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[self tableView] setDataSource:nil];
    [dataSource_ unload];
    dataSource_ = nil;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [dataSource_ didReceiveMemoryWarning];
}

- (void) dealloc
{
    [dataSource_ clearDelegate:self];
}


#pragma mark ViewControllerAccessor methods

- (UIViewController*) viewController
{
    return self;
}


#pragma mark - Table view delegate

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    YAContactEndpoint* contactEndpoint = [dataSource_ contactEndpointForIndexPath:indexPath];
    if(!contactEndpoint)
    {
        return;
    }

    YAParticipantInfo* participantInfo = [participantInfoCreator_ participantInfoWithContactEndpoint:contactEndpoint];
    
    id<ConversationComposeViewController> conversationComposeViewController = [conversationComposeViewControllerInstanceFactory_ createConversationComposeViewControllerWithDelegate:self];
    if(!conversationComposeViewController)
    {
        return;
    }
    
    [conversationComposeViewController setParticipants:[NSArray arrayWithObject:participantInfo]];
    
    [self presentModalViewController:[conversationComposeViewController viewController] animated:YES];
}


#pragma mark ConversationComposeDelegate methods

- (void) conversationComposeViewController:(id<ViewControllerAccessor>)conversationComposeViewController didFinishWithResult:(YAComposeResult)result conversation:(YAConversation*)conversation
{
    [[conversationComposeViewController viewController] dismissModalViewControllerAnimated:YES];
    
    if(result == YAComposeResultCancelled || !conversation)
    {
        return;
    }
    
    id<ViewControllerAccessor> conversationMessageListViewControllerAccessor = [conversationMessageListViewControllerCreator_ createWithConversation:conversation];
    if(!conversationMessageListViewControllerAccessor)
    {
        return;
    }
    
    [[self navigationController] pushViewController:[conversationMessageListViewControllerAccessor viewController] animated:YES];
}


#pragma mark ContactDetailTableViewDataSource methods

- (void) contactDetailTableViewDataSource:(id<ContactDetailTableViewDataSource>)dataSource didLoadContact:(YAContact*)contact
{
    contact_ = contact;
    [[self tableView] reloadData];
}


@end
