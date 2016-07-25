//
//  InspectTimeTableViewController.m
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "InspectTimeTableViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "PropertyInspectTime.h"
#import "AddEditInspectTimeViewController.h"
#import "InspectTimeTableViewCell.h"
#import "UsersAtInspectTimeTableViewController.h"
#import "UserObject.h"

@interface InspectTimeTableViewController (){
    MBProgressHUD *HUD;
}

@end

@implementation InspectTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self query];
    
}

-(void)query{
    [HUD show:YES];
    PFQuery *query = [PropertyInspectTime query];
    
    [query whereKey:@"propertyObject" equalTo:self.propertyObject];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            self.inspectTimeArray = objects;
            
            [self.tableView reloadData];
            [HUD hide:YES];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.inspectTimeArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InspectTimeTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"inspectTime"];
    PropertyInspectTime * inspectTime = [self.inspectTimeArray objectAtIndex:indexPath.row];
    cell.inspectTimeLabel.text = inspectTime.inspectTime;
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addInspectTime"]) {
        AddEditInspectTimeViewController * addInspectTimeController = [segue destinationViewController];
        addInspectTimeController.propertyObject = self.propertyObject;
        
    }else if ([segue.identifier isEqualToString:@"editInspectTime"]){
        UIButton *butn = (UIButton *)sender;
        CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        AddEditInspectTimeViewController * addInspectTimeController = [segue destinationViewController];
        addInspectTimeController.propertyObject = self.propertyObject;
        addInspectTimeController.inspectTime=[self.inspectTimeArray objectAtIndex:indexPath.row];
        
    }else if ([segue.identifier isEqualToString:@"showUsers"]){
        UsersAtInspectTimeTableViewController * usersController = [segue destinationViewController];
        usersController.propertyInspectTime = [self.inspectTimeArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        usersController.propertyObject = self.propertyObject;
    }
    
}

- (IBAction)deleteInspectTime:(id)sender {
    
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
        PropertyInspectTime * inspectTime = [_inspectTimeArray objectAtIndex:alertView.tag];
        
        PFQuery *query = [UserObject query];
        
        [query whereKey:@"propertyInspectTime" equalTo:inspectTime];
        NSArray * userArray = [query findObjects];
        [UserObject deleteAllInBackground:userArray];
        
        [inspectTime deleteInBackground];
        
        
        [self query];
    }
}

@end
