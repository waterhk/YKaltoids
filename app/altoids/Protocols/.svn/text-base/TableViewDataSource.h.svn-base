//
//  TableViewDataSource.h
//  altoids
//
//  Created by Derrick Whittle on 2/14/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>


// defines lifecycle for table view data sources (since it's otherwise decoupled from VC's lifecycle)

@protocol TableViewDataSource <NSObject, UITableViewDataSource>

// load typically called by a UITableViewController's viewDidLoad
- (void) load;

// unload typically called by a UITableViewController's viewDidUnload
- (void) unload;

// didReceiveMemoryWarning typically called by a UITableViewController's didReceiveMemoryWarning
- (void) didReceiveMemoryWarning;

@end
