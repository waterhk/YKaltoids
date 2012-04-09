//
//  ContactPredicateCreator.h
//  altoids
//
//  Created by Jon Herron on 11/3/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContactPredicateCreator <NSObject>
@required

- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithGivenName:(NSString *)givenName;
- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithFamilyName:(NSString *)familyName;
- (NSPredicate *)predicateMatchingContactEndpointsWithContactsWithGivenName:(NSString *)givenName andFamilyName:(NSString *)familyName;
- (NSPredicate *)predicateMatchingContactsWithAnyNameBeginningWith:(NSString*)prefix;

@end
