//
//  YAUserProfileImageScaler.m
//  altoids
//
//  Created by Jon Herron on 1/24/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAUserProfileImageScaler.h"

@implementation YAUserProfileImageScaler

@synthesize imageScaler = imageScaler_;

- (UIImage *)scaleUserProfileImage:(UIImage *)theUserProfileImage
{
    CGFloat userProfileImageHeight = [theUserProfileImage size].height;
    CGFloat userProfileImageWidth = [theUserProfileImage size].width;
    
    BOOL userProfileImageIsCorrectSize = userProfileImageHeight == kUserProfileImageHeight && userProfileImageWidth == kUserProfileImageWidth;
    
    if (userProfileImageIsCorrectSize) 
    {
        return theUserProfileImage;
    }
    
    return [[self imageScaler] scaleImage:theUserProfileImage toFitWithinSquareBackgroundImage:[UIImage imageNamed:kHeaderTrayAvatarBackgroundImage]];
}

@end
