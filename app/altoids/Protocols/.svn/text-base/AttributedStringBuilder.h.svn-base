//
//  AttributedStringBuilder.h
//  altoids
//
//  Created by Venkatraman Sridharan on 2/16/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@protocol AttributedStringBuilder <NSObject>

- (NSMutableAttributedString *)addAttributesForAttributedString:(NSMutableAttributedString *)attributedString 
                                                  attributeName:(NSString *)attributeName 
                                                          value:(CTFontRef)value 
                                                          range:(NSRange)range;

- (NSMutableAttributedString *)addAlignment:(CTTextAlignment)aAlignment toAttributedString:(NSMutableAttributedString *)aAttributedString;

@end
