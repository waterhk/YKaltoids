//
//  YAUserProfileUpdateURLWithURLParametersBuilderCreator.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileUpdateURLWithURLParametersBuilderCreator.h"
#import "YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder.h"

// Private class extension
@interface YAUserProfileUpdateURLWithURLParametersBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileUpdateURLWithURLParametersBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileURLCreator = profileURLCreator_;
@synthesize profileRelativeURICreator = profileRelativeURICreator_;
@synthesize managedObjectContextFactory = managedObjectContextFactory_;

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
#pragma mark <Protocol Name> delegate methods

- (id<UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder>)createWithUser:(YAUser *)theUser
{
    return [[YAUserProfileUpdateNameWithPermissionURLWithURLParametersBuilder alloc] initWithProfileURLCreator:[self profileURLCreator] 
                                                                                     profileRelativeURICreator:[self profileRelativeURICreator]
                                                                               managedObjectContextFactory:[self managedObjectContextFactory] 
                                                                                                      user:theUser];
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
#pragma mark YAUserProfileUpdateURLWithURLParametersBuilderCreator ()

@end
