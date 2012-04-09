//
//  AccountInfo.h
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSMAccountInfo : NSObject {
 @private
    NSString *userID_;
    NSString *yCookie_;
    NSString *tCookie_;
    NSString *crumb_;
    NSDate *expirationDate_;    
    NSString *token_;
}

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *yCookie;
@property (nonatomic, copy) NSString *tCookie;
@property (nonatomic, copy) NSString *crumb;
@property (nonatomic, retain) NSDate *expirationDate;
@property (nonatomic, copy) NSString *token;

- (BOOL)hasExpired;

@end
