//
//  Command.h
//  altoids
//
//  Created by Anand Subba Rao on 8/23/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//
//  http://twiki.corp.yahoo.com/view/Devel/AltoidsiOSClientGenericCommand
//

#import <Foundation/Foundation.h>

@protocol Command <NSObject>

- (NSError*) execute;

@end
