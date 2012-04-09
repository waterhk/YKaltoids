//
//  YAUserProfileImageUpdateParsedJSONResponseHandlerCreator.m
//  altoids
//
//  Created by Anand Biligiri on 12/21/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateParsedJSONResponseHandlerCreator.h"
#import "YAUserProfileImageUpdateParsedJSONResponseHandler.h"

// Private class extension
@interface YAUserProfileImageUpdateParsedJSONResponseHandlerCreator ()

// @property definitions

// methods

@end

@implementation YAUserProfileImageUpdateParsedJSONResponseHandlerCreator

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userProfileHandler = userProfileHandler_;

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
#pragma mark UserProfileImageUpdateParsedJSONResponseHandlerCreator methods
- (id<UserProfileImageUpdateParsedJSONResponseHandler>)createWithUser:(YAUser *)user profileImageData:(NSData *)theProfileImageData delegate:(id<UserProfileUpdateCommandDelegate>)theDelegate
{
    return [[YAUserProfileImageUpdateParsedJSONResponseHandler alloc] initWithManagedObjectContextFactory:[self managedObjectContextFactory]
                                                                                             userObjectID:[user objectID]
                                                                                       userProfileHandler:[self userProfileHandler] 
                                                                                         profileImageData:theProfileImageData 
                                                                                                 delegate:theDelegate];
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
#pragma mark YAUserProfileImageUpdateParsedJSONResponseHandlerCreator ()

@end
