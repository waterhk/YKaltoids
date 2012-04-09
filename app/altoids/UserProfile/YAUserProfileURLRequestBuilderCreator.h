//
//  YAUserProfileURLRequestBuilderCreator.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileURLRequestBuilderCreator.h"
#import "UserProfileUpdateURLWithURLParametersBuilderCreator.h"
#import "UserProfileImageUpdateURLWithURLParametersBuilderCreator.h"
#import "URLRequestBuilderComposer.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileURLRequestBuilderCreator : NSObject<UserProfileURLRequestBuilderCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<UserProfileUpdateURLWithURLParametersBuilderCreator> userProfileUpdateURLWithURLParametersBuilderCreator;
@property (strong, nonatomic) id<UserProfileImageUpdateURLWithURLParametersBuilderCreator> userProfileImageUpdateURLWithURLParametersBuilderCreator;
@property (strong, nonatomic) id<URLRequestBuilderComposer> urlRequestBuilderComposer;

#pragma mark  Class methods

#pragma mark Instance methods

@end
