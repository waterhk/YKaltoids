//
//  ContactStore.h
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


// intended for use only by ContactRepository (see docs/design/ContactRepository.md)

@protocol ContactStore <NSObject>

@property (nonatomic, strong) NSArray* contacts;
@property (nonatomic, strong) NSDictionary* contactsByRecordID; // [YAContactRecordID* => YAContact*]
@property (nonatomic, assign) BOOL stale;
@property (nonatomic, readonly) BOOL empty;

@end
