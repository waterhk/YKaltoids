//
//  YAReportProblemViewController.m
//  altoids
//
//  Created by Stephane Karoubi on 11/23/11.
//  Copyright (c) 2011 Yahoo!. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "YAReportProblemViewController.h"
#import "NavigationBarButtonItemRepository.h"
#import "ProblemReporter.h"

@interface YAReportProblemViewController ()
// methods
- (void)sendReport:(id)sender;
- (void)seedTextViewFromCell:(UITableViewCell*)cell withRadius:(CGFloat)radius andFontSize:(CGFloat)size;
@end

@implementation YAReportProblemViewController

#define kCellReportProblemHeight 140
#define kCellDebugLogsHeight 44
#define kCellTextViewLeftMargin 2
#define kCellTextViewTopMargin 2
#define kCellTextViewRightMargin 24
#define kCellTextViewBottomMargin 5

@synthesize navigationBarButtonItemRepository = navigationBarButtonItemRepository_;
@synthesize textViewReportProblem = textViewReportProblem_;
@synthesize problemReporter = problemReporter_;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setRightBarButtonItem:[[self navigationBarButtonItemRepository] sendButtonItemWithTarget:self action:@selector(sendReport:)]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setTitle:kReportProblemViewControllerTitle];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIViewController *)viewController
{
    return self;   
}

#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        return kCellReportProblemHeight;
    } else {
        return kCellDebugLogsHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([indexPath row] == 0) {
        [self seedTextViewFromCell:cell withRadius:8.0 andFontSize:14.0];
        [[cell contentView] addSubview:[self textViewReportProblem]];
        
//        Bring up keyboard upon ViewController entry. Since the TextView is initialized here
//        we cannot do this operation in viewWillAppear
        [[self textViewReportProblem] becomeFirstResponder];
    } else {
        UIImageView* checkMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kCheckMarkImageIcon]];
        [cell setAccessoryView:checkMarkImageView];
        [[cell textLabel] setText:kReportProblemCellTwoTitle];
        [cell setUserInteractionEnabled:NO];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

// Private methods MUST be declared inside a class extension
#pragma mark - Private methods
- (void)sendReport:(id)sender
{
    // TODO: persist updated user profile information
    YALogDebug(@"Reporting problem: %@", [[self textViewReportProblem] text]);
    
    // async task with operation queue
    [[self problemReporter] reportProblemWithUserComment:[[self textViewReportProblem] text]];    
    [[self textViewReportProblem] setText:@""];

    // simulate user pressing [back], essentially...
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)seedTextViewFromCell:(UITableViewCell*)cell withRadius:(CGFloat)radius andFontSize:(CGFloat)size;
{
    CGRect cellFrame = [cell frame];
    [self setTextViewReportProblem:[[UITextView alloc] initWithFrame:CGRectMake(cellFrame.origin.x + kCellTextViewLeftMargin,
                                                                                cellFrame.origin.y + kCellTextViewTopMargin, 
                                                                                cellFrame.size.width - kCellTextViewRightMargin, 
                                                                                kCellReportProblemHeight - kCellTextViewBottomMargin)]];
    [[self textViewReportProblem] setFont:[UIFont systemFontOfSize:size]];
    [[self textViewReportProblem] setBackgroundColor:[UIColor clearColor]];
    [[[self textViewReportProblem] layer] setCornerRadius:radius];
}

@end
