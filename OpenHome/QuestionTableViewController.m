//
//  QuestionTableViewController.m
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "QuestionTableViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "QuestionObject.h"
#import "Common.h"
#import "AddTextQuestionViewController.h"
#import "AddMultipleChoiceQuestionViewController.h"

@interface QuestionTableViewController (){
    MBProgressHUD * HUD;
}

@end

@implementation QuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem,self.addButtonItem, nil];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self query];
}


-(void) query{
    [HUD show:YES];
    PFQuery *query = [QuestionObject query];
    
    [query whereKey:@"currentUser" equalTo:[PFUser currentUser]];
    [query orderByAscending:@"sequence"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
                self.questionArray = objects;
            
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
    return self.questionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell"];
    QuestionObject * question = [self.questionArray objectAtIndex:indexPath.row];
    cell.textLabel.text = question.question;
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row<3){
        return NO;
    }
    
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        QuestionObject * question = [self.questionArray objectAtIndex:indexPath.row];
        [HUD show:YES];
        [question deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self query];
            [HUD hide:YES];
        }];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
     QuestionObject * questionFrom = [self.questionArray objectAtIndex:fromIndexPath.row];
     QuestionObject * questionTo = [self.questionArray objectAtIndex:toIndexPath.row];
     NSNumber * fromNumber = questionFrom.sequence;
     questionFrom.sequence = questionTo.sequence;
     questionTo.sequence = fromNumber;
     [HUD show:YES];
     [questionFrom saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
         [questionTo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
             [self query];
             [HUD hide:YES];
         }];
     }];
     
 }
 


 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
     return YES;
 }
 


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionObject * question = [self.questionArray objectAtIndex:indexPath.row];
    
    if (question.questionType.intValue==textQuestion){
        AddTextQuestionViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"addTextQuestion"];
        viewController.question=question;
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (question.questionType.intValue==multipleChoiceQuestion){
        AddMultipleChoiceQuestionViewController * viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"addMultipleChoiceQuestion"];
        viewController.question = question;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
