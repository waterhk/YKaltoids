//
//  YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler.h"

// Private class extension
@interface YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler ()

// @property definitions
@property (strong, nonatomic) id<UserProfileHandler> userProfileHandler;
@property (strong, nonatomic) id<UserProfileErrorHandlerFactory> userProfileErrorHandlerFactory;
@property (strong, nonatomic) NSManagedObjectID *userObjectID;
@property (strong, nonatomic) id<UserProfileUpdateCommandDelegate> userProfileUpdateCommandDelegate;
@property (copy,   nonatomic) NSString *firstName;
@property (copy,   nonatomic) NSString *lastName;
@property (strong, nonatomic) id<Command> updateProfileImageCommand;

// methods

@end

@implementation YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize userProfileHandler = userProfileHandler_;
@synthesize userProfileErrorHandlerFactory = userProfileErrorHandlerFactory_;
@synthesize userObjectID = userObjectID_;
@synthesize userProfileUpdateCommandDelegate = userProfileUpdateCommandDelegate_;
@synthesize firstName = firstName_;
@synthesize lastName = lastName_;
@synthesize updateProfileImageCommand = updateProfileImageCommand_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithUserProfileHandler:(id<UserProfileHandler>)theUserProfileHandler
  userProfileErrorHandlerFactory:(id<UserProfileErrorHandlerFactory>)theUserProfileErrorHandlerFactory
                            user:(YAUser *)theUser 
                       firstName:(NSString *)theFirstName 
                        lastName:(NSString *)theLastName 
       updateProfileImageCommand:(id<Command>)theUpdateProfileImageCommand 
                        delegate:(id<UserProfileUpdateCommandDelegate>)theUserProfileUpdateCommandDelegate
{
  self = [super init];
  if (self) {
      userProfileHandler_ = theUserProfileHandler;
      userProfileErrorHandlerFactory_ = theUserProfileErrorHandlerFactory;
      userObjectID_ = [[self userProfileHandler] userObjectIDForUser:theUser];
      firstName_ = theFirstName;
      lastName_ = theLastName;
      updateProfileImageCommand_ = theUpdateProfileImageCommand;
      userProfileUpdateCommandDelegate_ = theUserProfileUpdateCommandDelegate;
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
#pragma mark <Protocol Name> delegate methods

- (void)handleParsedJSONResponse:(NSDictionary *)aParsedJSONResponse
{    
    [[self updateProfileImageCommand] execute];
    
    [[self userProfileUpdateCommandDelegate] userProfileNameAndPermissionUpdatedForLocalUserWithObjectID:[self userObjectID] firstName:[self firstName] lastName:[self lastName]];
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
#pragma mark YAUserProfileUpdateNameWithPermissionParsedJSONResponseHandler ()

@end
