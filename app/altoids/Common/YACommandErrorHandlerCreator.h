//
//  YACommandErrorHandlerCreator.h
//  altoids
//
//  Created by Jon Herron on 11/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandErrorHandlerCreator.h"
#import "CommandErrorCreator.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YACommandErrorHandlerCreator : NSObject <CommandErrorHandlerCreator>

#pragma mark @property declarations
@property (strong, nonatomic) id<CommandErrorCreator> commandErrorCreator;

#pragma mark  Class methods

#pragma mark Instance methods

@end
