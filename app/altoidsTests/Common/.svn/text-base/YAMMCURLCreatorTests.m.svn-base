//
//  YAMMCURLCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCURLCreatorTests.h"
#import "AuthInfoProvider.h"
#import "ServerConfiguration.h"
#import "URLCreator.h"
#import "YAMMCURLCreator.h"

@interface YAMMCURLCreatorTests()

@property (strong, nonatomic) id authInfoProviderMock;
@property (strong, nonatomic) id serverConfigurationMock;
@property (strong, nonatomic) id urlCreatorMock;
@property (strong, nonatomic) YAMMCURLCreator *mmcURLCreator;

@end

@implementation YAMMCURLCreatorTests

@synthesize authInfoProviderMock = authInfoProviderMock_;
@synthesize mmcURLCreator = mmcURLCreator_;
@synthesize serverConfigurationMock = serverConfigurationMock_;
@synthesize urlCreatorMock = urlCreatorMock_;

- (void)setUp
{
    [self setAuthInfoProviderMock:[OCMockObject mockForProtocol:@protocol(AuthInfoProvider)]];
    [self setServerConfigurationMock:[OCMockObject mockForProtocol:@protocol(ServerConfiguration)]];
    [self setUrlCreatorMock:[OCMockObject mockForProtocol:@protocol(URLCreator)]];
    
    [self setMmcURLCreator:[[YAMMCURLCreator alloc] init]];
    [[self mmcURLCreator] setUrlCreator:[self urlCreatorMock]];
    [[self mmcURLCreator] setServerConfiguration:[self serverConfigurationMock]];
    [[self mmcURLCreator] setAuthInfoProvider:[self authInfoProviderMock]];
}

- (void)testUsesURLCreatorToBuildURLWithHttpSchemeMMCServerGivenRelativeURIAndGivenParamsWithCrumbAdded
{
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"obj" forKey:@"key"];
    NSString *crumb = @"crumb";
    NSString *mmcServer = @"mmcServer";
    NSString *relativeURI = @"relativeURI";
    NSString *url = @"url";
    
    [[[[self serverConfigurationMock] expect] andReturn:mmcServer] mmcServerHostname];
    [[[[self authInfoProviderMock] expect] andReturn:crumb] crumb];
    
    [[[[self urlCreatorMock] expect] andReturn:url] createWithScheme:@"http" server:mmcServer relativeURI:relativeURI params:[OCMArg checkWithBlock:^BOOL(id obj) {
        
        NSDictionary *params = obj;
        
        if ([[params objectForKey:@"c"] isEqualToString:crumb] && [[params objectForKey:@"key"] isEqualToString:@"obj"]) {
            return YES;
        }
        
        return NO;
    }]];
    
    [[self mmcURLCreator] createMMCURLWithRelativeURI:relativeURI params:params];
    
    [[self serverConfigurationMock] verify];
    [[self authInfoProviderMock] verify];
    [[self urlCreatorMock] verify];
}

- (void)testSupportsCreatingMMCURLWithNoAdditionalParameters
{
    NSString *crumb = @"crumb";
    NSString *mmcServer = @"mmcServer";
    NSString *relativeURI = @"relativeURI";
    NSString *url = @"url";
    
    [[[[self serverConfigurationMock] expect] andReturn:mmcServer] mmcServerHostname];
    [[[[self authInfoProviderMock] expect] andReturn:crumb] crumb];
    
    [[[[self urlCreatorMock] expect] andReturn:url] createWithScheme:@"http" server:mmcServer relativeURI:relativeURI params:[OCMArg checkWithBlock:^BOOL(id obj) {
        
        NSDictionary *params = obj;
        
        if ([[params objectForKey:@"c"] isEqualToString:crumb]) {
            return YES;
        }
        
        return NO;
    }]];
    
    [[self mmcURLCreator] createMMCURLWithRelativeURI:relativeURI];
    
    [[self serverConfigurationMock] verify];
    [[self authInfoProviderMock] verify];
    [[self urlCreatorMock] verify];
}

@end
