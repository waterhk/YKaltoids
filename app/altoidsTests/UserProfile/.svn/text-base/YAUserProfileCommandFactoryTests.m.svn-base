//
//  YAUserProfileCommandFactoryTests.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileCommandFactoryTests.h"
#import "YAUserProfileCommandFactory.h"
#import "AppFactory.h"
#import "UserProfileErrorHandlerFactory.h"
#import "UserProfileParsedJSONResponseHandlerCreator.h"
#import "UserProfileURLRequestBuilderCreator.h"
#import "UserProfileUpdateNameWithPermissionRequestDataBuilder.h"
#import "UserProfileImageUpdateParsedJSONResponseHandlerCreator.h"
#import "UserProfileImageUpdateRequestDataBuilder.h"
#import "CommandErrorHandlerCreator.h"
#import "ProfileURLParametersCreator.h"
#import "Command.h"

@interface YAUserProfileCommandFactoryTests()

@property (strong, nonatomic) id fetchUserProfileCommandInstanceFactoryMock;
@property (strong, nonatomic) id mmcCommandInstanceFactoryMock;
@property (strong, nonatomic) id activityOverlayCommandInstanceFactoryMock;
@property (strong, nonatomic) id compositeCommandInstanceFactoryMock;
@property (strong, nonatomic) id userProfileErrorHandlerFactoryMock;
@property (strong, nonatomic) id userProfileResponseHandlerCreatorMock;
@property (strong, nonatomic) id userProfileURLRequestBuilderCreatorMock;
@property (strong, nonatomic) id userProfileUpdateNameWithPermissionRequestDataBuilderMock;
@property (strong, nonatomic) id userProfileImageUpdateParsedJSONResponseHandlerCreatorMock;
@property (strong, nonatomic) id userProfileImageUpdateRequestDataBuilderMock;
@property (strong, nonatomic) id commandErrorHandlerCreatorMock;
@property (strong, nonatomic) id profileURLParametersCreatorMock;
@property (strong, nonatomic) id jsonParserMock;
@property (strong, nonatomic) id requestDataMock;
@property (strong, nonatomic) id requestParametersMock;

@property (strong, nonatomic) YAUserProfileCommandFactory* userProfileCommandFactory;

- (void)verifyMocks;

@end

@implementation YAUserProfileCommandFactoryTests

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize fetchUserProfileCommandInstanceFactoryMock = fetchUserProfileCommandInstanceFactoryMock_;
@synthesize mmcCommandInstanceFactoryMock = mmcCommandInstanceFactoryMock_;
@synthesize activityOverlayCommandInstanceFactoryMock = activityOverlayCommandInstanceFactoryMock_;
@synthesize compositeCommandInstanceFactoryMock = compositeCommandInstanceFactoryMock_;
@synthesize userProfileErrorHandlerFactoryMock = userProfileErrorHandlerFactoryMock_;
@synthesize userProfileResponseHandlerCreatorMock = userProfileResponseHandlerCreatorMock_;
@synthesize userProfileURLRequestBuilderCreatorMock = userProfileURLRequestBuilderCreatorMock_;
@synthesize userProfileUpdateNameWithPermissionRequestDataBuilderMock = userProfileUpdateNameWithPermissionRequestDataBuilderMock_;
@synthesize userProfileImageUpdateParsedJSONResponseHandlerCreatorMock = userProfileImageUpdateParsedJSONResponseHandlerCreatorMock_;
@synthesize userProfileImageUpdateRequestDataBuilderMock = userProfileImageUpdateRequestDataBuilderMock_;
@synthesize commandErrorHandlerCreatorMock = commandErrorHandlerCreatorMock_;
@synthesize profileURLParametersCreatorMock = profileURLParametersCreatorMock_;
@synthesize jsonParserMock = jsonParserMock_;
@synthesize requestDataMock = requestDataMock_;
@synthesize requestParametersMock = requestParametersMock_;

@synthesize userProfileCommandFactory = userProfileCommandFactory_;

- (void)setUp
{
    [self setFetchUserProfileCommandInstanceFactoryMock:[OCMockObject mockForProtocol:@protocol(FetchUserProfileCommandInstanceFactory)]];
    [self setMmcCommandInstanceFactoryMock:[OCMockObject mockForProtocol:@protocol(MMCCommandInstanceFactory)]];
    [self setActivityOverlayCommandInstanceFactoryMock:[OCMockObject mockForProtocol:@protocol(ActivityOverlayCommandInstanceFactory)]];
    [self setCompositeCommandInstanceFactoryMock:[OCMockObject mockForProtocol:@protocol(CompositeCommandInstanceFactory)]];
    [self setUserProfileErrorHandlerFactoryMock:[OCMockObject mockForProtocol:@protocol(UserProfileErrorHandlerFactory)]];
    [self setUserProfileResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(UserProfileParsedJSONResponseHandlerCreator)]];
    [self setUserProfileURLRequestBuilderCreatorMock:[OCMockObject mockForProtocol:@protocol(UserProfileURLRequestBuilderCreator)]];
    [self setUserProfileUpdateNameWithPermissionRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(UserProfileUpdateNameWithPermissionRequestDataBuilder)]];
    [self setUserProfileImageUpdateParsedJSONResponseHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(UserProfileImageUpdateParsedJSONResponseHandlerCreator)]];
    [self setUserProfileImageUpdateRequestDataBuilderMock:[OCMockObject mockForProtocol:@protocol(UserProfileImageUpdateRequestDataBuilder)]];
    [self setCommandErrorHandlerCreatorMock:[OCMockObject mockForProtocol:@protocol(CommandErrorHandlerCreator)]];
    [self setProfileURLParametersCreatorMock:[OCMockObject mockForProtocol:@protocol(ProfileURLParametersCreator)]];
    [self setJsonParserMock:[OCMockObject mockForProtocol:@protocol(JSONParser)]];
    [self setRequestDataMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    
    [self setUserProfileCommandFactory:[[YAUserProfileCommandFactory alloc] init]];
    [userProfileCommandFactory_ setFetchUserProfileCommandInstanceFactory:fetchUserProfileCommandInstanceFactoryMock_];
    [userProfileCommandFactory_ setMmcCommandInstanceFactory:mmcCommandInstanceFactoryMock_];
    [userProfileCommandFactory_ setActivityOverlayCommandInstanceFactory:activityOverlayCommandInstanceFactoryMock_];
    [userProfileCommandFactory_ setCompositeCommandInstanceFactory:compositeCommandInstanceFactoryMock_];
    [userProfileCommandFactory_ setUserProfileErrorHandlerFactory:userProfileErrorHandlerFactoryMock_];
    [userProfileCommandFactory_ setUserProfileResponseHandlerFactory:userProfileResponseHandlerCreatorMock_];
    [userProfileCommandFactory_ setUserProfileURLRequestBuilderCreator:userProfileURLRequestBuilderCreatorMock_];
    [userProfileCommandFactory_ setUserProfileUpdateNameWithPermissionRequestDataBuilder:userProfileUpdateNameWithPermissionRequestDataBuilderMock_];
    [userProfileCommandFactory_ setUserProfileImageUpdateParsedJSONResponseHandlerCreator:userProfileImageUpdateParsedJSONResponseHandlerCreatorMock_];
    [userProfileCommandFactory_ setUserProfileImageUpdateRequestDataBuilder:userProfileImageUpdateRequestDataBuilderMock_];
    [userProfileCommandFactory_ setProfileCommandErrorHandlerCreator:commandErrorHandlerCreatorMock_];
    [userProfileCommandFactory_ setProfileURLParametersCreator:profileURLParametersCreatorMock_];
    [userProfileCommandFactory_ setJsonParser:jsonParserMock_];
}

- (void)tearDown
{
    
}

- (void)testCanCreateFetchUserProfileCommandWithUser
{
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    id commandMock = [OCMockObject mockForProtocol:@protocol(Command)];

    [[[fetchUserProfileCommandInstanceFactoryMock_ expect] andReturn:commandMock] createFetchUserProfileCommandWithUser:userMock];

    STAssertEquals(commandMock, [userProfileCommandFactory_ createFetchUserProfileCommandWithUser:userMock], @"Unexpected fetch user profile command");
    
    [self verifyMocks];
}

- (void)testCanCreateUpdateProfileNameWithPermissionCommand
{
    id updateProfileImageCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    id userProfileUpdateCommandDelegateMock = [OCMockObject mockForProtocol:@protocol(UserProfileUpdateCommandDelegate)];
    id errorHandlerMock = [OCMockObject mockForProtocol:@protocol(ErrorHandler)];
    id viewMock = [OCMockObject mockForClass:[UIView class]];
    NSString *firstName = @"fname";
    NSString *lastName = @"lname";
    
    [[[userProfileErrorHandlerFactoryMock_ expect] andReturn:errorHandlerMock] userProfileUpdateNameWithPermissionErrorHandlerWithUser:userMock];
    
    id commandErrorHandlerMock = [OCMockObject mockForProtocol:@protocol(CommandErrorHandler)];
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock] createWithErrorHandler:errorHandlerMock];
    
    id responseHandlerMock = [OCMockObject mockForProtocol:@protocol(UserProfileUpdateNameWithPermissionParsedJSONResponseHandler)];
    [[[userProfileResponseHandlerCreatorMock_ expect] andReturn:responseHandlerMock] createWithUser:userMock firstName:firstName lastName:lastName updateProfileImageCommand:updateProfileImageCommandMock delegate:userProfileUpdateCommandDelegateMock];
    
    id urlRequestBuilderMock = [OCMockObject mockForProtocol:@protocol(URLRequestBuilder)];
    [[[userProfileURLRequestBuilderCreatorMock_ expect] andReturn:urlRequestBuilderMock] createUserProfileURLRequestBuilderForUpdatingNameAndPermissionForUser:userMock];
    
    [[[userProfileUpdateNameWithPermissionRequestDataBuilderMock_ expect] andReturn:requestDataMock_] requestDataForUserProfileUpdateWithFirstName:firstName lastName:lastName];

    id mmcCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:mmcCommandMock] createMMCCommandWithURLRequestBuilder:urlRequestBuilderMock urlRequestParameters:nil urlRequestData:requestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:responseHandlerMock commandErrorHandler:commandErrorHandlerMock];

    id composedOverlayCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[activityOverlayCommandInstanceFactoryMock_ expect] andReturn:composedOverlayCommandMock] createActivityOverlayCommandWithCommand:mmcCommandMock view:viewMock];

    STAssertEquals(composedOverlayCommandMock, [userProfileCommandFactory_ createUpdateProfileNameWithPermissionCommandWithUser:userMock firstName:firstName lastName:lastName updateProfileImageCommand:updateProfileImageCommandMock viewForOverlay:viewMock delegate:userProfileUpdateCommandDelegateMock], @"Unexpected update profile name with permission command ");

    [self verifyMocks];
}

- (void)testCanCreateUpdateProfileImageCommand
{
    id imageDataMock = [OCMockObject mockForClass:[NSData class]];
    id userMock = [OCMockObject mockForClass:[YAUser class]];
    id userProfileUpdateCommandDelegateMock = [OCMockObject mockForProtocol:@protocol(UserProfileUpdateCommandDelegate)];
    
    [[[userProfileImageUpdateRequestDataBuilderMock_ expect] andReturn:requestDataMock_] requestDataForProfileImageUpdateWithImageData:imageDataMock];
    
    id commandErrorHandlerMock = [OCMockObject mockForProtocol:@protocol(CommandErrorHandler)];
    [[[commandErrorHandlerCreatorMock_ expect] andReturn:commandErrorHandlerMock] createWithErrorHandler:nil];
    
    id responseHandlerMock = [OCMockObject mockForProtocol:@protocol(UserProfileImageUpdateParsedJSONResponseHandler)];
    [[[userProfileImageUpdateParsedJSONResponseHandlerCreatorMock_ expect] andReturn:responseHandlerMock] createWithUser:userMock profileImageData:imageDataMock delegate:userProfileUpdateCommandDelegateMock];
    
    id urlRequestBuilderMock = [OCMockObject mockForProtocol:@protocol(URLRequestBuilder)];
    [[[userProfileURLRequestBuilderCreatorMock_ expect] andReturn:urlRequestBuilderMock] createUserProfileURLRequestBuilderForUpdatingImageForUser:userMock];
    
    [[[profileURLParametersCreatorMock_ expect] andReturn:requestParametersMock_] urlParametersToUpdateImage];


    id updateProfileImageCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[mmcCommandInstanceFactoryMock_ expect] andReturn:updateProfileImageCommandMock] createMMCCommandWithURLRequestBuilder:urlRequestBuilderMock urlRequestParameters:requestParametersMock_ urlRequestData:requestDataMock_ jsonParser:jsonParserMock_ parsedJSONResponseHandler:responseHandlerMock commandErrorHandler:commandErrorHandlerMock];

    id fetchUserProfileCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[fetchUserProfileCommandInstanceFactoryMock_ expect] andReturn:fetchUserProfileCommandMock] createFetchUserProfileCommandWithUser:userMock];

    id compositeCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    [[[compositeCommandInstanceFactoryMock_ expect] andReturn:compositeCommandMock] createCompositeCommandWithCommands:[NSArray arrayWithObjects:updateProfileImageCommandMock, fetchUserProfileCommandMock, nil]];

    STAssertEquals(compositeCommandMock, [userProfileCommandFactory_ createUpdateProfileImageCommandWithUser:userMock profileImageData:imageDataMock delegate:userProfileUpdateCommandDelegateMock], @"Unexpected update profile image command ");
    
    [self verifyMocks];
}

- (void)verifyMocks
{    
    [fetchUserProfileCommandInstanceFactoryMock_ verify];
    [mmcCommandInstanceFactoryMock_ verify];
    [activityOverlayCommandInstanceFactoryMock_ verify];
    [userProfileErrorHandlerFactoryMock_ verify];
    [userProfileResponseHandlerCreatorMock_ verify];
    [userProfileURLRequestBuilderCreatorMock_ verify];
    [userProfileUpdateNameWithPermissionRequestDataBuilderMock_ verify];
    [userProfileImageUpdateRequestDataBuilderMock_ verify];
    [commandErrorHandlerCreatorMock_ verify];
    [profileURLParametersCreatorMock_ verify];
    [jsonParserMock_ verify];
    [requestDataMock_ verify];
    [requestParametersMock_ verify];
}

@end
