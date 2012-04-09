//
//  YAUserProfileImageUpdateRequestDataBuilder.m
//  altoids
//
//  Created by Anand Subba Rao on 12/16/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateRequestDataBuilder.h"
#import "YAUser.h"
// Private class extension
@interface YAUserProfileImageUpdateRequestDataBuilder ()

// @property definitions

// methods

@end

@implementation YAUserProfileImageUpdateRequestDataBuilder

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize mutableDictionaryCreator = mutableDictionaryCreator_;
@synthesize imageScaler = imageScaler_;
@synthesize imageTransformer = imageTransformer_;

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

// @dynamic definitions
#pragma mark -
#pragma mark @dynamic

// Overrides
#pragma mark -
#pragma mark Overrides

// Delegate methods
#pragma mark -
#pragma mark UserProfileImageUpdateRequestDataBuilder methods
- (NSDictionary *)requestDataForProfileImageUpdateWithImageData:(NSData *)imageData
{
    NSMutableDictionary *requestData = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:2];
    
    UIImage *imageToUpload = [[self imageTransformer] imageWithData:imageData];
    CGSize imageToUploadSize = [imageToUpload size];
    
    NSMutableDictionary *imageUpload = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:4];
    [imageUpload setValue:[NSNumber numberWithInt:0] forKey:@"cropx"];
    [imageUpload setValue:[NSNumber numberWithInt:0] forKey:@"cropy"];
    [imageUpload setValue:[NSNumber numberWithInt:imageToUploadSize.height] forKey:@"croph"];
    [imageUpload setValue:[NSNumber numberWithInt:imageToUploadSize.width] forKey:@"cropw"];
    
    NSMutableDictionary *imagePostBody = [[self mutableDictionaryCreator] mutableDictionaryWithCapacity:1];
    [imagePostBody setValue:imageUpload forKey:@"imageupload"];
    
    [requestData setValue:imagePostBody forKey:@"image_post_body"];
    [requestData setValue:imageData forKey:@"image_data"];
    
    return requestData;
}
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
#pragma mark YAUserProfileImageUpdateRequestDataBuilder ()

@end
