//
//  YAConversationCreateURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Jon Herron on 10/10/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConversationCreateURLWithURLParametersBuilder.h"
#import "MMCRelativeURICreator.h"
#import "MMCURLCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAConversationCreateURLWithURLParametersBuilder : NSObject <ConversationCreateURLWithURLParametersBuilder>

#pragma mark @property declarations
@property (strong, nonatomic) id<MMCURLCreator> mmcURLCreator;
@property (strong, nonatomic) id<MMCRelativeURICreator> mmcRelativeURICreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
