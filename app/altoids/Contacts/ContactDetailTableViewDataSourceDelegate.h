//
//  ContactDetailTableViewDataSourceDelegate.h
//  altoids
//
//  Created by Derrick Whittle on 4/5/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ContactDetailTableViewDataSource;
@class YAContact;

@protocol ContactDetailTableViewDataSourceDelegate <NSObject>

- (void) contactDetailTableViewDataSource:(id<ContactDetailTableViewDataSource>)dataSource didLoadContact:(YAContact*)contact;

@end
