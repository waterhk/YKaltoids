//
//  YADeactivateViewController.m
//  altoids
//
//  Created by Stephane Karoubi on 3/19/12.
//  Copyright (c) 2012 Yahoo!. All rights reserved.
//

#import "YADeactivateViewController.h"
#import "TransactionCommand.h"
#import "AppDelegate.h"
#define kInformationalTextSectionIndex 0
#define kDeactivateSectionIndex 1

@interface YADeactivateViewController ()


- (void)configureDeactivateCell:(UITableViewCell *)aCell;

enum DeactivationSelection
{
    kDeactivateAccountConfirm,
    kDeactivateAccountSuccessful,
    kDeactivateAccountFailed
};


@end

@implementation YADeactivateViewController
@synthesize cellTitles = cellTitles_;
@synthesize uiAlertViewFactory = uiAlertViewFactory_;
@synthesize uiAlertViewSelectionDetector = uiAlertViewSelectionDetector_;
@synthesize deactivationCommandCreator = deactivationCommandCreator_;
@synthesize mmcCommandQueue = mmcCommandQueue_;
@synthesize deactivationCommandTransaction = deactivationCommandTransaction_;
@synthesize appConfiguration = appConfiguration_;


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:kDeactivateTitle];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIViewController *)viewController
{
    return self;   
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == kInformationalTextSectionIndex) 
    {
        return kDeactivateInformationalText;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kInformationalTextSectionIndex) {
        return 0;
    }
    else 
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    if ([indexPath section] == kDeactivateSectionIndex && [indexPath row] == 0) {
        [self configureDeactivateCell:cell];
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == kDeactivateSectionIndex && [indexPath row] == 0)
    {
        UIAlertView *deactivateAccountConfirmation;
        deactivateAccountConfirmation = [[self uiAlertViewFactory] createWithTitle:kDeactivateDialogTitle 
                                                                                message:kDeactivateDialogMessage
                                                                               delegate:self 
                                                                      cancelButtonTitle:kCancelButtonText 
                                                                      otherButtonTitles:[NSArray arrayWithObject:kDeactivateDialogOKbuttonText]];
        deactivateAccountConfirmation.tag = kDeactivateAccountConfirm;
        [deactivateAccountConfirmation show];
    }

}

 
- (void) resetApplicationAfterDeactivation
{
    [appConfiguration_ setResetOnLaunch:YES];
     AppDelegate *appDelegate= (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate showApplication];
   
}


- (void)commandTransactionDidSucceed:(id<CommandTransaction>)commandTransaction
{
    if(deactivationCommandTransaction_ == commandTransaction)
    {
        deactivationCommandTransaction_ = nil;
        
        UIAlertView *deactivateSuccessfulConfirmation;
        deactivateSuccessfulConfirmation = [[self uiAlertViewFactory] createWithTitle:kDeactivateSuccessfulDialogTitle 
                                                                           message:kDeactivateSuccessfulDialogMessage
                                                                          delegate:self 
                                                                 cancelButtonTitle:nil 
                                                                 otherButtonTitles:[NSArray arrayWithObject:kDeactivateDialogOkayButton]];
        
        deactivateSuccessfulConfirmation.tag = kDeactivateAccountSuccessful;
        [deactivateSuccessfulConfirmation show];        
    }
}

- (void)commandTransaction:(id<CommandTransaction>)commandTransaction didFailWithError:(NSError*)error;
{
    
    UIAlertView *deactivateFailedConfirmation;
    deactivateFailedConfirmation = [[self uiAlertViewFactory] createWithTitle:kDeactivateFailedDialogTitle 
                                                                          message:kDeactivateFailedDialogMessage
                                                                         delegate:self 
                                                                cancelButtonTitle:nil 
                                                                otherButtonTitles:[NSArray arrayWithObject:kDeactivateDialogOkayButton]];
    deactivateFailedConfirmation.tag = kDeactivateAccountFailed;
    [deactivateFailedConfirmation show];

}


#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[self uiAlertViewSelectionDetector] clickedButtonIndex:buttonIndex isCancelButtonIndexForUIAlertView:alertView])
    {
        //  Deselect the [deactivate] cell
        [[self tableView] reloadData];
        return;
    }
    
    if (alertView.tag == kDeactivateAccountConfirm)
    {
        id<TransactionCommand> deactivationCommand = [[self deactivationCommandCreator] createCommandForDeactivationWithTransactionDelegate:self];
        [[self mmcCommandQueue] append:deactivationCommand];
        deactivationCommandTransaction_ = [deactivationCommand transaction];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    if (alertView.tag == kDeactivateAccountSuccessful)
    {
         [self resetApplicationAfterDeactivation];
    }

    if (alertView.tag == kDeactivateAccountFailed)
    {
        // Do nothing as of now
    }
    
}

// Private methods MUST be declared inside a class extension
#pragma mark - Private methods
- (void)configureDeactivateCell:(UITableViewCell *)aCell
{
    [[aCell textLabel] setText:kDeactivateCellOneTitle];
    [[aCell textLabel] setTextAlignment:UITextAlignmentCenter];
    [[aCell textLabel] setTextColor:[UIColor whiteColor]];
    
    [aCell setBackgroundColor:RGB(160, 30, 30)];
}
@end
