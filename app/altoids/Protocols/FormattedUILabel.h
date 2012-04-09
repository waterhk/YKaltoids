//
//  FormattedUILabel.h
//  altoids
//
//  Created by Venkatraman Sridharan on 2/16/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@protocol FormattedUILabel <NSObject>

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

- (CTFontRef) originalFont;
- (CTFontRef) originalFontWithBold;

//
// exposed UILabel properties (since there's no UILabel protocol)
// (I can't seem to use @property here, as even though YAFormattedUILabel extends UILabel, the compiler complains that the properties aren't synthesized)
//
- (void) setTextColor:(UIColor*)textColor;
- (UIColor*) textColor;
- (void) setFont:(UIFont*)font;
- (UIFont*) font;

@end
