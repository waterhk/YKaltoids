//
//  YAUserInfo.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserInfo.h"

// Private class extension
@interface YAUserInfo ()

// @property definitions
@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *photoUrl;
@property (copy, nonatomic) NSString *guid;
@property (assign, nonatomic) YAProfileUpdateStatus profileUpdateStatus;
@property (assign, nonatomic) YAImageUpdateStatus imageUpdateStatus;
@property (copy, nonatomic) NSDate *lastUpdated;

// methods

@end

@implementation YAUserInfo

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

@synthesize firstName = firstName_;
@synthesize lastName = lastName_;
@synthesize photoUrl = photoUrl_;
@synthesize guid = guid_;
@synthesize profileUpdateStatus = profileUpdateStatus_;
@synthesize imageUpdateStatus = imageUpdateStatus_;
@synthesize lastUpdated = lastUpdated_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)initWithFirstName:(NSString *)aFirstName 
               lastName:(NSString *)aLastName 
               photoUrl:(NSString *)aPhotoUrl
                   guid:(NSString *)aGuid
    profileUpdateStatus:(YAProfileUpdateStatus)theProfileUpdateStatus
      imageUpdateStatus:(YAImageUpdateStatus)theImageUpdateStatus
            lastUpdated:(NSDate *)theLastUpdatedDate
{    
    self = [super init];
    if (self) {
        firstName_ = aFirstName;
        lastName_ = aLastName;
        photoUrl_ = aPhotoUrl;
        guid_ = aGuid;
        profileUpdateStatus_ = theProfileUpdateStatus;
        imageUpdateStatus_ = theImageUpdateStatus;
        lastUpdated_ = theLastUpdatedDate;
    }
    
    return self;
}

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark <Protocol Name> delegate methods

// Public methods
#pragma mark -
#pragma mark Public methods

// Protected methods
#pragma mark -
#pragma mark Protected methods

// Private methods MUST be declared inside a class extension
#pragma mark -
#pragma mark Private methods
#pragma mark -
#pragma mark YAUserInfo ()

@end
