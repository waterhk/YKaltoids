//
//  YATableViewCellInstanceFactory.m
//  altoids
//
//  Created by Jon Herron on 2/3/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YATableViewCellCreator.h"

@implementation YATableViewCellCreator

- (UITableViewCell *)createForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
}

@end
