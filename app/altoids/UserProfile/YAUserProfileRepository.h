//
//  YAUserProfileRepository.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileRepository.h"
#import "UserProfileHandler.h"
#import "ManagedObjectContextFactory.h"
#import "UserProfileCommandFactory.h"
#import "CommandQueue.h"
#import "ProfileErrorCreator.h"
#import "UserProfileUpdateCommandDelegate.h"
#import "PersonImageRepository.h"
#import "PersonImageHandler.h"
#import "ImageTransformer.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileRepository : NSObject<UserProfileRepository, UserProfileUpdateCommandDelegate>

#pragma mark @property declarations
@property (strong, readwrite, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) id<PersonImageRepository> personImageRepository;
@property (strong, nonatomic) id<PersonImageHandler> personImageHandler;
@property (strong, nonatomic) id<ImageTransformer> imageTransformer;
@property (strong, readwrite, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<UserProfileCommandFactory> userProfileCommandFactory;
@property (strong, nonatomic) id<CommandQueue> mmcCommandQueue;
@property (strong, nonatomic) id<ProfileErrorCreator> profileErrorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
