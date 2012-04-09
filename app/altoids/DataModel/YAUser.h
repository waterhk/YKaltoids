//
//  YAUser.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 12/14/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "YAPerson.h"


@interface YAUser : YAPerson

@property (nonatomic, retain) NSString * guid;
@property (nonatomic, retain) NSNumber * profileUpdateStatus;
@property (nonatomic, retain) NSNumber * imageUpdateStatus;
@property (nonatomic, retain) NSDate * lastUpdated;

@end
