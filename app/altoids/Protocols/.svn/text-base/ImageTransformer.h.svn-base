//
//  ImageTransformer.h
//  altoids
//
//  Created by Anand Subba Rao on 11/11/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageTransformer <NSObject>

#pragma mark -
#pragma mark @required
@required

- (UIImage *)imageWithData:(NSData *)imageData;
- (NSData *)dataWithImage:(UIImage *)image;
- (NSData *)JPEGDataFromPNGData:(NSData *)pngData;
/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
