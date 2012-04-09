//
//  TransportFactory.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transport.h"

@protocol TransportFactory <NSObject>
@required

- (id<Transport>)inMemoryTransport;
- (id<Transport>)serverTransport;

@end
