//
//  SidebarViewController.m
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "SidebarViewController.h"
#import "PropertyListViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import <Parse/Parse.h>
#import "StarterViewController.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController{
     NSArray *menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     menuItems = @[@"property", @"question", @"share",@"upgrade",@"logout"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"property"]) {
        
        UINavigationController *navController = segue.destinationViewController;
        PropertyListViewController *propertyListController = [navController childViewControllers].firstObject;
        
    }
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController: [segue destinationViewController]];
    self.revealViewController.frontViewController =  nc;
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4){
        [PFUser logOut];
        StarterViewController * viewController = [self.storyboard instantiateInitialViewController];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}
@end
