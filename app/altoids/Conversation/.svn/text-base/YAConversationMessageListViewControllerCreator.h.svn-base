//
//  YAConversationMessageListViewControllerCreator.h
//  altoids
//
//  Created by Jon Herron on 10/19/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppFactory.h"
#import "ConversationMessageListViewControllerCreator.h"
#import "ParticipantDescriptionBuilder.h"
#import "MutableArrayCreator.h"

@protocol NavigationBarButtonItemRepository, ContactRepository;

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationMessageListViewControllerCreator : NSObject <ConversationMessageListViewControllerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) NSString *nibName;
@property (strong, nonatomic) NSBundle *nibBundle;
@property (strong, nonatomic) id<ParticipantDescriptionBuilder> participantDescriptionBuilder;
@property (strong, nonatomic) id<ConversationDetailsViewControllerInstanceFactory> conversationDetailsViewControllerInstanceFactory;
@property (strong, nonatomic) id<NavigationBarButtonItemRepository> navigationBarButtonItemRepository;
@property (strong, nonatomic) id<ContactRepository> contactRepository;
@property (strong, nonatomic) id<MutableArrayCreator> mutableArrayCreator;

@property (strong, nonatomic) id<ConversationMessageListViewControllerInstanceFactory> conversationMessageListViewControllerInstanceFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
