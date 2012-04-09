//
//  PhoneNumberNormalizer.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PhoneNumberNormalizer <NSObject>


// ye164FormattedPhoneNumber:
// Returns the given phone number, formatted as a YE164 number after normalizing it.
//
// "YE164" is the name we use for the normalized format required by the MMC APIs,
// which is the standard E164 format except without its leading "+" prefix.
//
// If the given phone number is not already in an internationalized format
// (i.e., prefixed with + or the local international dialing prefix, followed by a country code),
// then the number is normalized according to the user's region
// (determined by carrier/SIM, falling back to device locale, finally defaulting to US).
//
// For example, assuming the user is in the "US" region:
// YE164("(404) 495-3456") => "14044953456"
// YE164("4044953456") => "14044953456"
// YE164("+1 (404) 495-3456") => "14044953456"
// YE164("+14044953456") => "14044953456"
// YE164("1 (404) 495-3456") => "114044953456"    // note the input's lack of a prefixing +, causing the leading 1 to not be understood to be a country code, producing an undesirable result
// YE164("+4670 730 6966") => "46707306966"
// YE164("0114670 730 6966") => "46707306966"
//
- (NSString*) ye164FormatForPhoneNumber:(NSString*)phoneNumber;


// comparisonFormatForPhoneNumber:
// Returns the given phone number, formatted in a manner useful only for comparing with other numbers formatted with this same method.
// NOTE The returned string is NOT useful for display or communicating with MMC.
//
// The comparison-formatted phone number is useful for efficiently comparing a number against a large set of numbers,
// such as when matching user input to the user's address book during typeahead, or matching MMC participant addresses against the user's address book.
// In such use cases, full phone number normalization is prohibitively expensive
// (we've seen this with the Java implementation of libphonenumber; we can profile and verify for C++ once we've added libphonenumber),
// and so we provide this cheaper, less accurate method instead.
// NOTE Equivalent phone numbers do NOT always result in the same formatted string
// (it would require full normalization to accomplish that, defeating the performance advance we are looking for).
// 
- (NSString*) comparisonFormatForPhoneNumber:(NSString*)phoneNumber;

@end
