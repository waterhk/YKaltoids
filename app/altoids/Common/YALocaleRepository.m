//
//  YALocaleRepository.m
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YALocaleRepository.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "YASessionLogger.h"

@implementation YALocaleRepository

@synthesize iso3166RegionCode = iso3166RegionCode_;

- (NSString*) determineISO3166RegionCode
{
    NSString* regionCode;
    
    // first try to get region from carrier/SIM card
    CTTelephonyNetworkInfo *telephonyNetworkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier* carrier = [telephonyNetworkInfo subscriberCellularProvider];
    
    regionCode = [carrier isoCountryCode];                  // "This property uses the ISO 3166-1 country code representation."
    if([regionCode length])
    {
        YASessionLogDebug(@"region code from carrier: %@", regionCode);
        return [regionCode uppercaseString];
    }
    
    // now try current locale
    NSLocale* locale = [NSLocale currentLocale];
    regionCode = [locale objectForKey:NSLocaleCountryCode]; // "The region code is defined by ISO 3166-1"
    if([regionCode length])
    {
        YASessionLogDebug(@"region code from current locale: %@", regionCode);
        return [regionCode uppercaseString];
    }
    
    // fall back to system locale
    locale = [NSLocale systemLocale];
    regionCode = [locale objectForKey:NSLocaleCountryCode]; // "The region code is defined by ISO 3166-1"
    if([regionCode length])
    {
        YASessionLogDebug(@"region code from system locale: %@", regionCode);
        return [regionCode uppercaseString];
    }
    
    // give up and assume US
    YASessionLogDebug(@"defaulted to region code: %@", regionCode);
    return @"US";
}


- (NSString*) iso3166RegionCode
{
    if(!iso3166RegionCode_)
    {
        iso3166RegionCode_ = [self determineISO3166RegionCode];
        YASessionLogDebug(@"determined ISO3166 region code: %@", iso3166RegionCode_);
    }

    return iso3166RegionCode_;

}


@end
