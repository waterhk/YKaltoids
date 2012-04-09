//
//  ConnectionWrapper.h
//  SessionManager3
//
//  Created by Lei Cai on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionWrapper.h"

@interface YSMConnectionWrapper : NSObject <ConnectionWrapper, NSURLConnectionDelegate> {
    NSURLConnection *connection_;
    NSMutableData *data_;
    NSURLResponse *response_;
}

@property (nonatomic, assign) id<ConnectionWrapperDelegate> delegate;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, strong) NSURLResponse *response;

@end
