//
//  YAUserProfileImageUpdateURLWithURLParametersBuilder.h
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ManagedObjectContextFactory.h"
#import "ProfileRelativeURICreator.h"
#import "ProfileURLCreator.h"
#import "UserProfileImageUpdateURLWithURLParametersBuilder.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileImageUpdateURLWithURLParametersBuilder : NSObject<UserProfileImageUpdateURLWithURLParametersBuilder>

#pragma mark @property declarations

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithProfileURLCreator:(id<ProfileURLCreator>)theMMCURLCreator profileRelativeURICreator:(id<ProfileRelativeURICreator>)theMMCRelativeURICreator
                   userObjectID:(NSManagedObjectID *)userObjectID managedObjectContextFactory:(id<ManagedObjectContextFactory>)managedObjectContextFactory;
@end
