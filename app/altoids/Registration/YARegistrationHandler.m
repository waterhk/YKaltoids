//
//  YARegistrationHandler.m
//  altoids
//
//  Created by Anand Subba Rao on 11/22/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YARegistrationHandler.h"

// Private class extension
@interface YARegistrationHandler ()

// @property definitions

// methods

@end

@implementation YARegistrationHandler

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
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
#pragma mark RegistrationHandler methods
- (YARegistrationInfo *)createRegistrationInfoEntityInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"RegistrationInfo" inManagedObjectContext:managedObjectContext];
}

- (void)setPhoneNumber:(NSString *)phoneNumber registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [registrationInfo setPhoneNumber:phoneNumber];
}

- (void)setExpirationDate:(NSDate *)expirationDate registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [registrationInfo setExpirationDate:expirationDate];
}

- (void)setProfileUpdated:(BOOL)profileUpdated registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [registrationInfo setProfileUpdated:[NSNumber numberWithBool:profileUpdated]];
}

- (void)setToken:(NSString *)token registrationInfo:(YARegistrationInfo *)registrationInfo
{
    [registrationInfo setToken:token];
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
#pragma mark YARegistrationHandler ()

@end
