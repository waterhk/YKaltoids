//
//  ContactEndpointLocator.h
//  altoids
//
//  Created by Derrick Whittle on 3/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactEndpointLocator <NSObject>

// finds all contact endpoints with a given string prefixing their phone numbers
// this awkward signature is optimized for the typeahead search algorithm's implementation details (aggregating not just the endpoints but also a set of their contacts improves performance when matching other categories of results)
- (void) addContactEndpointsFromContacts:(NSArray*)contacts havingPhoneNumbersBeginningWithString:(NSString*)typeaheadQuery toMatchingContactEndpoints:(NSMutableArray*)matchingContactEndpoints andMatchingContacts:(NSMutableSet*)matchingContacts;

// finds all contact endpoints for phone numbers exactly matching a given phone number
- (void) addContactEndpointsFromContacts:(NSArray*)contacts matchingPhoneNumber:(NSString*)phoneNumber toMatchingContactEndpoints:(NSMutableArray*)matchingContactEndpoints andMatchingContacts:(NSMutableSet*)matchingContacts;

@end
