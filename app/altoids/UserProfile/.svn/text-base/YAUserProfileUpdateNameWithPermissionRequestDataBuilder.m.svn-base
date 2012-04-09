//
//  YAUserProfileUpdateNameWithPermissionRequestDataBuilder.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileUpdateNameWithPermissionRequestDataBuilder.h"

// Private class extension
@interface YAUserProfileUpdateNameWithPermissionRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAUserProfileUpdateNameWithPermissionRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

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

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileUpdateNameWithPermissionRequestDataBuilder delegate methods

- (NSDictionary *)requestDataForUserProfileUpdateWithFirstName:(NSString *)theFirstName lastName:(NSString *)theLastName
{
    /*
     {
     "updateprofileperm" : {
     "nickname" : {"v":"text","p":"perm"},                         // display name of the profile owner
     "displayAge" : {"v":numeric,"p":"perm"},                     // age of the profile owner
     "gender" : {"v": "M" | "F" | "UNSPECIFIED","p":"perm"}       // gender of the profile owner
     "location" : {"v":"text","p":"perm"}                           // location of the profile owner 
     "givenName" : {"v":"text","p":"perm"}      // given (first) name of the profile owner
     "familyName" : {"v":"text","p":"perm"}      // family (last) name of the profile owner
     "status":{"v":"blah..","c": [ -1401 , -1413 ]  }  //category attached, no p should be present.
     ....
     
     }
     */
    
    NSDictionary *firstNameWithPermission = nil;
    NSDictionary *lastNameWithPermission = nil;
    NSDictionary *updateProfilePerm = nil;
    
    if ([theFirstName length] > 0) {
        firstNameWithPermission = [NSDictionary dictionaryWithObjectsAndKeys:theFirstName,@"v",@"PUBLIC",@"p", nil];
    }
    
    if ([theLastName length] > 0) {
        lastNameWithPermission = [NSDictionary dictionaryWithObjectsAndKeys:theLastName,@"v",@"PUBLIC",@"p", nil];
    }
    
    NSDictionary *data = nil;
    
    if (!firstNameWithPermission && !lastNameWithPermission) { // nothing to update - log error and return
        YALogError_c(lcl_cProfileCommand, @"First name and last name is nil");
        return nil;
    }
    
    if (firstNameWithPermission && lastNameWithPermission) { // we have both first and last names
        data = [NSDictionary dictionaryWithObjectsAndKeys:firstNameWithPermission,@"givenName",
                lastNameWithPermission,@"familyName", nil];
    } else if(!firstNameWithPermission && lastNameWithPermission) { // we have only last name
        data = [NSDictionary dictionaryWithObjectsAndKeys:lastNameWithPermission,@"familyName", nil];
    } else if(!lastNameWithPermission && firstNameWithPermission) { // we have only first name
        data = [NSDictionary dictionaryWithObjectsAndKeys:firstNameWithPermission,@"givenName", nil];
    }
    
    updateProfilePerm = [NSDictionary dictionaryWithObjectsAndKeys:data, @"updateprofileperm", nil];
    
    return updateProfilePerm;
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
#pragma mark YAUserProfileUpdateNameWithPermissionRequestDataBuilder ()

@end
