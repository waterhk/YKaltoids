//
//  YAReportProblemWebServiceParametersTests.m
//  altoids
//
//  Created by Xianzhe Ma on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAReportProblemWebServiceParametersTests.h"

#import "YAReportProblemWebServiceParameters.h"
#import "YAURLParameterEncoder.h"

@implementation YAReportProblemWebServiceParametersTests

- (void)setUp {
    [super setUp];
    
    reportProblemWebServiceParameters_ = [[YAReportProblemWebServiceParameters alloc] init];
}

// All code under test must be linked into the Unit Test bundle
- (void)testInternationalShouldReturnUS
{
    NSString *international = [reportProblemWebServiceParameters_ international];
    STAssertEqualObjects(international, @"us", @"International should be us");
}

- (void)testVendorIdShouldReturn512AccordingToTwiki {
    NSString *vendorIdFromTwikiIs512 = @"512";
    
    NSString *vendorId = [reportProblemWebServiceParameters_ vendorId];
    
    STAssertEqualObjects(vendorId, vendorIdFromTwikiIs512, @"Vendor Id from Twiki is 512");
}

- (void)testUserCommentShouldBeEncodedWithHtmlEntities {
    NSString *originalUserComment = @"a b";
    [reportProblemWebServiceParameters_ setUrlParameterEncoder:[[YAURLParameterEncoder alloc] init]];
    [reportProblemWebServiceParameters_ setUserComment:originalUserComment];
    
    NSString *encodedUserComment = @"a%20b";
    STAssertEqualObjects([reportProblemWebServiceParameters_ userComment], encodedUserComment, @"User comment should be html encoded");
}

@end
