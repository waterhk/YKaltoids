//
//  YAUserProfileUpdateNameWithPermissionErrorHandler.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileUpdateNameWithPermissionErrorHandler.h"

// Private class extension
@interface YAUserProfileUpdateNameWithPermissionErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;

// methods

@end

@implementation YAUserProfileUpdateNameWithPermissionErrorHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize managedObjectContextFactory = managedObjectContextFactory_;
@synthesize userProfileHandler = userProfileHandler_;
@synthesize userObjectID = userObjectID_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithUserProfileHandler:(id<UserProfileHandler>)theUserProfileHandler 
     managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
                    userObjectID:(NSManagedObjectID *)theUserObjectID
{
  self = [super init];
  if (self) {
      userProfileHandler_ = theUserProfileHandler;
      managedObjectContextFactory_ = theManagedObjectContextFactory;
      userObjectID_ = theUserObjectID;
  }
  
  return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark ErrorHandler delegate methods

- (void)handleError:(NSError *)theError
{
    NSManagedObjectContext *managedObjectContext = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[managedObjectContext objectWithID:[self userObjectID]];
    [[self userProfileHandler] setProfileUpdateStatus:YAProfileUpdateStatusError forUser:user];
    [[self userProfileHandler] setLastUpdatedDate:[NSDate date] forUser:user];
    
    NSError *error = nil;
    [[self userProfileHandler] save:user inManagedObjectContext:managedObjectContext error:&error];
    
    if (error) {
        YALogError_c(lcl_cProfileCommand, @"Error:\n%@\n",[theError localizedDescription]);
        return;
    }    
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
#pragma mark YAUserProfileUpdateNameWithPermissionErrorHandler ()

@end
