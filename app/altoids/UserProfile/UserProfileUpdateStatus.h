//
//  UserProfileUpdateStatus.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

typedef enum {
    YAProfileUpdateStatusPrivate,
    YAProfileUpdateStatusPublic,
    YAProfileUpdateStatusError,
    YAProfileUpdateStatusUnknown
}YAProfileUpdateStatus;

typedef enum {
    YAImageUpdateStatusSuccess,
    YAImageUpdateStatusError,
    YAImageUpdateStatusUnknown
}YAImageUpdateStatus;