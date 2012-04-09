//
//  YARegistrationInfoURLWithURLParametersBuilderTests.m
//  altoids
//
//  Created by Venkatraman Sridharan on 1/25/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YARegistrationInfoURLWithURLParametersBuilderTests.h"
#import "RegistrationURLCreator.h"
#import "RegistrationRelativeURICreator.h"
#import "YARegistrationInfoURLWithURLParametersBuilder.h"


@interface YARegistrationInfoURLWithURLParametersBuilderTests ()

@property (strong, nonatomic) id urlMock;
@property (strong, nonatomic) id requestParametersMock;
@property (strong, nonatomic) id registrationURLCreatorMock;
@property (strong, nonatomic) id registrationRelativeURICreatorMock;
@property (strong, nonatomic) YARegistrationInfoURLWithURLParametersBuilder *registrationInfoURLWithURLParametersBuilder;

@end

@implementation YARegistrationInfoURLWithURLParametersBuilderTests

@synthesize urlMock = urlMock_;
@synthesize requestParametersMock = requestParametersMock_;
@synthesize registrationURLCreatorMock = registrationURLCreatorMock_;
@synthesize registrationRelativeURICreatorMock = registrationRelativeURICreatorMock_;
@synthesize registrationInfoURLWithURLParametersBuilder = registrationInfoURLWithURLParametersBuilder_;

// All code under test must be linked into the Unit Test bundle

- (void)setUp
{
    [self setUrlMock:[OCMockObject mockForClass:[NSURL class]]];
    [self setRequestParametersMock:[OCMockObject mockForClass:[NSDictionary class]]];
    [self setRegistrationURLCreatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationURLCreator)]];
    [self setRegistrationRelativeURICreatorMock:[OCMockObject mockForProtocol:@protocol(RegistrationRelativeURICreator)]];
    
    [self setRegistrationInfoURLWithURLParametersBuilder:[[YARegistrationInfoURLWithURLParametersBuilder alloc] init]];
    [[self registrationInfoURLWithURLParametersBuilder] setRegistrationURLCreator:[self registrationURLCreatorMock]];
    [[self registrationInfoURLWithURLParametersBuilder] setRegistrationRelativeURICreator:[self registrationRelativeURICreatorMock]];
}

- (void)tesUsesRegistrationURLCreatorToURLRequestWithRegistrationInfoURLAndGivenParameters
{
    NSString *relativeURI = @"uri";
    
    [[[[self urlMock] expect] andReturn:[self urlMock]] absoluteURL];
    [[[[self registrationRelativeURICreatorMock] expect] andReturn:relativeURI] createRelativeURIToRetreiveRegistrationInfo];
    
    [[[[self registrationURLCreatorMock] expect] andReturn:[self urlMock]] createRegistrationURLWithRelativeURI:relativeURI params:[self requestParametersMock]];
    
    STAssertEqualObjects([self urlMock], [[[self registrationInfoURLWithURLParametersBuilder] buildRequestURLWithURLParameters:[self requestParametersMock]] URL], @"Unexpected url");
}



@end
