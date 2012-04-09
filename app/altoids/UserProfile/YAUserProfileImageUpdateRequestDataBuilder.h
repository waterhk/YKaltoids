//
//  YAUserProfileImageUpdateRequestDataBuilder.h
//  altoids
//
//  Created by Anand Subba Rao on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageScaler.h"
#import "ImageTransformer.h"
#import "MutableDictionaryCreator.h"
#import "UserProfileHandler.h"
#import "UserProfileImageUpdateRequestDataBuilder.h"
// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YAUserProfileImageUpdateRequestDataBuilder : NSObject<UserProfileImageUpdateRequestDataBuilder>

#pragma mark @property declarations
@property (strong, nonatomic) id<MutableDictionaryCreator> mutableDictionaryCreator;
@property (strong, nonatomic) id<ImageScaler> imageScaler;
@property (strong, nonatomic) id<ImageTransformer> imageTransformer;

#pragma mark  Class methods

#pragma mark Instance methods

@end
