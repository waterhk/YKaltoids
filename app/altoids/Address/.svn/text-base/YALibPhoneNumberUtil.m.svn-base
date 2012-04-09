//
//  YALibPhoneNumberUtil.m
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YALibPhoneNumberUtil.h"

@implementation YALibPhoneNumberUtil

- (NSString*) e164FormatForPhoneNumber:(NSString*)phoneNumber inIso3661Region:(NSString*)iso3661Region
{
    // #define E164_INTERNATIONAL_PREFIX "+"
    // TODO use libphonenumber something like (this is a pseudocode adaptation of using Java libphonenumber; I haven't checked the actual C++ libphonenumber signatures)
    // libphonenumber::PhoneNumber parsedPhoneNumber = 0;
    // libphonenumber::PhoneNumberUtil util = libphonenumber::PhoneNumberUtil::getInstance();
    // try
    // {
    //    parsedPhoneNumber = util.parse(phoneNumber, iso3661Region);
    // }
    // catch(...) { }
    //
    // if(!parsedPhoneNumber)
    // {
    //    return nil;
    // }
    //
    // string formattedNormalizedNumber = util.format(parsedPhoneNumber, util.PhoneNumberFormat.E164);
    // // convert E164 to Y.E164 by stripping leading prefix
    // if(formattedNormalizedNumber starts with E164_INTERNATIONAL_PREFIX)
    // {
    //    formattedNormalizedNumber = formattedNormalizedNumber[1:];
    // }
    // return formattedNormalizedNumber;
    //


    //
    // PLACEHOLDER ONLY implementation until we integrate libphonenumber after the Alpha release!
    // This does NOT really handle international numbers!
    //
    // We are only attempting to support US, IN, and TH right now, for dev and QA testing.
    // Even for US/IN/TH, we are definitely not handling all cases correctly.
    //
    
    if(![phoneNumber length])
    {
        return phoneNumber;
    }

    // strip to a digits-only string
    NSString *strippedPhoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    if(![strippedPhoneNumber length])
    {
        return strippedPhoneNumber;
    }

    // internationalized numbers (beginning with a +) already have a country code, so we simply strip non-digits
    if([phoneNumber characterAtIndex:0] == '+')
    {
        return [@"+" stringByAppendingString:strippedPhoneNumber];
    }

    // this is all placeholder! for a real implementation, we wouldn't hardcode our data in conditionals
    NSString* countryCode = @"1";    // assume US
    NSString* localInternationalDialingPrefix = @"011";
    if([iso3661Region isEqualToString:@"IN"])
    {
        countryCode = @"91";
        localInternationalDialingPrefix = @"00";
    }
    else if([iso3661Region isEqualToString:@"TH"])
    {
        countryCode = @"66";
        localInternationalDialingPrefix = @"001";
    }

    // if the stripped phone number begins with the local international dialing prefix, then it already has a country code, so we simply remove the international dialing prefix and strip non-digits
    if([strippedPhoneNumber length] > [localInternationalDialingPrefix length] && [strippedPhoneNumber hasPrefix:localInternationalDialingPrefix])
    {
        return [@"+" stringByAppendingString:[strippedPhoneNumber substringFromIndex:[localInternationalDialingPrefix length]]];
    }

    // if the stripped phone number does not begin with the country code, prefix it
    // (this should work for the US since no area codes begin with 1, but I doubt it's valid for all regions)
    // we are not supporting all cases here; e.g., for TH a leading 0 should be stripped
    if([strippedPhoneNumber length] > [countryCode length] && ![strippedPhoneNumber hasPrefix:countryCode])
    {
        strippedPhoneNumber = [countryCode stringByAppendingString:strippedPhoneNumber];
    }

    return [@"+" stringByAppendingString:strippedPhoneNumber];
}

@end
