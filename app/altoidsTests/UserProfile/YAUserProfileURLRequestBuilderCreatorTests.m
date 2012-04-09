//
//  YAUserProfileURLRequestBuilderCreatorTests.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileURLRequestBuilderCreatorTests.h"
#import "YAUserProfileURLRequestBuilderCreator.h"

@interface YAUserProfileURLRequestBuilderCreatorTests()

@property (strong, nonatomic) id userProfileUpdateURLWithURLParametersBuilderCreatorMock;
@property (strong, nonatomic) id userProfileImageUpdateURLWithURLParametersBuilderCreatorMock;
@property (strong, nonatomic) id urlRequestBuilderComposerMock;
@property (strong, nonatomic) YAUserProfileURLRequestBuilderCreator* userProfileURLRequestBuilderCreator;

@end

@implementation YAUserProfileURLRequestBuilderCreatorTests

@synthesize userProfileUpdateURLWithURLParametersBuilderCreatorMock = userProfileUpdateURLWithURLParametersBuilderCreatorMock_;
@synthesize userProfileImageUpdateURLWithURLParametersBuilderCreatorMock = userProfileImageUpdateURLWithURLParametersBuilderCreatorMock_;
@synthesize urlRequestBuilderComposerMock = urlRequestBuilderComposerMock_;
@synthesize userProfileURLRequestBuilderCreator = userProfileURLRequestBuilderCreator_;

- (void)setUp
{
    [self setUserProfileUpdateURLWithURLParametersBuilderCreatorMock:[OCMockObject mockForProtocol:@protocol(UserProfileUpdateURLWithURLParametersBuilderCreator)]];

    [self setUserProfileImageUpdateURLWithURLParametersBuilderCreatorMock:[OCMockObject mockForProtocol:@protocol(UserProfileImageUpdateURLWithURLParametersBuilderCreator)]];
    
    [self setUrlRequestBuilderComposerMock:[OCMockObject mockForProtocol:@protocol(URLRequestBuilderComposer)]];
    
    [self setUserProfileURLRequestBuilderCreator:[[YAUserProfileURLRequestBuilderCreator alloc] init]];
    [[self userProfileURLRequestBuilderCreator] setUserProfileUpdateURLWithURLParametersBuilderCreator:[self userProfileUpdateURLWithURLParametersBuilderCreatorMock]];
    [[self userProfileURLRequestBuilderCreator] setUserProfileImageUpdateURLWithURLParametersBuilderCreator:[self userProfileImageUpdateURLWithURLParametersBuilderCreatorMock]];
    [[self userProfileURLRequestBuilderCreator] setUrlRequestBuilderComposer:[self urlRequestBuilderComposerMock]];

}

- (void)testCanCreateUserProfileURLRequestBuilderForUpdatingNameAndPermissionForUser
{
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    id userProfileUpdateNameWithPermissionURLWithURLParametersBuilderMock = [OCMockObject mockForProtocol:@protocol(UserProfileUpdateNameWithPermissionURLWithURLParametersBuilder)];
        
    [[[[self userProfileUpdateURLWithURLParametersBuilderCreatorMock] expect] andReturn:userProfileUpdateNameWithPermissionURLWithURLParametersBuilderMock] createWithUser:userMock];
    
    [[[[self urlRequestBuilderComposerMock] expect] andReturn:[OCMockObject mockForProtocol:@protocol(URLRequestBuilder)]] composeStandardPostRequestWithJSONPayloadUsingURLWithURLParametersBuilder:userProfileUpdateNameWithPermissionURLWithURLParametersBuilderMock];
    
    STAssertNotNil([[self userProfileURLRequestBuilderCreator] createUserProfileURLRequestBuilderForUpdatingNameAndPermissionForUser:userMock], @"Unexpected user profile URL request builder creator");
    
    [[self userProfileUpdateURLWithURLParametersBuilderCreatorMock] verify];
    [[self urlRequestBuilderComposerMock] verify];
    [userProfileUpdateNameWithPermissionURLWithURLParametersBuilderMock verify];
}

@end
