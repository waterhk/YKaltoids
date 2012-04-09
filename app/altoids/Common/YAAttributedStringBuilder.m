//
//  YAAttributedStringBuilder.m
//  altoids
//
//  Created by Venkatraman Sridharan on 2/16/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAAttributedStringBuilder.h"

@implementation YAAttributedStringBuilder


- (NSMutableAttributedString *)addAttributesForAttributedString:(NSMutableAttributedString *)attributedString 
                                                  attributeName:(NSString *)attributeName 
                                                          value:(CTFontRef)value 
                                                          range:(NSRange)range 
{    
	[attributedString addAttribute:(id) attributeName value:(__bridge id)value range:range];
    return attributedString;
}

- (NSMutableAttributedString *)addAlignment:(CTTextAlignment)aAlignment toAttributedString:(NSMutableAttributedString *)aAttributedString
{
    if (!aAttributedString) {
        return nil;
    }
    
    CTParagraphStyleSetting settings[] = {kCTParagraphStyleSpecifierAlignment, sizeof(aAlignment), &aAlignment};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFMutableAttributedStringRef attrString = (__bridge CFMutableAttributedStringRef)aAttributedString;
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    return (__bridge NSMutableAttributedString *)attrString;
}

@end
