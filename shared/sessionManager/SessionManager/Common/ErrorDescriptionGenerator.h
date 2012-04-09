//
//  ErrorDescriptionGeneratorProtocol.h
//  SessionManager4
//
//  Created by Lei Cai on 8/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ErrorDescriptionGenerator <NSObject>

- (NSString*)descriptionFromErrorCode:(NSInteger)aErrorCode;

@end
