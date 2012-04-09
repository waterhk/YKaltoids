//
//  ContactDetailTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 2/15/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataSource.h"
#import "Delegater.h"
@class YAContact, YAContactEndpoint, YAContactAddress, YAParticipantInfo;

@protocol ContactDetailTableViewDataSource <TableViewDataSource, Delegater>

- (YAContactEndpoint*) contactEndpointForIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, readonly) YAContact* contact;
@property (nonatomic, strong) YAContactAddress* selectedAddress;

@end
