//
//  YAYAContactAddressLabelFormatterTests.m
//  altoids
//
//  Created by Derrick Whittle on 2/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "YAContactAddressLabelFormatter.h"
#import "YAContactAddress.h"

@interface YAYAContactAddressLabelFormatterTests : SenTestCase
{
    YAContactAddressLabelFormatter* formatter;
    NSString* rawiOSAddressBookInternalLabelForMobile;;
}
@end

@implementation YAYAContactAddressLabelFormatterTests

- (void) setUp
{
    formatter = [[YAContactAddressLabelFormatter alloc] init];
    rawiOSAddressBookInternalLabelForMobile = @"_$!<Mobile>!$_";
}

- (YAContactAddress*) createAddressWithLabel:(NSString*)label
{
    return [[YAContactAddress alloc] initWithLabel:label];
}

- (NSNumber*) retainCountOfObject:(NSObject*)object
{
    return [object valueForKey:@"retainCount"];
}


- (void) testFormattedLabelForAddressDoesReturnMobileForMobileContactAddressAssumingTestIsRunUnderUSEnglishLocale
{
    // sanity test of the actual formatting operation, which uses the SDK to localize the internal label values (like _$!<Home>!$_)
    NSString* iOSInternalAddressBookLabelForMobileFields = rawiOSAddressBookInternalLabelForMobile;
    YAContactAddress* address = [self createAddressWithLabel:iOSInternalAddressBookLabelForMobileFields];

    NSString* formattedLabel = [formatter formattedLabelForAddress:address];
    STAssertEqualObjects(@"mobile", formattedLabel, nil);
}

- (void) testFormattedLabelForAddressShouldTransferOwnershipOfReturnedStringToCaller
{
    // The goal here is to test that we are correctly transferring ownership from Core Foundation to Cocoa and on to the caller.
    // It's complicated a bit by ARC, and the fact that the strings returned by the AddressBook API are aliased.
    // (The real goal of this test is to make sure I understand Core Foundation memory management in an ARC world.)
    
    // What we must do to test this is --
    // Call the formatter to get a string for a label. Its retain count becomes our basis.
    // Now call the formatter to get another string (for the same label); this will be an alias to the first string.
    // The retain count of the original string will go up (because there's a new alias to it).
    // Now release the second string we got.
    // Now the retain count of the original string should return to what it was before we got the second string -- no leak.
    
    NSString* formattedLabel = [formatter formattedLabelForAddress:[self createAddressWithLabel:rawiOSAddressBookInternalLabelForMobile]];
    NSNumber* retainCountBasis = [self retainCountOfObject:formattedLabel];

    // we must use an autorelease pool to fully clean up from the second instance (otherwise the 2 autoreleases pending on it artificially inflate the remaining retain count)
    @autoreleasepool
    {
        NSString* formattedLabelAgainForSameLabel = [formatter formattedLabelForAddress:[self createAddressWithLabel:rawiOSAddressBookInternalLabelForMobile]];
        NSNumber* retainCountAfterSecondInstanceReturned = [self retainCountOfObject:formattedLabelAgainForSameLabel];

        // confirm that the second returned label is really aliased to our original returned label (so our original's retain count should also have increased)
        STAssertTrue([retainCountAfterSecondInstanceReturned unsignedIntValue] > [retainCountBasis unsignedIntValue], nil);
        STAssertEqualObjects(retainCountAfterSecondInstanceReturned, [self retainCountOfObject:formattedLabel], nil);

        // now release the second label we acquired so we can see if the retain count returns to the original level
        formattedLabelAgainForSameLabel = nil;
    }

    // finally, the retain count of the original formatted label should now have returned to the basis count -- demonstrating there is no leak
    STAssertEqualObjects(retainCountBasis, [self retainCountOfObject:formattedLabel], nil);    
}

- (void) testFormattedLabelForAddressShouldNotRetainGivenAddressOrItsLabel
{
    YAContactAddress* address = [self createAddressWithLabel:rawiOSAddressBookInternalLabelForMobile];
    NSNumber* addressRetainCountBasis = [self retainCountOfObject:address];
    NSNumber* labelRetainCountBasis = [self retainCountOfObject:[address label]];

    [formatter formattedLabelForAddress:address];
    
    STAssertEqualObjects(addressRetainCountBasis, [self retainCountOfObject:address], nil);
    STAssertEqualObjects(labelRetainCountBasis, [self retainCountOfObject:[address label]], nil);
}


@end
