//
//  YAPhoneNumberNormalizerTests.m
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATestCase.h"
#import "YAPhoneNumberNormalizer.h"
#import "LocaleRepository.h"
#import "LibPhoneNumberUtil.h"

@interface YAPhoneNumberNormalizerTests : YATestCase
{
    YAPhoneNumberNormalizer* normalizer;

    id localeRepositoryMock;
    id libPhoneNumberUtilMock;
}
@end


@implementation YAPhoneNumberNormalizerTests

- (void) setUp
{
    localeRepositoryMock = [OCMockObject mockForProtocol:@protocol(LocaleRepository)];
    libPhoneNumberUtilMock = [OCMockObject mockForProtocol:@protocol(LibPhoneNumberUtil)];
    
    normalizer = [[YAPhoneNumberNormalizer alloc] init];
    [normalizer setLocaleRepository:localeRepositoryMock];
    [normalizer setLibPhoneNumberUtil:libPhoneNumberUtilMock];
}


//
// ye164FormatForPhoneNumber
//

- (void) testYE164FormatForPhoneNumberShouldReturnNilWhenLibPhoneNumberUtilFormatIsNil
{
    [[localeRepositoryMock stub] iso3166RegionCode];
    [[[libPhoneNumberUtilMock expect] andReturn:nil] e164FormatForPhoneNumber:OCMOCK_ANY inIso3661Region:OCMOCK_ANY];

    NSString* result = [normalizer ye164FormatForPhoneNumber:@"whatever"];
    STAssertNil(result, nil);
    [libPhoneNumberUtilMock verify];
}

- (void) testYE164FormatForPhoneNumberShouldReturnEmptyStringWhenLibPhoneNumberUtilFormatIsEmptyString
{
    [[localeRepositoryMock stub] iso3166RegionCode];
    [[[libPhoneNumberUtilMock expect] andReturn:@""] e164FormatForPhoneNumber:OCMOCK_ANY inIso3661Region:OCMOCK_ANY];
    
    NSString* result = [normalizer ye164FormatForPhoneNumber:@"whatever"];
    STAssertTrue([result isKindOfClass:[NSString class]], nil);
    STAssertTrue(![result length], nil);
    [libPhoneNumberUtilMock verify];
}

- (void) testYE164FormatForPhoneNumberShouldReturnPrefixStrippedPhoneNumberE164FormattedByLibPhoneNumberUtilWithISO3661RegionCodeFromLocaleRepository
{
    NSString* rawPhoneNumber = @"some input phone number";
    NSString* ye164FormattedPhoneNumber = @"some e164 formatted phone number";
    NSString* e164FormattedPhoneNumber = [@"+" stringByAppendingString:ye164FormattedPhoneNumber];
    NSString* regionCode = @"some region code";

    [[[localeRepositoryMock expect] andReturn:regionCode] iso3166RegionCode];
    [[[libPhoneNumberUtilMock expect] andReturn:e164FormattedPhoneNumber] e164FormatForPhoneNumber:rawPhoneNumber inIso3661Region:regionCode];

    NSString* result = [normalizer ye164FormatForPhoneNumber:rawPhoneNumber];
    STAssertEqualObjects(ye164FormattedPhoneNumber, result, nil);
    [localeRepositoryMock verify];
    [libPhoneNumberUtilMock verify];
}


//
// comparisonFormatForPhoneNumber
//

// TODO no point in testing comparisonFormatForPhoneNumber until we're sure it's necessary, after profiling libphonenumber, and develop a real implementation


@end
