//
//  YAUserProfileUpdateNameWithPermissionRequestDataBuilderTests.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileUpdateNameWithPermissionRequestDataBuilderTests.h"
#import "YAUserProfileUpdateNameWithPermissionRequestDataBuilder.h"

#define kFirstNameValueKeyPath @"updateprofileperm.givenName.v"
#define kFirstNamePermissionKeyPath @"updateprofileperm.givenName.p"
#define kLastNameValueKeyPath @"updateprofileperm.familyName.v"
#define kLastNamePermissionKeyPath @"updateprofileperm.familyName.p"
#define kPublicPermission @"PUBLIC"

#define kFirstName @"john"
#define kLastName @"smith"
#define kEmptyName @""

@protocol YAUser <NSObject>

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@end

@interface YAUserProfileUpdateNameWithPermissionRequestDataBuilderTests()

@property (strong, nonatomic) id<UserProfileUpdateNameWithPermissionRequestDataBuilder> userProfileUpdateNameWithPermissionRequestDataBuilder;

@end

@implementation YAUserProfileUpdateNameWithPermissionRequestDataBuilderTests

@synthesize userProfileUpdateNameWithPermissionRequestDataBuilder = userProfileUpdateNameWithPermissionRequestDataBuilder_;

- (void)setUp
{
    [self setUserProfileUpdateNameWithPermissionRequestDataBuilder:[[YAUserProfileUpdateNameWithPermissionRequestDataBuilder alloc] init]];
}

- (void)testRequestDataForUserProfileWithNonEmptyFirstAndLastNames
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:kFirstName lastName:kLastName];
 
    STAssertNotNil(updateProfilePerm, @"Unexpected nil value returned");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNameValueKeyPath],kFirstName, @"Unexpected value for first name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNamePermissionKeyPath],kPublicPermission, @"Unexpected value for first name permission");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNameValueKeyPath],kLastName, @"Unexpected value for last name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNamePermissionKeyPath],kPublicPermission, @"Unexpected value for last name permission");
}

- (void)testRequestDataForUserProfileWithEmptyFirstAndLastNames
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:kEmptyName lastName:kEmptyName];
    
    STAssertNil(updateProfilePerm, @"Unexpected value returned");
}

- (void)testRequestDataForUserProfileWithEmptyFirstNameAndNonEmptyLastName
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:kEmptyName lastName:kLastName];
    
    STAssertNotNil(updateProfilePerm, @"Unexpected nil value returned");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNameValueKeyPath],kLastName, @"Unexpected value for last name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNamePermissionKeyPath],kPublicPermission, @"Unexpected value for last name permission");
    
    STAssertNil([updateProfilePerm valueForKeyPath:kFirstNameValueKeyPath], @"Unexpected value for first name");
    STAssertNil([updateProfilePerm valueForKeyPath:kFirstNamePermissionKeyPath], @"Unexpected value for first name permission");
}

- (void)testRequestDataForUserProfileWithNonEmptyFirstNameAndEmptyLastName
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:kFirstName lastName:kEmptyName];
    
    STAssertNotNil(updateProfilePerm, @"Unexpected nil value returned");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNameValueKeyPath],kFirstName, @"Unexpected value for first name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNamePermissionKeyPath],kPublicPermission, @"Unexpected value for first name permission");
    
    STAssertNil([updateProfilePerm valueForKeyPath:kLastNameValueKeyPath], @"Unexpected value for last name");
    STAssertNil([updateProfilePerm valueForKeyPath:kLastNamePermissionKeyPath], @"Unexpected value for last name permission");
}

- (void)testRequestDataForUserProfileWithNilFirstAndLastNames
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:nil lastName:nil];
    
    STAssertNil(updateProfilePerm, @"Unexpected value returned");
}

- (void)testRequestDataForUserProfileWithNilFirstNameAndNotNilLastName
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:nil lastName:kLastName];
    
    STAssertNotNil(updateProfilePerm, @"Unexpected nil value returned");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNameValueKeyPath],kLastName, @"Unexpected value for last name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kLastNamePermissionKeyPath],kPublicPermission, @"Unexpected value for last name permission");
    
    STAssertNil([updateProfilePerm valueForKeyPath:kFirstNameValueKeyPath], @"Unexpected value for first name");
    STAssertNil([updateProfilePerm valueForKeyPath:kFirstNamePermissionKeyPath], @"Unexpected value for first name permission");
}

- (void)testRequestDataForUserProfileWithNotNilFirstNameAndNilLastName
{
    NSDictionary *updateProfilePerm = [[self userProfileUpdateNameWithPermissionRequestDataBuilder] requestDataForUserProfileUpdateWithFirstName:kFirstName lastName:nil];
    
    STAssertNotNil(updateProfilePerm, @"Unexpected nil value returned");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNameValueKeyPath],kFirstName, @"Unexpected value for first name");
    STAssertEquals([updateProfilePerm valueForKeyPath:kFirstNamePermissionKeyPath],kPublicPermission, @"Unexpected value for first name permission");
    
    STAssertNil([updateProfilePerm valueForKeyPath:kLastNameValueKeyPath], @"Unexpected value for last name");
    STAssertNil([updateProfilePerm valueForKeyPath:kLastNamePermissionKeyPath], @"Unexpected value for last name permission");
}

@end
