//
//  YAAddressMetaData.h
//  altoids
//
//  Created by Venkatraman Sridharan on 1/23/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface YAAddressMetaData : NSManagedObject

@property (nonatomic, retain) NSString * handle;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * isHub;
@property (nonatomic, retain) NSNumber * isValidSMS;

@end
