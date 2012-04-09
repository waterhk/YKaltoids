//
//  YAContactPredicateCreator.m
//  altoids
//
//  Created by Jon Herron on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAContactPredicateCreator.h"

#define kPredicateMatchingContactEndpointsWithContactsWithGivenNameFormat @"contact.givenName == %@"
#define kPredicateMatchingContactEndpointsWithContactsWithFamilyNameFormat @"contact.familyName == %@"
#define kPredicateMatchingContactEndpointsWithContactsWithGivenNameAndFamilyNameFormat @"contact.givenName == %@ AND contact.familyName == %@"
#define kPredicateMatchingContactsWithAnyNameBeginningWith @"givenName beginswith[c] %@ OR familyName beginswith[c] %@"


@implementation YAContactPredicateCreator


- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithGivenName:(NSString *)givenName
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingContactEndpointsWithContactsWithGivenNameFormat, givenName];
}

- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithFamilyName:(NSString *)familyName
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingContactEndpointsWithContactsWithFamilyNameFormat, familyName];
}

- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithGivenName:(NSString *)givenName andFamilyName:(NSString *)familyName
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingContactEndpointsWithContactsWithGivenNameAndFamilyNameFormat, givenName, familyName];
}

- (NSPredicate *)predicateMatchingContactsWithAnyNameBeginningWith:(NSString*)prefix
{
    return [NSPredicate predicateWithFormat:kPredicateMatchingContactsWithAnyNameBeginningWith, prefix, prefix];
}


@end
