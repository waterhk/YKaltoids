//
//  OperationCreator.h
//  altoids
//
//  Created by Derrick Whittle on 2/10/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Command;


@protocol OperationCreator <NSObject>

- (NSOperation*) createOperationWithCommand:(id<Command>)command;

@end
