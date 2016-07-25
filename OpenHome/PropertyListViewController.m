//
//  PropertyListViewController.m
//  OpenHome
//
//  Created by Bo Wang on 8/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "PropertyListViewController.h"
#import "SWRevealViewController.h"
#import "PropertyCell.h"
#import "PropertyObject.h"
#import "AddEditPropertyViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "InspectTimeTableViewController.h"
#import "Utility.h"
#import "PropertyInspectTime.h"
#import "UserObject.h"

@interface PropertyListViewController ()<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}


@end

@implementation PropertyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuButton setTarget: self.revealViewController];
        [self.menuButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    //self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, self.navigationItem.rightBarButtonItem, nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self query];
}

-(void)query{
    [HUD show:YES];
    PFQuery *query = [PropertyObject query];
    
    [query whereKey:@"currentUser" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            self.propertyArray = objects;
            
            [self.tableView reloadData];
            [HUD hide:YES];
        }else{
            [Utility ToastNotification:@"Sorry, Please try it again." andView:self andLoading:YES andIsBottom:YES];
            [HUD hide:YES];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"editProperty"]) {
        PropertyObject * property;
        UIButton *butn = (UIButton *)sender;
        
        if (self.searchDisplayController.active == YES){
            CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.searchDisplayController.searchResultsTableView];
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForRowAtPoint:buttonPosition];
            property = [_filteredPropertyArray objectAtIndex:indexPath.row];
        }else{
            CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.tableView];
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
            
            property = [_propertyArray objectAtIndex:indexPath.row];
        }
        
        AddEditPropertyViewController * addEditProperty = [segue destinationViewController];
        addEditProperty.property = property;
    }else if ([segue.identifier isEqualToString:@"inspectTime"]){
        PropertyObject * property;
        
        if (self.searchDisplayController.active == YES){
            
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            property = [_filteredPropertyArray objectAtIndex:indexPath.row];
        }else{
            
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            
            property = [_propertyArray objectAtIndex:indexPath.row];
        }
        InspectTimeTableViewController * inspectTimeTable = [segue destinationViewController];
        inspectTimeTable.propertyObject = property;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.propertyArray.count)
    {
        PropertyCell *propertyCell = [self.tableView dequeueReusableCellWithIdentifier:@"PropertyCellID"];
        //        if (propertyCell==nil) {
        //            propertyCell = [[PropertyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PropertyCellID"];
        //
        //
        //        }
        PropertyObject * property;
        if (tableView == self.searchDisplayController.searchResultsTableView) {
            property = [_filteredPropertyArray objectAtIndex:indexPath.row];
        } else {
            property = [_propertyArray objectAtIndex:indexPath.row];
        }
        
        [propertyCell configureCellForAppRecord:property];
        cell = propertyCell;
    }
    else
    {
        UITableViewCell *loadingCell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCellId"];
        UILabel *statusLabel = (UILabel *)[loadingCell.contentView viewWithTag:111];
        statusLabel.text = @"";
        cell = loadingCell;
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count ;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        count = self.filteredPropertyArray.count;
    } else {
        count = self.propertyArray.count ? self.propertyArray.count : 1;
    }
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.filteredPropertyArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.address contains[c] %@",searchText];
    _filteredPropertyArray = [NSMutableArray arrayWithArray:[_propertyArray filteredArrayUsingPredicate:predicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (IBAction)deleteProperty:(id)sender {
    UIButton *butn = (UIButton *)sender;
    CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete" message:@"Are you sure you want to delete this?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alert setTag:indexPath.row];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [HUD show:YES];
        PropertyObject * property = [_propertyArray objectAtIndex:alertView.tag];
        PFQuery *query = [PropertyInspectTime query];
        
        [query whereKey:@"propertyObject" equalTo:property];
        NSArray * inspectTimeArray = [query findObjects];
        
        
        [PropertyInspectTime deleteAllInBackground:inspectTimeArray];
        
        query = [UserObject query];
        
        [query whereKey:@"propertyObject" equalTo:property];
        NSArray * userArray = [query findObjects];
        
        [UserObject deleteAllInBackground:userArray];
        
        
        [property deleteInBackground];
        
        
        [self query];
        [HUD hide:YES];
    }
}


-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if ([identifier isEqualToString:@"addProperty"]){
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *prod = [defaults objectForKey:@"pro"];
        if (prod==nil||![prod isEqualToString:@"yes"]){
            if (self.propertyArray.count>0){
                [Utility ToastNotification:@"Please upgrade. Thanks." andView:self andLoading:YES andIsBottom:YES];
                return NO;
            }
        }
    }
    
    return YES;
}

@end
