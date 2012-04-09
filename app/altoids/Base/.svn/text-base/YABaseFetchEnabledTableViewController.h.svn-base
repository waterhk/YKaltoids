//
//  YABaseFetchEnabledTableViewController.h
//  altoids
//
//  Created by Srinivas Raovasudeva on 9/13/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerAccessor.h"
#import "FetchedResultsControllerFactory.h"
#import "ManagedObjectContextFactory.h"
#import "YABaseViewController.h"

// #define
#pragma mark #defines

// typedefs
#pragma mark -
#pragma mark Type definitions

typedef enum 
{
    UpdateAll = 0,
    IgnoreUpdates
}YAFetchUpdateMode;

// enums
#pragma mark -
#pragma mark Enumerations

#pragma mark -
@interface YABaseFetchEnabledTableViewController : YABaseViewController<UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    @protected
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *context;
    UITableView *tableView;
    YAFetchUpdateMode updateMode;
    NSIndexPath *maxInsertedRowIndexPath;
}

#pragma mark @property declarations
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readonly) NSManagedObjectContext *context;
@property (strong, nonatomic, readonly) UITableView *tableView;

@property (assign, nonatomic, readwrite) YAFetchUpdateMode updateMode;
@property (strong, nonatomic) NSIndexPath *maxInsertedRowIndexPath;
@property (strong, nonatomic, readonly)  id<FetchedResultsControllerFactory> fetchedResultsControllerFactory;

#pragma mark  Class methods

#pragma mark Instance methods
- (id)initWithFetchedResultsControllerFactory:(id<FetchedResultsControllerFactory>)aFetchedResultsControllerFactory 
                  managedObjectContextFactory:(id<ManagedObjectContextFactory>)theManagedObjectContextFactory 
                                      nibName:(NSString *)nibNameOrNil 
                                       bundle:(NSBundle *)nibBundleOrNil;

// Subclasses must override
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void)managedObjectContextDidSave:(NSNotification*)aNotification;

@end
