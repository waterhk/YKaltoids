//
//  YAParticipantImageTransformer.m
//  altoids
//
//  Created by Anand Subba Rao on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAImageTransformer.h"

// Private class extension
@interface YAImageTransformer ()

// @property definitions

// methods

@end

@implementation YAImageTransformer

// Class methods
#pragma mark -
#pragma mark Class methods

// @synthesize definitions
#pragma mark -
#pragma mark @synthesize

// Designated initializer
#pragma mark -
#pragma mark Designated initializer

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
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
#pragma mark ImageTransformer methods
- (UIImage *)defaultImage
{
    //TODO: need to get the image from the resource provider
    return [UIImage imageNamed:kIconDefaultParticipantImage];
}

- (UIImage *)imageWithData:(NSData *)data
{
    if (data) {
        return [UIImage imageWithData:data];
    }
    
    return nil;
}

- (NSData *)dataWithImage:(UIImage *)image
{
    if (image) {
        return UIImagePNGRepresentation(image);
    }
    
    return nil;
}

- (NSData*)JPEGDataFromPNGData:(NSData *)pngData
{
    if (pngData) {
        UIImage *image = [self imageWithData:pngData];
        NSData *jpgData = UIImageJPEGRepresentation(image, 1);
        
        return  jpgData;
    }
    
    return nil;
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
#pragma mark YAImageTransformer ()

@end
