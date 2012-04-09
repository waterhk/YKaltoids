//
//  TableViewCellCreator.h
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewCellCreator <NSObject>

- (UITableViewCell *)createForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
