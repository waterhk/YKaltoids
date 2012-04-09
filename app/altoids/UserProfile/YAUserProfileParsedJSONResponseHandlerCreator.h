//
//  YAUserProfileParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileParsedJSONResponseHandlerCreator.h"
#import "UserProfileHandler.h"
#import "UserProfileErrorHandlerFactory.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileParsedJSONResponseHandlerCreator : NSObject<UserProfileParsedJSONResponseHandlerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) id<UserProfileErrorHandlerFactory> userProfileErrorHandlerFactory;

#pragma mark  Class methods

#pragma mark Instance methods

@end
