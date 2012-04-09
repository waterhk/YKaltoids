//
//  LibPhoneNumberUtil.h
//  altoids
//
//  Created by Derrick Whittle on 3/2/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


// LibPhoneNumberUtil provides an Objective-C interface to the C++ libphonenumber library
@protocol LibPhoneNumberUtil <NSObject>


// e164FormatForPhoneNumber:inIso3661Region:
// Returns the given phone number, formatted as an E164 number after normalizing it by assuming the given region.
//
// If the given phone number is not already in an internationalized format
// (i.e., prefixed with + or the local international dialing prefix, followed by a country code),
// the given region is used to normalize it into an international format as required for E164.
//
// For example:
// E164("(404) 495-3456", "US") => "14044953456"
// E164("4044953456", "US") => "14044953456"
// E164("+1 (404) 495-3456", "US") => "14044953456"
// E164("+14044953456", "US") => "14044953456"
// E164("1 (404) 495-3456", "US") => "114044953456"    // note the input's lack of a prefixing +, causing the leading 1 to not be understood to be a country code, producing an undesirable result
// E164("+4670 730 6966", "US") => "46707306966"
// E164("0114670 730 6966", "US") => "46707306966"
//
- (NSString*) e164FormatForPhoneNumber:(NSString*)phoneNumber inIso3661Region:(NSString*)iso3661Region;

@end
