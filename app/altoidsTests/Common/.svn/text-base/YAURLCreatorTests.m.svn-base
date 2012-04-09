//
//  YAURLCreatorTests.m
//  altoids
//
//  Created by Jon Herron on 9/15/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLCreatorTests.h"
#import "YAURLCreator.h"

@interface YAURLCreatorTests()

@property (strong, nonatomic) YAURLCreator *urlCreator;

@end

@implementation YAURLCreatorTests

@synthesize urlCreator = urlCreator_;

- (void)setUp
{
    [self setUrlCreator:[[YAURLCreator alloc] init]];
}

- (void)testCreatesURLWithGivenSchemeServerRelativeURIAndParams
{
    NSString *scheme = @"scheme";
    NSString *server = @"server";
    NSString *relativeURI = @"relativeURI";
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"obj" forKey:@"key"];
    
    NSString *expectedURLString = @"scheme://server/relativeURI?key=obj";
    NSURL *url = [[self urlCreator] createWithScheme:scheme server:server relativeURI:relativeURI params:params];
    
    STAssertTrue([expectedURLString isEqualToString:[url absoluteString]], @"Unexpected url returned from builder");
}

- (void)testIfParamsAreEmptyThenURLEndsWithRelativeURL
{
    NSString *scheme = @"scheme";
    NSString *server = @"server";
    NSString *relativeURI = @"relativeURI";
    NSDictionary *params = [NSDictionary dictionary];
    
    NSString *expectedURLString = @"scheme://server/relativeURI";
    NSURL *url = [[self urlCreator] createWithScheme:scheme server:server relativeURI:relativeURI params:params];
    
    STAssertTrue([expectedURLString isEqualToString:[url absoluteString]], @"Unexpected url returned from builder");
}

@end
