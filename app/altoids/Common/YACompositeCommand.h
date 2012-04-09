//
//  YACompositeCommand.h
//  altoids
//
//  Created by Jon Herron on 1/26/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "Command.h"


@interface YACompositeCommand : NSObject <Command>

// YACompositeCommand executes the given commands sequentially, short-circuiting if any returns an error.
- (id)initWithCommands:(NSArray *)theCommands;

@end
