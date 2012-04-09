//
//  YAUserProfileImageUpdateParsedJSONResponseHandlerCreator.h
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectContextFactory.h"
#import "UserProfileHandler.h"
#import "UserProfileImageUpdateParsedJSONResponseHandlerCreator.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileImageUpdateParsedJSONResponseHandlerCreator : NSObject<UserProfileImageUpdateParsedJSONResponseHandlerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
