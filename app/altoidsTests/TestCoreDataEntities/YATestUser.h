//
//  YATestUser.h
//  altoids
//
//  Created by Derrick Whittle on 4/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YAUser.h"

@interface YATestUser : YAUser

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;

@end
