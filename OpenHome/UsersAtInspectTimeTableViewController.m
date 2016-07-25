//
//  UsersAtInspectTimeTableViewController.m
//  OpenHome
//
//  Created by Bo Wang on 16/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "UsersAtInspectTimeTableViewController.h"
#import "AddEditVisitorViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "InspectUserTableViewCell.h"
#import "Utility.h"
#import <MessageUI/MessageUI.h>

@interface UsersAtInspectTimeTableViewController()<MFMailComposeViewControllerDelegate> {
    MBProgressHUD * HUD;
    MFMailComposeViewController *mailComposer;
}


@end

@implementation UsersAtInspectTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, self.navigationItem.rightBarButtonItem, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self query];
}

-(void) query{
    [HUD show:YES];
    PFQuery *query = [UserObject query];
    
    [query whereKey:@"propertyInspectTime" equalTo:_propertyInspectTime];
    [query orderByDescending:@"updatedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            self.userArray = objects;
            
            [self.tableView reloadData];
            [HUD hide:YES];
        }
    }];
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
    return [self.userArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InspectUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inspectUserCell" forIndexPath:indexPath];
    UserObject * user = [self.userArray objectAtIndex:indexPath.row];
    
    cell.name.text=[user.dictionary valueForKey:@"0" ];
    cell.phone.text=[user.dictionary valueForKey:@"1"];
    cell.email.text=[user.dictionary valueForKey:@"2"];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        UserObject * user = [_userArray objectAtIndex:indexPath.row];

        if ([user delete]){
           
            [self query];
        }else{
            [Utility ToastNotification:@"Please try it again." andView:self andLoading:YES andIsBottom:YES];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


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
    if ([segue.identifier isEqualToString:@"addVisitor"]) {
        AddEditVisitorViewController * addEditController = [ segue destinationViewController];
        addEditController.propertyObject = self.propertyObject;
        addEditController.inspectTime = self.propertyInspectTime;
    }else if ([segue.identifier isEqualToString:@"editVistor"]) {
        UserObject * user = [self.userArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        AddEditVisitorViewController * addEditController = [ segue destinationViewController];
        addEditController.propertyObject = self.propertyObject;
        addEditController.inspectTime = self.propertyInspectTime;
        addEditController.userObject=user;
    }
}


- (IBAction)sendEmail:(id)sender {
    UIButton *butn = (UIButton *)sender;
    CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    UserObject * user = [_userArray objectAtIndex:indexPath.row];
    [mailComposer setSubject:user.propertyObject.address];
    [mailComposer setMessageBody:@"" isHTML:NO];
    
    NSString * emailAddress = [user.dictionary valueForKey:@"2"];
    NSArray * array = [[NSArray alloc]initWithObjects:emailAddress, nil];
    [mailComposer setToRecipients:array];
    [self presentModalViewController:mailComposer animated:YES];
}

- (IBAction)callPhone:(id)sender {
    UIButton *butn = (UIButton *)sender;
    CGPoint buttonPosition = [[butn superview] convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    UserObject * user = [_userArray objectAtIndex:indexPath.row];
    //NSArray *keys = [user.dictionary allKeys];
    //id aKey = [keys objectAtIndex:1];
    id anObject = [user.dictionary valueForKey:@"1"];
    NSString *phoneNumber = [@"tel://" stringByAppendingString:anObject];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissModalViewControllerAnimated:YES];
    
}
@end
