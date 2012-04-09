//
//  YAPerson.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/14/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YAPersonImage;

@interface YAPerson : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) YAPersonImage *image;

@end
