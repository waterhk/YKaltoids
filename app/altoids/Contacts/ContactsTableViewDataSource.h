//
//  ContactsTableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataSource.h"
#import "Delegater.h"
@class YAContact;

@protocol ContactsTableViewDataSource <TableViewDataSource, Delegater>

- (YAContact*) contactAtIndexPath:(NSIndexPath*)indexPath;

@end
