//
//  ImageScaler.h
//  altoids
//
//  Created by Jon Herron on 11/7/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageScaler <NSObject>

#pragma mark -
#pragma mark @required
@required

- (UIImage *)scaleImage:(UIImage *)theImage toSize:(CGSize)theSize;
- (UIImage *)scaleImage:(UIImage *)theImage toFitWithinSquareBackgroundImage:(UIImage *)theBackgroundImage;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
