//
//  YAContactsListViewController.m
//  altoids
//
//  Created by Srinivas Raovasudeva on 8/30/11.
//  Copyright 2011 Yahoo!. All rights reserved.
//

#import "YAContactsListViewController.h"
#import "AppFactory.h"
#import "ContactsTableViewDataSource.h"
#import "ContactDetailViewController.h"
#import "NavigationBarButtonItemRepository.h"

#undef kYALogComponent
#define kYALogComponent lcl_cContactUI


@interface YAContactsListViewController ()

- (void)newContact:(id)sender;

@end


@implementation YAContactsListViewController

@synthesize dataSource = dataSource_,
            contactDetailViewControllerInstanceFactory = contactDetailViewControllerInstanceFactory_,
            contactsTableViewDataSourceInstanceFactory = contactsTableViewDataSourceInstanceFactory_,
            navigationBarButtonItemRepository = navigationBarButtonItemRepository_;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self setTitle:kContactsListTitle];
        [[self tabBarItem] setImage:[UIImage imageNamed:kContactsListTabBarImage]];
    }
    return self;
}

- (void) dealloc
{
    [dataSource_ clearDelegate:self];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [dataSource_ didReceiveMemoryWarning];
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [[[self navigationController] navigationBar] setTintColor:kNavigationBarTintColor];
    [[self navigationItem] setBackBarButtonItem:[[self navigationBarButtonItemRepository] backButtonItemItemWithTitle:kBackButtonText target:nil action:nil]];
    
    //TODO: hide the add contact button for Alpha, will implement it in the future.
    //[[self navigationItem] setRightBarButtonItem:[[self navigationBarButtonItemRepository] addContactButtonItemWithTarget:self action:@selector(newContact:)]];

    // We load the data source in viewDidLoad and never unload it because the data source is relatively expensive to load,
    // and this VC has app lifetime anyway.
    // didReceiveMemoryWarning keeps the data source from using too much memory when the contacts tab is not in active use.
    if(!dataSource_)
    {
        dataSource_ = [contactsTableViewDataSourceInstanceFactory_ createContactsTableViewDataSourceWithDelegate:self];
    }
    [[self tableView] setDataSource:[self dataSource]];
    [dataSource_ load];
}

- (void) newContact:(id)sender
{
    // TODO in a future sprint
}


#pragma mark ContactsTableViewDataSourceDelegate methods

- (void) contactsTableViewDataSourceDidLoadContacts:(id<ContactsTableViewDataSource>)dataSource
{
    [[self tableView] reloadData];
}


#pragma mark UITableViewDelegate methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YAContact* contact = [dataSource_ contactAtIndexPath:indexPath];
    if(!contact)
    {
        return;
    }
    
    id<ContactDetailViewController> contactDetailViewController = [contactDetailViewControllerInstanceFactory_ createContactDetailViewControllerWithContact:contact];
    [[self navigationController] pushViewController:[contactDetailViewController viewController] animated:YES];
}


@end
