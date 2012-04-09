//
//  YAUserProfileImageUpdateErrorHandler.m
//  altoids
//
//  Created by Anand Biligiri on 1/3/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateErrorHandler.h"

// Private class extension
@interface YAUserProfileImageUpdateErrorHandler ()

// @property definitions
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;
@property (strong, nonatomic) id<ManagedObjectContextFactory> managedObjectContextFactory;
// methods

@end

@implementation YAUserProfileImageUpdateErrorHandler

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
        userObjectID_ = theUserObjectID;
        managedObjectContextFactory_ = theManagedObjectContextFactory;
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
#pragma mark ErrorHandler methods
- (void)handleError:(NSError *)theError
{
    NSManagedObjectContext *context = [[self managedObjectContextFactory] create];
    YAUser *user = (YAUser *)[context objectWithID:[self userObjectID]];
    [[self userProfileHandler] setImageUpdateStatus:YAImageUpdateStatusError forUser:user];
    
    NSError *error = nil;
    [[self userProfileHandler] save:user inManagedObjectContext:context error:&error];
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
#pragma mark YAUserProfileImageUpdateErrorHandler ()

@end
