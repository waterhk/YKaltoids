//
//  YAUserProfileRepositoryTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/18/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAUserProfileRepositoryTests.h"
#import "YAUserProfileRepository.h"
#import "UserProfileHandler.h"
#import "PersonImageHandler.h"
#import "YAPersonImage.h"
#import "ImageTransformer.h"
#import "UserProfileCommandFactory.h"
#import "CommandQueue.h"

@interface YAUserProfileRepositoryTests()
@property (strong, nonatomic) YAUserProfileRepository *userProfileRepository;
@property (strong, nonatomic) id userMock;
@property (strong, nonatomic) id userProfileHandlerMock;
@property (strong, nonatomic) id personImageHandlerMock;
@property (strong, nonatomic) id personImageMock;
@property (strong, nonatomic) id imageTransformerMock;
@property (strong, nonatomic) id userProfileCommandFactoryMock;
@property (strong, nonatomic) id mmcCommandQueueMock;

- (void)verifyMocks;

@end

@implementation YAUserProfileRepositoryTests
@synthesize userProfileRepository = userProfileRepository_;
@synthesize userMock = userMock_;
@synthesize personImageHandlerMock = personImageHandlerMock_;
@synthesize userProfileHandlerMock = userProfileHandlerMock_;
@synthesize personImageMock = personImageMock_;
@synthesize imageTransformerMock = imageTransformerMock_;
@synthesize userProfileCommandFactoryMock = userProfileCommandFactoryMock_;
@synthesize mmcCommandQueueMock = mmcCommandQueueMock_;


// All code under test must be linked into the Unit Test bundle

- (void)setUp
{    
    [self setUserProfileHandlerMock:[OCMockObject mockForProtocol:@protocol(UserProfileHandler)]];
    [self setUserMock:[OCMockObject mockForClass:[YAUser class]]];
    [self setPersonImageHandlerMock:[OCMockObject mockForProtocol:@protocol(PersonImageHandler)]];
    [self setPersonImageMock:[OCMockObject mockForClass:[YAPersonImage class]]];
    [self setImageTransformerMock:[OCMockObject mockForProtocol:@protocol(ImageTransformer)]];
    [self setUserProfileCommandFactoryMock:[OCMockObject mockForProtocol:@protocol(UserProfileCommandFactory)]];
    [self setMmcCommandQueueMock: [OCMockObject mockForProtocol:@protocol(CommandQueue)]];
    
    userProfileRepository_ = [[YAUserProfileRepository alloc] init];
    [userProfileRepository_ setUserProfileHandler:[self userProfileHandlerMock]];
    [userProfileRepository_ setPersonImageHandler:[self personImageHandlerMock]];
    [userProfileRepository_ setImageTransformer:[self imageTransformerMock]];
    [userProfileRepository_ setUserProfileCommandFactory:[self userProfileCommandFactoryMock]];
    [userProfileRepository_ setMmcCommandQueue:[self mmcCommandQueueMock]];
}

- (void) testUpdateWhenNewImageIsTaken
{
    BOOL isDataEqual = NO;
    NSString *newFirstName = @"myNewFirstName";
    NSString *newLastName =  @"myNewLastName";
    NSData *dataOfOriginalImage = [NSData data];
    id mockImageData = [OCMockObject mockForClass: [NSData class ]] ;
    id mockImage = [OCMockObject mockForClass:[UIImage class]];
    id updateImageCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    id updateNameAndPermissionCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    
    [[[[self userProfileHandlerMock] expect] andReturn:dataOfOriginalImage] dataOfImageForUser:[self userMock]];
    [[[[self imageTransformerMock] expect] andReturn:mockImageData] dataWithImage:mockImage];
    
    [[[mockImageData expect] andReturnValue:OCMOCK_VALUE(isDataEqual)] isEqualToData:dataOfOriginalImage];
    
    [[[[self userProfileCommandFactoryMock] expect] andReturn:updateImageCommandMock] createUpdateProfileImageCommandWithUser:[self userMock] profileImageData:mockImageData delegate:OCMOCK_ANY];

    [[[[self userProfileCommandFactoryMock] expect] andReturn:updateNameAndPermissionCommandMock] createUpdateProfileNameWithPermissionCommandWithUser:[self userMock] firstName:OCMOCK_ANY lastName:OCMOCK_ANY updateProfileImageCommand:updateImageCommandMock viewForOverlay:nil delegate:OCMOCK_ANY];
    
    [[[self mmcCommandQueueMock] expect] append:updateNameAndPermissionCommandMock];
    
    [[self userProfileRepository] updateUserProfileWithFirstName:newFirstName lastName:newLastName image:mockImage viewForOverlay:nil forUser:[self userMock] error:nil];
    
    [self verifyMocks];
    
}

- (void) testUpdateWhenNewImageIsSameAsOldImage
{    
    BOOL isDataEqual = YES;
    NSString *newFirstName = @"myNewFirstName";
    NSString *newLastName =  @"myNewLastName";
    NSData *dataOfOriginalImage = [NSData data];
    id mockImageData = [OCMockObject mockForClass: [NSData class ]] ;
    id mockImage = [OCMockObject mockForClass:[UIImage class]];
    id updateNameAndPermissionCommandMock = [OCMockObject mockForProtocol:@protocol(Command)];
    
    [[[[self userProfileHandlerMock]expect] andReturn:dataOfOriginalImage] dataOfImageForUser:[self userMock]];
    
    [[[[self imageTransformerMock] expect] andReturn: mockImageData] dataWithImage:mockImage];
    
    [[[mockImageData expect] andReturnValue:OCMOCK_VALUE(isDataEqual)] isEqualToData:dataOfOriginalImage];
    
    [[[[self userProfileCommandFactoryMock] stub] andReturn:updateNameAndPermissionCommandMock] createUpdateProfileNameWithPermissionCommandWithUser:[self userMock] firstName:OCMOCK_ANY lastName:OCMOCK_ANY updateProfileImageCommand:nil viewForOverlay:nil delegate:OCMOCK_ANY];
    
    [[[self mmcCommandQueueMock]stub] append:updateNameAndPermissionCommandMock];
       
    [[self userProfileRepository] updateUserProfileWithFirstName:newFirstName lastName:newLastName image:mockImage viewForOverlay:nil forUser:[self userMock] error:nil];
    
    [self verifyMocks];
}

- (void) verifyMocks 
{    
    [[self userProfileHandlerMock] verify];
    [[self userMock] verify];
    [[self userProfileHandlerMock] verify];
    [[self personImageHandlerMock] verify];
    [[self personImageMock] verify];
    [[self imageTransformerMock] verify];
    [[self userProfileCommandFactoryMock] verify];
    [[self mmcCommandQueueMock] verify];
}

@end