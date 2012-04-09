//
//  YAContact.h
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YAContactRecordID;

@interface YAContact : NSObject

@property (nonatomic, strong, readonly) NSString* givenName;
@property (nonatomic, strong, readonly) NSString* familyName;
@property (nonatomic, strong, readonly) NSString* compositeName;
@property (nonatomic, strong, readonly) YAContactRecordID* recordID;
@property (nonatomic, strong, readonly) NSArray* phoneNumberAddresses;      // array of YAContactPhoneNumberAddress*
@property (nonatomic, strong, readonly) NSArray* emailAddresses;            // array of YAContactEmailAddress*


- (id) initWithRecordID:(YAContactRecordID*)recordID givenName:(NSString*)givenName familyName:(NSString*)familyName compositeName:(NSString*)compositeName phoneNumberAddresses:(NSArray *)phoneNumberAddresses;

@end
