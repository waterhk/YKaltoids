//
//  YATextFormatterTests.m
//  altoids
//
//  Created by Devin Doman on 3/22/12.
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import <objc/runtime.h>
#import "YATextFormatter.h"


@interface YATextFormatterTests : YATestCase
{
    YATextFormatter* textFormatter;
    NSString* errFormat;
}
@end

@implementation YATextFormatterTests

- (void) setUp
{
    textFormatter = [[YATextFormatter alloc] init];
    errFormat = @"Unexpected result: %@";
}

#pragma mark -
#pragma mark text formatter tests

- (void) testTextFormatterIfGivenInputContainsAmpersandEntity
{
    NSString* entityString = @"Jake &amp; You";
    NSString* result = [textFormatter formatTextForDisplay:entityString];
    NSString* errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Jake & You"], errMsg);
}

- (void) testTextFormatterIfGivenInputContainsApostropheEntity
{
    NSString* entityString = @"Jake&#39;s";
    NSString* result = [textFormatter formatTextForDisplay:entityString];
    NSString* errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Jake's"], errMsg);
    
    entityString = @"Nate&apos;s";
    result = [textFormatter formatTextForDisplay:entityString];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Nate's"], errMsg);
}

- (void) testTextFormatterIfGivenInputContainsAngleBracketEntity
{
    NSString* entityString = @"&#60;Jake";
    NSString* result = [textFormatter formatTextForDisplay:entityString];
    NSString* errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"<Jake"], errMsg);
    
    entityString = @"Nate&gt;";
    result = [textFormatter formatTextForDisplay:entityString];
    errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"Nate>"], errMsg);
}

- (void) testTextFormatterIfGivenInputContainsQuotationEntity
{
    NSString* entityString = @"&quot;gersy&#34;";
    NSString* result = [textFormatter formatTextForDisplay:entityString];
    NSString* errMsg = [NSString stringWithFormat:errFormat, result];
    STAssertTrue([result isEqualToString:@"\"gersy\""], errMsg);
}


@end