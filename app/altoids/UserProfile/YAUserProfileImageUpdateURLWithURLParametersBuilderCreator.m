//
//  YAUserProfileImageUpdateURLWithURLParametersBuilderCreator.m
//  altoids
//
//  Created by Anand Subba Rao on 12/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateURLWithURLParametersBuilderCreator.h"
#import "YAUserProfileImageUpdateURLWithURLParametersBuilder.h"

// Private class extension
@interface YAUserProfileImageUpdateURLWithURLParametersBuilderCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileImageUpdateURLWithURLParametersBuilderCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize profileRelativeURICreator = profileRelativeURICreator_;
@synthesize profileURLCreator = profileURLCreator_;
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
#pragma mark UserProfileImageUpdateURLWithURLParametersBuilderCreator methods
- (id<UserProfileImageUpdateURLWithURLParametersBuilder>)createWithUser:(YAUser *)user
{
    return [[YAUserProfileImageUpdateURLWithURLParametersBuilder alloc] initWithProfileURLCreator:[self profileURLCreator]
                                                                        profileRelativeURICreator:[self profileRelativeURICreator]
                                                                                     userObjectID:[user objectID]
                                                                      managedObjectContextFactory:[self managedObjectContextFactory]];
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
#pragma mark YAUserProfileImageUpdateURLWithURLParametersBuilderCreator ()

@end
