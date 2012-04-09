//
//  YAConversationDetailsViewController.h
//  altoids
//
//  Created by Jon Herron on 10/27/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationDetailsViewController.h"
#import "AppFactory.h"
#import "MutableArrayCreator.h"
#import "ParticipantDescriptionBuilder.h"
#import "ParticipantNameFormatter.h"
#import "ParticipantHandler.h"
#import "PersonImageObserverCreator.h"
#import "YAConversation.h"
#import "ConversationRepository.h"
#import "ConversationFetchRequestCreator.h"
#import "ConversationHandler.h"
#import "ParticipantRepository.h"
#import "PersonImageObserverCreator.h"
#import "ImageScaler.h"
#import "ConversationLocator.h"
#import "ContactRepositorySubscriber.h"
#import "ContactPickerViewControllerDelegate.h"

@protocol NavigationBarButtonItemRepository, ContactRepository, ParticipantInfoCreator, ContactPickerViewControllerInstanceFactory;

@interface YAConversationDetailsViewController : UITableViewController <ConversationDetailsViewController, ContactRepositorySubscriber, ContactPickerViewControllerDelegate>

@property (strong, nonatomic) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;
@property (strong, nonatomic) id<ParticipantNameFormatter> participantNameFormatter;
@property (strong, nonatomic) id<ParticipantHandler> participantHandler;
@property (strong, nonatomic) id<ParticipantInfoViewControllerInstanceFactory> participantInfoViewControllerInstanceFactory;
@property (strong, nonatomic) id<ConversationRepository> conversationRepository;
@property (strong, nonatomic) id<ConversationFetchRequestCreator> conversationFetchRequestCreator;
@property (strong, nonatomic) id<ConversationHandler> conversationHandler;
@property (strong, nonatomic) NSArray* sortDescriptors;
@property (strong, nonatomic) id<ParticipantRepository> participantRepository;
@property (strong, nonatomic) id<ParticipantInfoCreator> participantInfoCreator;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (strong, nonatomic) id<ConversationLocator> conversationLocator;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<ContactPickerViewControllerInstanceFactory> contactPickerViewControllerInstanceFactory;

@property (strong, nonatomic) IBOutlet UISwitch *muteConversationSwitch;


- (id)initWithNibName:(NSString *)theNibName 
               bundle:(NSBundle *)theBundle
         conversation:(YAConversation *)theConversation
 managedObjectContext:(NSManagedObjectContext*)theManagedObjectContext;

- (void)setPersonImageObserverCreator:(id<PersonImageObserverCreator>)personImageObserverCreator;
- (IBAction)muteConversationSwitchValueChanged:(id)sender;

@end
