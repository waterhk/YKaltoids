//
//  YACommandQueue.h
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandQueue.h"
@protocol OperationCreator;


@interface YACommandQueue : NSObject <CommandQueue>

@property (nonatomic, strong) NSOperationQueue* operationQueue;
@property (nonatomic, strong) id<OperationCreator> operationCreator;

- (id) initWithOperationQueue:(NSOperationQueue*)operationQueue maxConcurrentOperationCount:(NSInteger)count;

@end
