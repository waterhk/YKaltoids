//
//  YATransportFactory.h
//  altoids
//
//  Created by Robby Cahyadi Hendro Saputro on 8/18/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transport.h"
#import "TransportFactory.h"

@interface YATransportFactory : NSObject <TransportFactory>

@property (strong, nonatomic) id<Transport> inMemoryTransport;
@property (strong, nonatomic) id<Transport> serverTransport;

@end
