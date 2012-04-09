//
//  YALibPhoneNumberUtilTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YALibPhoneNumberUtil.h"

@interface YALibPhoneNumberUtilTests : SenTestCase
{
    YALibPhoneNumberUtil* libPhoneNumberUtil;
}
@end

@implementation YALibPhoneNumberUtilTests

- (void) setUp
{
    libPhoneNumberUtil = [[YALibPhoneNumberUtil alloc] init];
}


// YALibPhoneNumberUtil will merely wrap libphonenumber, so we're not testing
// our code here so much as validating via integration tests that it meets our requirements.


// http://twiki.corp.yahoo.com/view/Devel/AltoidsConversations#Number_Formatting_Logics
- (void) testE164FormatForPhoneNumberShouldMeetProductRequirementExamples
{
    STAssertEqualObjects(@"+14083065555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"408-306-5555" inIso3661Region:@"US"], nil);
    STAssertEqualObjects(@"+14083065555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"14083065555" inIso3661Region:@"US"], nil);
    STAssertEqualObjects(@"+14083065555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"+1 (408) 306-5555" inIso3661Region:@"US"], nil);
    STAssertEqualObjects(@"+46707306966", [libPhoneNumberUtil e164FormatForPhoneNumber:@"0114670 730 6966" inIso3661Region:@"US"], nil);
    STAssertEqualObjects(@"+46707306966", [libPhoneNumberUtil e164FormatForPhoneNumber:@"+4670 730 6966" inIso3661Region:@"US"], nil);

    // TODO re-enable this test once we're using libphonenumber (our placeholder doesn't handle this special case)
    // STAssertEqualObjects(@"+66868916414", [libPhoneNumberUtil e164FormatForPhoneNumber:@"086 891 6414" inIso3661Region:@"TH"], nil);
    STAssertEqualObjects(@"+66868916414", [libPhoneNumberUtil e164FormatForPhoneNumber:@"+66 86 891 6414" inIso3661Region:@"TH"], nil);
    STAssertEqualObjects(@"+14083065555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"001 1 408 306 5555" inIso3661Region:@"TH"], nil);

    STAssertEqualObjects(@"+14083495555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"+14083495555" inIso3661Region:@"IN"], nil);

    // from bug http://bug.corp.yahoo.com/show_bug.cgi?id=4905136:
    STAssertEqualObjects(@"+14083496764", [libPhoneNumberUtil e164FormatForPhoneNumber:@"+1-408-349-6764" inIso3661Region:@"IN"], nil);
    STAssertEqualObjects(@"+14083496764", [libPhoneNumberUtil e164FormatForPhoneNumber:@"001-408-349-6764" inIso3661Region:@"IN"], nil);

    // this is not a valid way to dial a US number from India!
    // TODO re-enable this test once we're using libphonenumber (our placeholder implementation doesn't produce the exact same result, though it doesn't really matter for now in this negative case)
    // STAssertEqualObjects(@"+9114083496764", [libPhoneNumberUtil e164FormatForPhoneNumber:@"01-408-349-6764" inIso3661Region:@"IN"], nil);

    // this is what happens when we double-normalize an international number!
    STAssertEqualObjects(@"+9114083495555", [libPhoneNumberUtil e164FormatForPhoneNumber:@"14083495555" inIso3661Region:@"IN"], nil);
}

@end
