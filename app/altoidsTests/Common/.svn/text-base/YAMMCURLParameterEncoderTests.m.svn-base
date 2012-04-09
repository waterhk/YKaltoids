//
//  YAMMCURLParameterEncoderTests.m
//  altoids
//
//  Created by Jon Herron on 10/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "YAMMCURLParameterEncoderTests.h"
#import "URLParameterEncoder.h"
#import "YAMMCURLParameterEncoder.h"

@interface YAMMCURLParameterEncoderTests()

@property (strong, nonatomic) id urlParameterEncoderMock;
@property (strong, nonatomic) YAMMCURLParameterEncoder *mmcURLParameterEncoder;

@end

@implementation YAMMCURLParameterEncoderTests

@synthesize urlParameterEncoderMock = urlParameterEncoderMock_;
@synthesize mmcURLParameterEncoder = mmcURLParameterEncoder_;

- (void)setUp
{
    [self setUrlParameterEncoderMock:[OCMockObject mockForProtocol:@protocol(URLParameterEncoder)]];
    [self setMmcURLParameterEncoder:[[YAMMCURLParameterEncoder alloc] init]];
    [[self mmcURLParameterEncoder] setUrlParameterEncoder:[self urlParameterEncoderMock]];
}

- (void)testDoubleURLEncodesTheGivenURLParameterAsMMCRequiresThisAtTimes
{
    NSString *urlParameter = @"sigh@doubleencoding";
    
    [[[[self urlParameterEncoderMock] expect] andReturn:urlParameter] encodeURLParameter:urlParameter];
    [[[[self urlParameterEncoderMock] expect] andReturn:urlParameter] encodeURLParameter:urlParameter];
    
    STAssertEqualObjects(urlParameter, [[self mmcURLParameterEncoder] doubleEncodeURLParameterForMMC:urlParameter], @"Unexpected urlParameter");
}

@end
