//
//  YAContactRecordID.m
//  altoids
//
//  Created by Derrick Whittle on 3/30/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAContactRecordID.h"

@interface YAContactRecordID()
@property (nonatomic, strong, readonly) NSNumber* recordID;
@end

@implementation YAContactRecordID
@synthesize recordID = recordID_;

- (id) initWithABRecordID:(ABRecordID)abRecordID
{
    self = [super init];
    if(self)
    {
        recordID_ = [NSNumber numberWithShort:abRecordID];
    }
    return self;
}

- (int32_t) abRecordIDValue
{
    return [recordID_ shortValue];
}

- (BOOL) isEqual:(NSObject*)other
{
    if(self == other)
    {
        return YES;
    }

    if(![other isKindOfClass:[YAContactRecordID class]])
    {
        return NO;
    }

    return [recordID_ isEqual:[(YAContactRecordID*)other recordID]];
}

- (NSUInteger) hash
{
    return [recordID_ hash];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;    // safe beacuse YAContactRecordID is immutable
}

@end
