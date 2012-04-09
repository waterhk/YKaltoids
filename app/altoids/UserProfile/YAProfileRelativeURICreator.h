//
//  YAProfileRelativeURICreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileRelativeURICreator.h"
#import "UserProfileHandler.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAProfileRelativeURICreator : NSObject<ProfileRelativeURICreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;

#pragma mark  Class methods

#pragma mark Instance methods

@end
