//
//  YAContactRecordID.h
//  altoids
//
//  Created by Derrick Whittle on 3/30/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBook/ABRecord.h"


// YAContactRecordID makes it simpler to manage ABRecordIDs in collections
// Because ABRecordID is simply a typedef for a 32-bit int, it can't directly go into an NSArray, etc.

@interface YAContactRecordID : NSObject

- (id) initWithABRecordID:(ABRecordID)abRecordID;
- (ABRecordID) abRecordIDValue;

@end
