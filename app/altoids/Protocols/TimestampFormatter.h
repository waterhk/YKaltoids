//
//  TimestampFormatter.h
//  altoids
//
//  Created by Devin Doman on 3/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimestampFormatter <NSObject>

- (NSString *)formatTimestampToString: (NSDate *)date;

@end