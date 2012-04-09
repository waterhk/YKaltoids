//
//  YAContactEndpointLocator.m
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactEndpointLocator.h"
#import "PhoneNumberNormalizer.h"
#import "YAContact.h"
#import "YAContactPhoneNumberAddress.h"
#import "YAContactEndpoint.h"

@implementation YAContactEndpointLocator

@synthesize phoneNumberNormalizer = phoneNumberNormalizer_;


- (void) addContactEndpointsFromContacts:(NSArray*)contacts havingPhoneNumbersBeginningWithString:(NSString*)typeaheadQuery toMatchingContactEndpoints:(NSMutableArray*)matchingContactEndpoints andMatchingContacts:(NSMutableSet*)matchingContacts
{
    NSString* comparisonFormattedTypeaheadQuery = [phoneNumberNormalizer_ comparisonFormatForPhoneNumber:typeaheadQuery];
    if(![comparisonFormattedTypeaheadQuery length])
    {
        return;
    }

    // TODO to test this easily, it'd be nice to have a ContactEnumerator that walks all addresses in a contact, performing a given selector or block on each address;
    // that way, we could test that this method uses the ContactEnumerator with the right selector/block,
    // then separately test the selector/block that adds the contacts/addresses to the collections based on the right comparison,
    // then separately (and only once for everyone using it) test that ContactEnumerator applies the selector/block to all addresses.
    // Without that, it'd be a pain to try to test this with the three concerns mixed up.
    // Before that, we need to think through how we really want to handle multiple types of addresses (email).
    for(YAContact* contact in contacts)
    {
        for(YAContactPhoneNumberAddress* phoneNumberAddress in [contact phoneNumberAddresses])
        {
            if([[phoneNumberNormalizer_ comparisonFormatForPhoneNumber:[phoneNumberAddress displayPhoneNumber]] hasPrefix:comparisonFormattedTypeaheadQuery])
            {
                [matchingContactEndpoints addObject:[[YAContactEndpoint alloc] initWithContact:contact address:phoneNumberAddress]];
                [matchingContacts addObject:contact];
            }
        }
    }
}

- (void) addContactEndpointsFromContacts:(NSArray*)contacts matchingPhoneNumber:(NSString*)phoneNumber toMatchingContactEndpoints:(NSMutableArray*)matchingContactEndpoints andMatchingContacts:(NSMutableSet*)matchingContacts
{
    NSString* comparisonFormattedPhoneNumber = [phoneNumberNormalizer_ comparisonFormatForPhoneNumber:phoneNumber];
    if(![comparisonFormattedPhoneNumber length])
    {
        return;
    }

    for(YAContact* contact in contacts)
    {
        for(YAContactPhoneNumberAddress* phoneNumberAddress in [contact phoneNumberAddresses])
        {
            if([comparisonFormattedPhoneNumber isEqualToString:[phoneNumberNormalizer_ comparisonFormatForPhoneNumber:[phoneNumberAddress displayPhoneNumber]]])
            {
                [matchingContactEndpoints addObject:[[YAContactEndpoint alloc] initWithContact:contact address:phoneNumberAddress]];
                [matchingContacts addObject:contact];
            }
        }
    }    
}


@end
