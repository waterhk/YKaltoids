//
//  YAAddressBookLoader.m
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAddressBookLoader.h"
#import "AppFactory.h"
#import "AddressBook/AddressBook.h"
#import "YAContact.h"
#import "YAContactRecordID.h"
#import "YAContactPhoneNumberAddress.h"
#import "MutableArrayCreator.h"
#import "Timer.h"

@implementation YAAddressBookLoader

@synthesize mutableArrayCreator = mutableArrayCreator_,
            sortDescriptors = sortDescriptors_,
            timerInstanceFactory = timerInstanceFactory_;


- (NSArray*) contactsFromAddressBook
{
    id<Timer> timer = [timerInstanceFactory_ createTimer];
    [timer beginAccumulatingForTag:@"total"];
    
    ABAddressBookRef addressBook = ABAddressBookCreate();

    [timer beginAccumulatingForTag:@"0 copy array of all people"];
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    [timer stopAccumulatingForTag:@"0 copy array of all people"];

    CFIndex allPeopleCount = CFArrayGetCount(allPeople);
    NSMutableArray* contacts = [[self mutableArrayCreator] mutableArrayWithCapacity:allPeopleCount];
    NSUInteger allPhoneNumbersCount = 0;

    [timer beginAccumulatingForTag:@"1 copy all records to YAContact objects"];
    for(CFIndex personIndex = 0; personIndex < allPeopleCount; ++personIndex)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, personIndex);      // TODO verify that this does not leak (it shouldn't according to "The Get Rule")

        NSString* givenName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString* familyName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        NSString* compositeName = CFBridgingRelease(ABRecordCopyCompositeName(person));
        YAContactRecordID* recordID = [[YAContactRecordID alloc] initWithABRecordID:ABRecordGetRecordID(person)];

        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneNumbersCount = ABMultiValueGetCount(phoneNumbers);
        if(!phoneNumbersCount)
        {
            continue;
        }
        allPhoneNumbersCount += phoneNumbersCount;
        
        NSMutableArray* contactPhoneNumberAddresses = [[self mutableArrayCreator] mutableArrayWithCapacity:phoneNumbersCount];
        for(CFIndex phoneNumbersIndex = 0; phoneNumbersIndex < phoneNumbersCount; ++phoneNumbersIndex)
        {
            NSString* value = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, phoneNumbersIndex));
            NSString* label = CFBridgingRelease(ABMultiValueCopyLabelAtIndex(phoneNumbers, phoneNumbersIndex));

            YAContactPhoneNumberAddress* phoneNumber = [[YAContactPhoneNumberAddress alloc] initWithDisplayPhoneNumber:value label:label];
            [contactPhoneNumberAddresses addObject:phoneNumber];

            // TODO consider priming the comparison format cache (to be ready for typeahead and participant->contact matching):
            // just add phoneNumberNormalizer as a dependency and call comparisonFormatForPhoneNmber:value here (ignoring the result)
        }
        CFRelease(phoneNumbers);

        
        YAContact* contact = [[YAContact alloc] initWithRecordID:recordID givenName:givenName familyName:familyName compositeName:compositeName phoneNumberAddresses:contactPhoneNumberAddresses];
        [contacts addObject:contact];
    }
    [timer stopAccumulatingForTag:@"1 copy all records to YAContact objects"];


    CFRelease(allPeople);
    CFRelease(addressBook);

    [timer beginAccumulatingForTag:@"2 sort contacts"];
    NSArray* sortedContacts = [contacts sortedArrayUsingDescriptors:sortDescriptors_];
    [timer stopAccumulatingForTag:@"2 sort contacts"];

    [timer stopAccumulatingForTag:@"total"];

    // TODO log with session logger instead of NSLog
    NSLog(@"%f seconds to load %u phone numbers across %ld contacts", [timer accumulatedSecondsForTag:@"total"], allPhoneNumbersCount, allPeopleCount);
    NSLog(@"%@", [timer descriptionOfAccumulatedSecondsForAllTags]);

    return sortedContacts;
}

- (NSData*) imageDataForContact:(YAContact*)contact
{
    NSData* imageData = nil;

    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, [[contact recordID] abRecordIDValue]);       // TODO verify that this does not leak (it shouldn't according to "The Get Rule")
    if(person && ABPersonHasImageData(person))
    {
        imageData = CFBridgingRelease(ABPersonCopyImageData(person));
    }

    CFRelease(addressBook);

    return imageData;
}


@end
