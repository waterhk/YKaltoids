//
//  YADateFormatter.h
//  altoids
//
//  Created by Venkatraman Sridharan on 2/9/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateFormatter.h"

@protocol DateCreator;

@interface YADateFormatter : NSObject <DateFormatter>

@property (nonatomic, strong) id<DateCreator> dateCreator;

@property (nonatomic, strong) NSDateFormatter* shortStyleDateFormatter;
@property (nonatomic, strong) NSDateFormatter* shortTimeFormatter;
@property (nonatomic, strong) NSDateFormatter* shortDateFormatter;
@property (nonatomic, strong) NSDateFormatter* dayHourFormatter;
@property (nonatomic, strong) NSDateFormatter* monthDayFormatter;

@end