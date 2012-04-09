// Copyright (c) 2009 Yahoo!, Inc. All Rights Reserved.
//
// This source code and specific concepts contained herein are confidential
// information and property of Yahoo!, Inc. Distribution is prohibited
// without written permission.
//
// $Id: $

#import "NSString+URLParamEncoding.h"


@implementation NSString(URLParamEncoding)

- (NSString *)stringByURLEncodingAsStringParameter {
	// NSURL's stringByAddingPercentEscapesUsingEncoding: does not escape
	// some characters that should be escaped in URL parameters, like / and ?; 
	// we'll use CFURL to force the encoding of those
	//
	// We'll explicitly leave spaces unescaped now, and replace them with +'s
	//
	// Reference: http://www.ietf.org/rfc/rfc3986.txt
	
	NSString *resultStr = self;
	
	CFStringRef originalString = (__bridge CFStringRef)self;
	CFStringRef leaveUnescaped = CFSTR(" ");
	CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
	
	CFStringRef escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
														 originalString,
														 leaveUnescaped, 
														 forceEscaped,
														 kCFStringEncodingUTF8);
	
	if (escapedStr) {
		NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
		CFRelease(escapedStr);
		
		// replace spaces with plusses
		[mutableStr replaceOccurrencesOfString:@" "
									withString:@"+"
									   options:0
										 range:NSMakeRange(0, [mutableStr length])];
		resultStr = mutableStr;
	}

	return resultStr;
}

@end
