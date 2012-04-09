//
//  YADateFormatter.m
//  altoids
//
//  Created by Venkatraman Sridharan on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADateFormatter.h"
#import "DateCreator.h"

@implementation YADateFormatter

@synthesize dateCreator = dateCreator_;
@synthesize shortStyleDateFormatter = shortStyleDateFormatter_;
@synthesize shortTimeFormatter = shortTimeFormatter_;
@synthesize shortDateFormatter = shortDateFormatter_;
@synthesize dayHourFormatter = dayHourFormatter_;
@synthesize monthDayFormatter = monthDayFormatter_;

- (void) setShortStyleDateFormatter:(NSDateFormatter*)theFormatter
{
    shortStyleDateFormatter_ = theFormatter;
    [shortStyleDateFormatter_ setDateStyle:NSDateFormatterShortStyle];
    [shortStyleDateFormatter_ setTimeStyle:NSDateFormatterShortStyle];
}

- (void) setShortTimeFormatter:(NSDateFormatter*)theFormatter
{
    shortTimeFormatter_ = theFormatter;
    [shortTimeFormatter_ setTimeStyle:NSDateFormatterShortStyle];
    [shortTimeFormatter_ setDateStyle:NSDateFormatterNoStyle];
}

- (void) setShortDateFormatter:(NSDateFormatter*)theFormatter
{
    shortDateFormatter_ = theFormatter;
    [shortDateFormatter_ setTimeStyle:NSDateFormatterNoStyle];
    [shortDateFormatter_ setDateStyle:NSDateFormatterShortStyle];
}

- (void) setDayHourFormatter:(NSDateFormatter*)theFormatter
{
    dayHourFormatter_ = theFormatter;
    [dayHourFormatter_ setDateFormat:@"EEE h a"];
}

- (void) setMonthDayFormatter:(NSDateFormatter*)theFormatter
{
    monthDayFormatter_ = theFormatter;
    [monthDayFormatter_ setDateFormat:@"MMM d"];
}

-(NSString *) formatRelativeDateToString:(NSDate *)date
{
    if (date == nil)
    {
        return nil;
    }
    
    NSTimeInterval seconds = [[dateCreator_ dateForNow] timeIntervalSinceDate:date];
    if (seconds <= 0)
    {
        return nil;
    }
    
    NSString* format = @"%i %@";
    NSString* local = @"";
    NSInteger time = 0;
    NSInteger minutes = (seconds / 60);
    NSInteger hours = seconds / (60 * 60);
    NSInteger years = seconds / (60 * 60 * 24 * 365);
    
    
    if (years < 1)
    {
        if (hours < 1)
        {
            switch (minutes) 
            {
                case 0:
                    local = kNowTimeQuantity;
                    return [NSString stringWithFormat:@"%@", local];
                    break;
                case 1:
                    local = kOneMinuteTimeQuantity;
                    break;
                case 2:
                    local = kTwoMinuteTimeQuantity;
                    break;
                default:
                    local = kFewMinutesTimeQuantity;
                    break;
            }
            time = minutes;
        }
        else 
        {
            switch (hours) 
            {
                case 0:
                    hours = 1;
                case 1:
                    local = kOneHourTimeQuantity;
                    break;
                case 2:
                    local = kTwoHourTimeQuantity;
                    break;
                default:
                    local = kFewHoursTimeQuantity;
                    break;
            }
            time = hours;
        }
    }
    else 
    {
        local = kOneYearTimeQuantity;
        time = 1;
        if (years >= 2) 
        {
            format = @"+%i %@";
        }
    }
    
    return [NSString stringWithFormat:format, time, local];
}

- (NSString *)formatAbsoluteDateToString:(NSDate *)date
{
    if (date == nil)
    {
        return nil;
    }
    
    NSTimeInterval seconds = [[dateCreator_ dateForNow] timeIntervalSinceDate:date];
    if (seconds <= 0)
    {
        return nil;
    }
    
    NSDateFormatter* formatter;
    NSInteger days = seconds / (60 * 60 * 24);
    NSInteger years = seconds / (60 * 60 * 24 * 365);
    
    if (years < 1)
    {
        if (days < 1)
        {
            //hour:min am/pm
            formatter = shortTimeFormatter_;
        }
        else if (days < 7)
        {
            //Day hour am/pm
            formatter = dayHourFormatter_;
        }
        else 
        {
            //Month day
            formatter = monthDayFormatter_;
        }
    }
    else 
    {
        //mm/dd/yy
        formatter = shortDateFormatter_;
    }
    
    return [formatter stringFromDate:date];
}

- (NSString *)shortStyleStringFromDate:(NSDate *)aDate 
{
    if (!aDate) 
    {
        return nil;
    }
    
    return [[self shortStyleDateFormatter] stringFromDate:aDate];
}

@end