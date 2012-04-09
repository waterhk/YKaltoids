//
//  YAContactDetailViewController.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactDetailViewController.h"
#import "ContactDetailTableViewDataSourceDelegate.h"
#import "ConversationComposeDelegate.h"
@protocol ContactDetailTableViewDataSourceInstanceFactory, ContactDetailTableViewDataSource, ConversationComposeViewControllerInstanceFactory, ConversationMessageListViewControllerCreator, ParticipantInfoCreator;
@class YAContact;

@interface YAContactDetailViewController : UITableViewController <ContactDetailViewController, ContactDetailTableViewDataSourceDelegate, ConversationComposeDelegate>

@property (nonatomic, strong) id<ContactDetailTableViewDataSource> dataSource;

// operational parameters
@property (nonatomic, strong) YAContact* contact;

// injected dependencies
@property (nonatomic, strong) id<ContactDetailTableViewDataSourceInstanceFactory> contactDetailTableViewDataSourceInstanceFactory;
@property (nonatomic, strong) id<ConversationComposeViewControllerInstanceFactory> conversationComposeViewControllerInstanceFactory;
@property (nonatomic, strong) id<ConversationMessageListViewControllerCreator> conversationMessageListViewControllerCreator;
@property (nonatomic, strong) id<ParticipantInfoCreator> participantInfoCreator;

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil contact:(YAContact*)contact;

@end
