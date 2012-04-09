//
//  YATimestampFormatter.m
//  altoids
//
//  Created by Devin Doman on 3/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATimestampFormatter.h"
#import "DateCreator.h"

@implementation YATimestampFormatter

@synthesize dateFormatter = dateFormatter_;
@synthesize dateCreator = dateCreator_;

#pragma mark -
#pragma mark TimestampFormatter protocol methods

- (NSString *)formatTimestampToString: (NSDate *)date
{
    if (date == nil)
    {
        return nil;
    }
    
    NSString* timeString = @"";
    
    NSDate* currentDate = [dateCreator_ dateForNow];
    NSInteger seconds = [currentDate timeIntervalSinceDate:date];
    
    if (seconds <= 0)
    {
        return nil;
    }
    
    NSInteger hours = seconds / (60 * 60);
    
    if ((hours < 5))
    {
        //Relative time format
        timeString = [dateFormatter_ formatRelativeDateToString:date];
    }
    else 
    {
        //Absolute time format
        timeString = [dateFormatter_ formatAbsoluteDateToString:date];
    }
    
	return timeString;
}

@end