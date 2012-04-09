//
//  ConnectionWrapperProtocol.h
//  SessionManager3
//
//  Created by Lei Cai on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionWrapper <NSObject>
- (void)executeWithRequest:(NSURLRequest*)aRequest;
- (void)disposeCurrentRequest;
@end

@protocol ConnectionWrapperDelegate <NSObject>

- (void)connectionWrapper:(id<ConnectionWrapper>)aConnectionWrapper didSucceedWithData:(NSData*)aData andURLResponse:(NSURLResponse*)aResponse;
- (void)connectionWrapper:(id<ConnectionWrapper>)aConnectionWrapper didFailWithData:(NSError*)aError andURLResponse:(NSURLResponse*)aResponse;

@end
