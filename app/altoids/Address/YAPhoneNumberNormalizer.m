//
//  YAPhoneNumberNormalizer.m
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAPhoneNumberNormalizer.h"
#import "LocaleRepository.h"
#import "LibPhoneNumberUtil.h"

@implementation YAPhoneNumberNormalizer

@synthesize localeRepository = localeRepository_,
            libPhoneNumberUtil = libPhoneNumberUtil_;


- (NSString*) ye164FormatForPhoneNumber:(NSString*)phoneNumber
{
    NSString* iso3661RegionCode = [localeRepository_ iso3166RegionCode];
    NSString* e164PhoneNumber = [libPhoneNumberUtil_ e164FormatForPhoneNumber:phoneNumber inIso3661Region:iso3661RegionCode];
    if(![e164PhoneNumber length])
    {
        return e164PhoneNumber;
    }
    
    // to convert form E164 to the YE164 format needed for MMC, we just need to strip the prefixing "+"
    // (all E164 formatted numbers must be prefixed with this +, so it's safe to simply strip the first character)
    return [e164PhoneNumber substringFromIndex:1];      // TODO test with the input string: "+"
}

- (NSString*) comparisonFormatForPhoneNumber:(NSString*)phoneNumber
{
    // TODO after we determine this method is really necessary (after profiling libphonenumber), we need to improve the algorithm

    NSString* strippedDigits = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    if(![strippedDigits length])
    {
        return strippedDigits;
    }
    
    // assume US for now (this is just a placeholder)
    if([strippedDigits characterAtIndex:0] != '1')
    {
        return [@"1" stringByAppendingString:strippedDigits];
    }
    return strippedDigits;
}

@end
