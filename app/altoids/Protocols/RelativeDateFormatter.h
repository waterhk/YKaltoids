//
//  RelativeDateFormatter.h
//  altoids
//
//  Created by Venkatraman Sridharan on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RelativeDateFormatter <NSObject>

-(NSString *) formatRelativeDateToString:(NSDate *)date;

@end