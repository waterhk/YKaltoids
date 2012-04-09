//
//  YAUserProfileImageUpdateRequestBodyWriter.m
//  altoids
//
//  Created by Anand Biligiri on 12/17/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageUpdateRequestBodyWriter.h"

#undef kYALogComponent
#define kYALogComponent lcl_cProfileCommand

// Private class extension
@interface YAUserProfileImageUpdateRequestBodyWriter ()

// @property definitions

// methods

@end

@implementation YAUserProfileImageUpdateRequestBodyWriter

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize
@synthesize jsonWriter = jsonWriter_;

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
#pragma mark JSONWriter methods
- (NSData *)dataFromDictionary:(NSDictionary *)theDictionary
{
    NSMutableData *requestData = [NSMutableData data];
    NSString *boundary = @"e02449e6f1f9";
    [requestData appendData:[[NSString stringWithFormat:@"--%@\r\n"
                              "Content-Disposition: form-data; name=\"image_post_body\"\r\n\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [requestData appendData:[[self jsonWriter] dataFromDictionary:[theDictionary objectForKey:@"image_post_body"]]];
    [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n"
                              "Content-Disposition: form-data; name=\"image_file\"; filename=\"image.jpg\"\r\n"
                              "Content-Type: image/png\r\n\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imageData = [theDictionary objectForKey:@"image_data"];
    
    [requestData appendData:imageData];
    [requestData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
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
#pragma mark YAUserProfileImageUpdateRequestBodyWriter ()

@end
