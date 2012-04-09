//
//  YAAddressNormalizer.m
//  altoids
//
//  Created by Jon Herron on 10/5/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAAddressNormalizer.h"
#import "AddressTypeDetector.h"

@implementation YAAddressNormalizer

@synthesize addressTypeDetector = addressTypeDetector_,
            smsAddressNormalizer = smsAddressNormalizer_;


// note we don't actually create a new instance of each normalizer (they hold no state, so it's unnecessary to create new objects);
// we're really just providing a dynamic way to select a normalizer
- (NSString*) normalizeAddress:(YAAddress*)address
{
    if ([[self addressTypeDetector] isSMSAddress:address] || [[self addressTypeDetector] isMMCAddressWithSMSAddressHandle:address])
    {
        return [smsAddressNormalizer_ normalizeAddress:address];
    }
    
    return nil;
}

@end
