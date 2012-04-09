//
//  YAContactAddressFormatterTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <OCMock/OCMock.h>
#import "YAContactAddressFormatter.h"
#import "ContactAddressLabelFormatter.h"
#import "YAContactAddress.h"
#import "YAContactPhoneNumberAddress.h"

@interface YAContactAddressFormatterTests : SenTestCase
{
    YAContactAddressFormatter* addressFormatter;
    id addressLabelFormatterMock;
}
@end

@implementation YAContactAddressFormatterTests

- (void) setUp
{
    addressLabelFormatterMock = [OCMockObject mockForProtocol:@protocol(ContactAddressLabelFormatter)];

    addressFormatter = [[YAContactAddressFormatter alloc] init];
    [addressFormatter setContactAddressLabelFormatter:addressLabelFormatterMock];
}


- (void) testFormattedAddressAndLabelShouldReturnEmptyStringForNonPhoneNumberAddressAtLeastForNow
{
    YAContactAddress* address = [[YAContactAddress alloc] initWithLabel:@"whatever"];

    NSString* formattedAddress = [addressFormatter formattedAddressAndLabel:address];
    STAssertTrue([formattedAddress length] == 0, nil);
}

- (void) testFormattedAddressAndLabelGivenPhoneNumberAddressShouldReturnPhoneNumberFollowedBySpaceFollowedByLabelFromLabelFormatterInParens
{
    NSString* rawPhoneNumber = @"1-800-GOTMILK?";
    NSString* rawLabel = @"raw iOS address label";
    NSString* formattedLabel = @"pretty display label";
    YAContactAddress* address = [[YAContactPhoneNumberAddress alloc] initWithDisplayPhoneNumber:rawPhoneNumber label:rawLabel];
    
    [[[addressLabelFormatterMock expect] andReturn:formattedLabel] formattedLabelForAddress:address];
    
    NSString* formattedAddress = [addressFormatter formattedAddressAndLabel:address];    
    NSString* expectedResult = [[[[rawPhoneNumber stringByAppendingString:@" "] stringByAppendingString:@"("] stringByAppendingString:formattedLabel] stringByAppendingString:@")"];
    STAssertEqualObjects(expectedResult, formattedAddress, nil);
    [addressLabelFormatterMock verify];
}


@end
