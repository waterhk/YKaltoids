//
//  StringSizeCalculator.h
//  altoids
//
//  Created by Jon Herron on 10/20/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringSizeCalculator <NSObject>

#pragma mark -
#pragma mark @required
@required

- (CGSize)sizeOfString:(NSString *)theString withFont:(UIFont *)theFont;

/*
 Avoid @optional methods since we don't want
 partial interfaces for injectable classes
 */
@end
