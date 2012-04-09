//
//  CommandQueue.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Command;

@protocol CommandQueue <NSObject>
@required

- (void)append:(id<Command>)command;
- (NSUInteger)count;

@end
