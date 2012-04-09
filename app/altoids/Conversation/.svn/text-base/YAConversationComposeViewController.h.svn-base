//
//  YAConversationComposeViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConversationComposeViewController.h"

#import "TokenViewDelegate.h"
#import "ConversationRepository.h"
#import "ConversationComposeDelegate.h"
#import "ParticipantPickerDelegate.h"
#import "ViewControllerContainer.h"
#import "ParticipantNameFormatter.h"
#import "ParticipantDescriptionBuilder.h"
#import "RegistrationRepository.h"
#import "YAMessageComposeView.h"
#import "MessageComposeViewDelegate.h"
#import "ContactPickerViewControllerDelegate.h"
#import "SMSAddressHandleFormatValidator.h"

@protocol NavigationBarButtonItemRepository, ParticipantInfoCreator;
@protocol ParticipantPickerViewControllerInstanceFactory, ParticipantPickerViewController, ContactPickerViewControllerInstanceFactory;
@protocol InvalidTokenSelectorViewControllerInstanceFactory, InvalidTokenSelectorViewController;
@protocol ManagedObjectContextFactory;
@class YATokenView;

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationComposeViewController : UIViewController <ConversationComposeViewController, TokenViewDelegate, ParticipantPickerDelegate, ViewControllerAccessor, MessageComposeViewDelegate, ContactPickerViewControllerDelegate>

#pragma mark @property declarations

@property (strong, nonatomic) id<ConversationRepository> conversationRepository;
@property (strong, nonatomic) id<ViewControllerContainer> navigationControllerContainer;
@property (strong, nonatomic) id<ParticipantNameFormatter> participantNameFormatter;
@property (strong, nonatomic) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (strong, nonatomic) id<ParticipantInfoCreator> participantInfoCreator;
@property (strong, nonatomic) id<ContactPickerViewControllerInstanceFactory> contactPickerViewControllerInstanceFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<ParticipantPickerViewControllerInstanceFactory> participantPickerViewControllerInstanceFactory;
@property (strong, nonatomic) id<InvalidTokenSelectorViewControllerInstanceFactory> invalidTokenSelectorViewControllerInstanceFactory;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<SMSAddressHandleFormatValidator> smsAddressHandleFormatValidator;

@property (strong, nonatomic, readonly) id<ParticipantPickerViewController> participantPicker;
 
@property (strong, nonatomic) id<RegistrationRepository> registrationRepository;

@property (strong, nonatomic, readonly) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic, readonly) IBOutlet UIScrollView *containerView;
@property (strong, nonatomic, readonly) IBOutlet YATokenView *tokenView;
@property (strong, nonatomic, readonly) IBOutlet UIButton *multipleParticipantPickerBtn;
@property (strong, nonatomic) IBOutlet YAMessageComposeView *messageComposeView;

#pragma mark  Class methods

#pragma mark Instance methods

- (id)initWithNibName:(NSString*)nibNameOrNil 
               bundle:(NSBundle*)nibBundleOrNil
             delegate:(id<ConversationComposeDelegate>)theDelegate;

- (IBAction)pickMultipleParticipants:(id)sender;

@end
