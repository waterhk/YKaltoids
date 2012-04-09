//
//  YAProfileRelativeURICreatorTests.m
//  altoids
//
//  Created by Anand Subba Rao on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAProfileRelativeURICreatorTests.h"
#import "YAProfileRelativeURICreator.h"

@interface YAProfileRelativeURICreatorTests()
@property (strong, nonatomic) id userProfileHandlerMock;
@property (strong, nonatomic) id userMock;
@property (strong, nonatomic) YAProfileRelativeURICreator *profileRelativeURICreator;
@end


@implementation YAProfileRelativeURICreatorTests
@synthesize userProfileHandlerMock = userProfileHandlerMock_;
@synthesize userMock = userMock_;
@synthesize profileRelativeURICreator = profileRelativeURICreator_;

- (void)setUp
{
    [self setUserProfileHandlerMock:[OCMockObject mockForProtocol:@protocol(UserProfileHandler)]];
    [self setUserMock:[OCMockObject mockForClass:[YAUser class]]];
    
    profileRelativeURICreator_ = [[YAProfileRelativeURICreator alloc] init];
    [profileRelativeURICreator_ setUserProfileHandler:[self userProfileHandlerMock]];
}

- (void)testCanCreateRelativeURIForProfile
{
    [[[[self userProfileHandlerMock] expect] andReturn:@"guid"] guidForUser:[self userMock]];
    NSString *relativeURI = [[self profileRelativeURICreator] createRelativeURIToUpdateProfileNameWithPermissionForUser:[self userMock]];
    
    STAssertEqualObjects(relativeURI, @"v1/user/guid/profile", @"Unexpected relative URI value %@", relativeURI);
}

- (void)testCanCreateRelativeURIForImageUpdate
{
    [[[[self userProfileHandlerMock] expect] andReturn:@"guid"] guidForUser:[self userMock]];
    NSString *relativeURI = [[self profileRelativeURICreator] createRelativeURIToUpdateProfileImageForUser:[self userMock]];
    
    STAssertEqualObjects(relativeURI, @"v1/user/guid/profile/imagepool", @"Unexpected relative URI value %@", relativeURI);    
}
@end
