//
//  YAProfileRelativeURICreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAProfileRelativeURICreator.h"

#define kUserProfileRelativeURIFormat @"v1/user/%@/profile"

// Private class extension
@interface YAProfileRelativeURICreator ()

// @property definitions

// methods

@end

@implementation YAProfileRelativeURICreator

// Class methods
#pragma mark -
#pragma mark Class methods

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize userProfileHandler = userProfileHandler_;

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

- (NSString *)createRelativeURIToUpdateProfileNameWithPermissionForUser:(YAUser *)theUser
{
    return [NSString stringWithFormat:kUserProfileRelativeURIFormat,[[self userProfileHandler] guidForUser:theUser]];
}

- (NSString *)createRelativeURIToUpdateProfileImageForUser:(YAUser *)theUser
{
    NSString *formatString = [NSString stringWithFormat:@"%@/imagepool", kUserProfileRelativeURIFormat];
    return [NSString stringWithFormat:formatString, [[self userProfileHandler] guidForUser:theUser]];
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
#pragma mark YAProfileRelativeURICreator ()

@end
