//
//  YAUserProfileImageUpdateURLWithURLParametersBuilderCreator.h
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectContextFactory.h"
#import "ProfileRelativeURICreator.h"
#import "ProfileURLCreator.h"
#import "UserProfileImageUpdateURLWithURLParametersBuilderCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileImageUpdateURLWithURLParametersBuilderCreator : NSObject<UserProfileImageUpdateURLWithURLParametersBuilderCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<ProfileRelativeURICreator> profileRelativeURICreator;
@property (strong, nonatomic) id<ProfileURLCreator> profileURLCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
