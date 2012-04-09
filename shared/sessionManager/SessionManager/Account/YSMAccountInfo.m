 //
//  AccountInfo.m
//  SessionManager2
//
//  Created by Lei Cai on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YSMAccountInfo.h"

@implementation YSMAccountInfo

@synthesize userID = userID_;
@synthesize yCookie = yCookie_;
@synthesize tCookie = tCookie_;
@synthesize crumb = crumb_;
@synthesize expirationDate = expirationDate_;
@synthesize token = token_;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self) {
        self.userID = [coder decodeObjectForKey:@"userID"];
        self.yCookie = [coder decodeObjectForKey:@"yCookie"];
        self.tCookie = [coder decodeObjectForKey:@"tCookie"];
        self.crumb = [coder decodeObjectForKey:@"crumb"];
        self.expirationDate = [coder decodeObjectForKey:@"expirationDate"];
        self.token = [coder decodeObjectForKey:@"token"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.userID forKey:@"userID"];
    [coder encodeObject:self.yCookie forKey:@"yCookie"];
    [coder encodeObject:self.tCookie forKey:@"tCookie"];
    [coder encodeObject:self.crumb forKey:@"crumb"];
    [coder encodeObject:self.expirationDate forKey:@"expirationDate"];
    [coder encodeObject:self.token forKey:@"token"];
}

- (BOOL)hasExpired {
    if (self.expirationDate) {
        return [[NSDate date] timeIntervalSince1970] > [self.expirationDate timeIntervalSince1970];
    }
    return YES;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n%s:%@\n%s:%@\n%s:%@\n%s:%@\n%s:%@\n%s:%@\n",
            "userid",[self userID],
            "yCookie",[self yCookie], // print an md5 hash instead
            "tCookie",[self tCookie], // print an md5 hash instead
            "crumb",[self crumb],
            "expirationDate",[self expirationDate],
            "token",[self token]];
}
@end
