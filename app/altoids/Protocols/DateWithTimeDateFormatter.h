//
//  DateWithTimeDateFormatter.h
//  altoids
//
//  Created by Jon Herron on 3/1/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DateWithTimeDateFormatter <NSObject>

- (NSString *)shortStyleStringFromDate:(NSDate *)aDate;

@end
