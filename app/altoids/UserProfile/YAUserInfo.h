//
//  YAUserInfo.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfileUpdateStatus.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserInfo : NSObject

#pragma mark @property declarations
#pragma mark @property declarations
@property (copy, readonly, nonatomic) NSString *firstName;
@property (copy, readonly, nonatomic) NSString *lastName;
@property (copy, readonly, nonatomic) NSString *photoUrl;
@property (copy, readonly, nonatomic) NSString *guid;
@property (assign, readonly, nonatomic) YAProfileUpdateStatus profileUpdateStatus;
@property (assign, readonly, nonatomic) YAImageUpdateStatus imageUpdateStatus;
@property (copy, readonly, nonatomic) NSDate *lastUpdated;

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithFirstName:(NSString *)aFirstName 
               lastName:(NSString *)aLastName 
               photoUrl:(NSString *)aPhotoUrl
                   guid:(NSString *)aGuid
    profileUpdateStatus:(YAProfileUpdateStatus)theProfileUpdateStatus
      imageUpdateStatus:(YAImageUpdateStatus)theImageUpdateStatus
            lastUpdated:(NSDate *)theLastUpdatedDate;


@end
