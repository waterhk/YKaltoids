//
//  YAFormattedUILabel.m
//  altoids
//
//  Created by Venkatraman Sridharan on 2/16/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAFormattedUILabel.h"
#import "CoreText/CoreText.h"
#import <QuartzCore/QuartzCore.h>


@implementation YAFormattedUILabel
@synthesize attributedString = attributedString_;

- (void) setAttributedString:(NSMutableAttributedString *)attributedString 
{   
    attributedString_ = attributedString;  
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect
{
    if (!attributedString_) 
    {  
        [super drawTextInRect:rect];
        return;
    }    
    
    [attributedString_ addAttribute:(id)kCTForegroundColorAttributeName
                   value:(__bridge id)[self textColor].CGColor
                   range:NSMakeRange(0, [attributedString_ length])];
    
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString_);
    
	CGMutablePathRef leftColumnPath = CGPathCreateMutable();
	CGPathAddRect(leftColumnPath, NULL, 
                  CGRectMake(0, 0, 
                             self.bounds.size.width,
                             self.bounds.size.height));
    
	CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter, 
                                                    CFRangeMake(0, 0),
                                                    leftColumnPath, NULL);
     
	// flip the coordinate system
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetTextMatrix(context, CGAffineTransformIdentity);
	CGContextTranslateCTM(context, 0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
	// draw
	CTFrameDraw(leftFrame, context);
    
	// cleanup
	CFRelease(leftFrame);
	CGPathRelease(leftColumnPath);
	CFRelease(framesetter);
            
}


- (CTFontRef) originalFont 
{
    CTFontRef originalFontRef = CTFontCreateWithName((__bridge CFStringRef)self.font.fontName, self.font.pointSize , NULL);
    return originalFontRef;
}


- (CTFontRef) originalFontWithBold 
{
    NSString *boldString = [self.font.fontName stringByAppendingString:@"-Bold"];
    CTFontRef originalFontWithBoldRef = CTFontCreateWithName((__bridge CFStringRef)boldString, self.font.pointSize , NULL);
    return originalFontWithBoldRef;
}



@end
