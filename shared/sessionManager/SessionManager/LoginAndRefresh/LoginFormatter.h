//
//  LoginFormatter.h
//  SessionManager
//
//  Created by Devin Doman on 3/20/12
//  Copyright 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginFormatter <NSObject>

#pragma mark -
#pragma mark @required
@required

- (NSString*)formatUserName:(NSString*) theUserName;

@end