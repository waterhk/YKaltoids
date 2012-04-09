//
//  YAAddressBookLoader.h
//  altoids
//
//  Created by Derrick Whittle on 2/13/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressBookLoader.h"
@protocol MutableArrayCreator, TimerInstanceFactory, PhoneNumberNormalizer;

@interface YAAddressBookLoader : NSObject <AddressBookLoader>

@property (nonatomic, strong) id<MutableArrayCreator> mutableArrayCreator;
@property (nonatomic, strong) NSArray* sortDescriptors;     // [NSSortDescriptor*]
@property (nonatomic, strong) id<TimerInstanceFactory> timerInstanceFactory;

@end
