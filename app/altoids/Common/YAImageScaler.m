//
//  YAImageScaler.m
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAImageScaler.h"

// Private class extension
@interface YAImageScaler ()

// @property definitions

// methods

@end

@implementation YAImageScaler

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
#pragma mark ImageScaler delegate methods

- (UIImage *)scaleImage:(UIImage *)theImage toSize:(CGSize)theSize
{
    UIGraphicsBeginImageContext(theSize);
    
    [theImage drawInRect:CGRectMake(0, 0, theSize.width, theSize.height)];
    theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)scaleImage:(UIImage *)theImage toFitWithinSquareBackgroundImage:(UIImage *)theBackgroundImage
{
    if (!theImage || !theBackgroundImage) 
    {
        return nil;
    }
    
    CGSize backgroundImageSize = [theBackgroundImage size];
    CGSize imageSize = [theImage size];
    
    if (backgroundImageSize.height != backgroundImageSize.width) 
    {
        return nil;
    }
    
    if (backgroundImageSize.height == imageSize.height && backgroundImageSize.width == imageSize.width) 
    {
        return theImage;
    }
    
    CGFloat longSide = MAX(imageSize.height, imageSize.width);
    
    if (longSide == 0) 
    {
        return nil;
    }
    
    CGFloat percentageOfImageWhichWillFitWithinBackgroundImage = backgroundImageSize.width / longSide;
    
    CGSize reducedImageSize;
    reducedImageSize.height = floorf(imageSize.height * percentageOfImageWhichWillFitWithinBackgroundImage);
    reducedImageSize.width = floorf(imageSize.width * percentageOfImageWhichWillFitWithinBackgroundImage);
    
    CGFloat imageHeightDifference = backgroundImageSize.height - reducedImageSize.height;
    CGFloat imageWidthDifference = backgroundImageSize.width - reducedImageSize.width;
    
    CGPoint reducedImagePoint;
    reducedImagePoint.x = floorf(imageWidthDifference / 2);
    reducedImagePoint.y = floorf(imageHeightDifference / 2);
    
    UIGraphicsBeginImageContextWithOptions(backgroundImageSize, YES, 0.0);
    
    [theBackgroundImage drawInRect:CGRectMake(0, 0, backgroundImageSize.width, backgroundImageSize.height)];
    
    [theImage drawInRect:CGRectMake(reducedImagePoint.x, 
                                    reducedImagePoint.y, 
                                    reducedImageSize.width, 
                                    reducedImageSize.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
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
#pragma mark YAImageScaler ()

@end
