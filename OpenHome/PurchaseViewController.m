//
//  PurchaseViewController.m
//  OpenHome
//
//  Created by Bo Wang on 29/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "PurchaseViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import <Parse/Parse.h>
#import "Common.h"
#import "Utility.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuItem setTarget: self.revealViewController];
        [self.menuItem setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *prod = [defaults objectForKey:@"pro"];
    if (prod!=nil&&[prod isEqualToString:@"yes"]){
        self.upgradeBtn.hidden = YES;
        self.restoreBtn.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buy:(id)sender {
    [PFPurchase buyProduct:upgrade_key block:^(NSError *error) {
        if (!error) {
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:@"yes" forKey:@"pro"];
            [defaults synchronize];
            [Utility ToastNotification:@"Thanks." andView:self andLoading:YES andIsBottom:YES];
        }else{
            [Utility ToastNotification:@"Sorry, Please try it again." andView:self andLoading:YES andIsBottom:YES];
        }
    }];
}
- (IBAction)restore:(id)sender {
    [PFPurchase restore];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
