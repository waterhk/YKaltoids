//
//  YAMessage.m
//  altoids
//
//  Created by Jon Herron on 10/18/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import "YAMessage.h"
#import "YAConversation.h"
#import "YAParticipant.h"

@interface YAMessage () 

@property (nonatomic, retain) NSNumber *cachedHeight;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) CGFloat width;

@end

@implementation YAMessage

@dynamic body;
@dynamic messageID;
@dynamic read;
@dynamic snippet;
@dynamic timestamp;
@dynamic status;
@dynamic conversation;
@dynamic mostRecentForConversation;
@dynamic sender;

@synthesize cachedHeight = cachedHeight_;
@synthesize font = font_;
@synthesize width = width_;

- (void)awakeFromInsert
{
    [self setTimestamp:[NSDate date]];
}

#pragma mark -
#pragma mark Helper method

/* TODO: Move this to a helper class */
- (CGFloat)heightWithFont:(UIFont *)aFont width:(CGFloat)aWidth
{
    if (cachedHeight_ &&
        width_ == aWidth &&
        [font_ isEqual:aFont]) {
        return [cachedHeight_ floatValue];
    }
    
    if (!aFont) {
        aFont = [UIFont systemFontOfSize:kDefaultFontSize];
    }
    
    if (aWidth <= 0) {
        aWidth = kDefaultWidth;
    }
    
    CGSize messageCellSize = [[self body] sizeWithFont:aFont constrainedToSize:CGSizeMake(aWidth, kMaxHeight) lineBreakMode:UILineBreakModeWordWrap];
    
    [self setCachedHeight:[NSNumber numberWithFloat:messageCellSize.height]];
    [self setFont:aFont];
    [self setWidth:aWidth];
    
    return [cachedHeight_ floatValue];
}

@end
