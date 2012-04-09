//
//  YATextFieldFormatter.m
//  altoids
//
//  Created by Devin Doman on 3/6/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATextFieldFormatter.h"

@implementation YATextFieldFormatter

- (void)boldUserInputInTextField:(UITextField *)theTextField evenWhenTextLengthIsGreaterThanOne:(BOOL)setWhenTextLengthIsGreaterThanOne;
{
    CGFloat textFieldCurrentFontSize = [[theTextField font] pointSize];
    NSUInteger textFieldTextLength = [[theTextField text] length];
    
    if (textFieldTextLength == 0) 
    {
        [theTextField setFont:[UIFont systemFontOfSize:textFieldCurrentFontSize]];
    }
    else if(textFieldTextLength == 1 || setWhenTextLengthIsGreaterThanOne)
    {
        [theTextField setFont:[UIFont boldSystemFontOfSize:textFieldCurrentFontSize]];
    }
}
@end