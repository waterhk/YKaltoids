//
//  YAConversationManagementURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Jon Herron on 10/24/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationManagementURLWithURLParametersBuilderCreator.h"
#import "MMCRelativeURICreator.h"
#import "MMCURLCreator.h"
#import "ManagedObjectContextFactory.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationManagementURLWithURLParametersBuilderCreator : NSObject <ConversationManagementURLWithURLParametersBuilderCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<MMCURLCreator> mmcURLCreator;
@property (strong, nonatomic) id<MMCRelativeURICreator> mmcRelativeURICreator;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
