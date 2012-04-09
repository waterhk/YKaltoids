//
//  YAParticipantInfoViewController.h
//  altoids
//
//  Created by Jon Herron on 10/28/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantInfoViewController.h"
#import "ParticipantNameFormatter.h"
#import "MutableArrayCreator.h"
#import "AddressHandleFormatter.h"
#import "UIAlertViewDismisser.h"
#import "UIAlertViewFactory.h"
#import "UIAlertViewSelectionDetector.h"
#import "ConversationRepository.h"
#import "ContactLocator.h"
#import "YAParticipant.h"
#import "ParticipantHandler.h"
#import "PersonImageObserverCreator.h"
#import "ParticipantRepository.h"
#import "ImageScaler.h"
#import "ConversationComposeDelegate.h"
#import "ContactRepositorySubscriber.h"

@protocol ConversationComposeViewControllerInstanceFactory;
@protocol ConversationMessageListViewControllerCreator;
@protocol ContactRepository, NavigationBarButtonItemRepository, ParticipantInfoCreator;

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAParticipantInfoViewController : UITableViewController <ParticipantInfoViewController, ConversationComposeDelegate, ContactRepositorySubscriber>

#pragma mark @property declarations
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<ParticipantNameFormatter> participantNameFormatter;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<AddressHandleFormatter> addressHandleFormatter;
@property (strong, nonatomic) id<UIAlertViewDismisser> uiAlertViewDismisser;
@property (strong, nonatomic) id<UIAlertViewFactory> uiAlertViewFactory;
@property (strong, nonatomic) id<UIAlertViewSelectionDetector> uiAlertViewSelectionDetector;
@property (strong, nonatomic) id<ConversationRepository> conversationRepository;
@property (strong, nonatomic) id<ContactLocator> contactLocator;
@property (strong, nonatomic) id<ParticipantInfoCreator> participantInfoCreator;
@property (strong, nonatomic) id<ParticipantRepository> participantRepository;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (strong, nonatomic) id<ConversationComposeViewControllerInstanceFactory> conversationComposeViewControllerInstanceFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<ConversationMessageListViewControllerCreator> conversationMessageListViewControllerCreator;

@property (strong, nonatomic) IBOutlet UIButton *addParticipantAsContactButton;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithNibName:(NSString*)theNibName bundle:(NSBundle*)theBundle participant:(YAParticipant *)participant managedObjectContext:(NSManagedObjectContext*)managedObjectContext;

- (void)setPersonImageObserverCreator:(id<PersonImageObserverCreator>)personImageObserverCreator;

- (IBAction)addParticipantAsContact:(id)sender;

@end
