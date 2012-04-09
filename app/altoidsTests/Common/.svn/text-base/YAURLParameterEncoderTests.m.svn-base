//
//  YAURLParameterEncoderTests.m
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAURLParameterEncoderTests.h"
#import "YAURLParameterEncoder.h"

@interface YAURLParameterEncoderTests()

@property (strong, nonatomic) YAURLParameterEncoder *urlParameterEncoder;

@end

@implementation YAURLParameterEncoderTests

@synthesize urlParameterEncoder = urlParameterEncoder_;

- (void)setUp
{
    [self setUrlParameterEncoder:[[YAURLParameterEncoder alloc] init]];
}

- (void)testWillNotEncodeUnreservedCharactersPerRFC3986
{
    NSString *expectedString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~._-";
    
    STAssertTrue([[[self urlParameterEncoder] encodeURLParameter:expectedString] isEqualToString:expectedString], @"Unexpected string");
}

- (void)testWillEncodeReservedCharactersPerRFC3986
{
    NSString *urlParameter = @"%:/?#[]@!$&'()*+,;=\"";
    NSString *expectedString = @"%25%3A%2F%3F%23%5B%5D%40%21%24%26%27%28%29%2A%2B%2C%3B%3D%22";
    NSString *encodedString = [[self urlParameterEncoder] encodeURLParameter:urlParameter];
    
    STAssertTrue([encodedString isEqualToString:expectedString], @"Unexpected string: %@", encodedString);
}

- (void)testHandlesMixedReservedAndUnreservedCharacters
{
    NSString *urlParameter = @"86399691609964/altoidsiosusr_us1@yahoo.com";
    NSString *expectedString = @"86399691609964%2Faltoidsiosusr_us1%40yahoo.com";
    NSString *encodedString = [[self urlParameterEncoder] encodeURLParameter:urlParameter];
    
    STAssertTrue([encodedString isEqualToString:expectedString], @"Unexpected string: %@", encodedString);
}

@end
