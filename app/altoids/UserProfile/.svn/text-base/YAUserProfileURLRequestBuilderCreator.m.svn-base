//
//  YAUserProfileURLRequestBuilderCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileURLRequestBuilderCreator.h"

// Private class extension
@interface YAUserProfileURLRequestBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileURLRequestBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize userProfileUpdateURLWithURLParametersBuilderCreator = userProfileUpdateURLWithURLParametersBuilderCreator_;
@synthesize urlRequestBuilderComposer = urlRequestBuilderComposer_;
@synthesize userProfileImageUpdateURLWithURLParametersBuilderCreator = userProfileImageUpdateURLWithURLParametersBuilderCreator_;
// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileURLRequestBuilderCreator delegate methods

- (id<URLRequestBuilder>)createUserProfileURLRequestBuilderForUpdatingNameAndPermissionForUser:(YAUser *)theUser
{
    return [[self urlRequestBuilderComposer] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:[[self userProfileUpdateURLWithURLParametersBuilderCreator] createWithUser:theUser]];
}

- (id<URLRequestBuilder>)createUserProfileURLRequestBuilderForUpdatingImageForUser:(YAUser *)theUser
{
    id<UserProfileImageUpdateURLWithURLParametersBuilder> profileImageUpdateURLWithURLParametersBuilder = 
    [[self userProfileImageUpdateURLWithURLParametersBuilderCreator] createWithUser:theUser];
    return [[self urlRequestBuilderComposer] composeMultipartPostRequestUsingURLWithURLParametersBuilder:profileImageUpdateURLWithURLParametersBuilder];
}

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserProfileURLRequestBuilderCreator ()

@end
