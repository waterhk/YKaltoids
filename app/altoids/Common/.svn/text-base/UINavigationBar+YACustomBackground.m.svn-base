//
//  UINavigationBar+YACustomBackground.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 11/28/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "UINavigationBar+YACustomBackground.h"

@implementation UINavigationBar (YACustomBackground)

- (void)drawRect:(CGRect)rect {
    UIImage *img  = [UIImage imageNamed:kNavigationBarBackgroundImage];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setTintColor:nil];
}

@end
