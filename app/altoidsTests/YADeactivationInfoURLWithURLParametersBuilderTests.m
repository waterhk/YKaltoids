//
//  YADeactivationInfoURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 3/27/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YADeactivationInfoURLWithURLParametersBuilderTests.h"
#import "DeactivationRelativeURICreator.h"
#import "RegistrationURLCreator.h"
#import "YADeactivationInfoURLWithURLParametersBuilder.h"


@interface YADeactivationInfoURLWithURLParametersBuilderTests()

 @property (strong, nonatomic) id urlMock;
 @property (strong, nonatomic) id requestParametersMock;
 @property (strong, nonatomic) id registrationURLCreatorMock;
 @property (strong, nonatomic) id deactivationRelativeURICreatorMock;
 @property (strong, nonatomic) YADeactivationInfoURLWithURLParametersBuilder *deactivationInfoURLWithURLParametersBuilder;
 
@end

@implementation YADeactivationInfoURLWithURLParametersBuilderTests

@synthesize urlMock = urlMock_;
@synthesize requestParametersMock = requestParametersMock_;
@synthesize registrationURLCreatorMock = registrationURLCreatorMock_;
@synthesize deactivationRelativeURICreatorMock = deactivationRelativeURICreatorMock_;
@synthesize deactivationInfoURLWithURLParametersBuilder = deactivationInfoURLWithURLParametersBuilder_;

- (void)setUp
{
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setRegistrationURLCreatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationURLCreator)]];
    [self setDeactivationRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(DeactivationRelativeURICreator)]];
    
    [self setDeactivationInfoURLWithURLParametersBuilder:[[YADeactivationInfoURLWithURLParametersBuilder alloc] init]];
    [[self deactivationInfoURLWithURLParametersBuilder] setRegistrationURLCreator:[self registrationURLCreatorMock]];
    [[self deactivationInfoURLWithURLParametersBuilder] setDeactivationRelativeURICreator:[self deactivationRelativeURICreatorMock]];
}


- (void)tesUsesDeactivationURLCreatorToURLRequestWithDeactivationInfoURLAndGivenParameters
{
    
    NSString *relativeURI = @"uri";
    
    [[[[self urlMock] expect] andReturn:[self urlMock]] absoluteURL];
    [[[[self deactivationRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToRetreiveRegistrationInfo];
    
    [[[[self registrationURLCreatorMock] expect] andReturn:[self urlMock]] createRegistrationURLWithRelativeURI:relativeURI params:[self requestParametersMock]];
    
    STAssertEqualObjects([self urlMock], [[[self deactivationInfoURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self requestParametersMock]] URL], @"Unexpected url");

    
    
}

@end
