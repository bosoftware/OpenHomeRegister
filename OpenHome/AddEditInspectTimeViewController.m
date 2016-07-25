//
//  AddEditInspectTimeViewController.m
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "AddEditInspectTimeViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface AddEditInspectTimeViewController (){
    NSDateFormatter *dateFormatter;
     MBProgressHUD *HUD;
}

@end

@implementation AddEditInspectTimeViewController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    // Do any additional setup after loading the view.
    if (self.inspectTime!=nil){
        NSString * inspectTime = self.inspectTime.inspectTime;
       
        
        self.myDatePicker.date = [dateFormatter dateFromString:inspectTime];
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)saveInspectTime:(id)sender {
    if (self.inspectTime==nil){
        self.inspectTime=[PropertyInspectTime object];
        self.inspectTime.currentUser=[PFUser currentUser];
        self.inspectTime.propertyObject=self.propertyObject;
    }
    self.inspectTime.inspectTime = [dateFormatter stringFromDate:self.myDatePicker.date];
    [HUD show:YES];
    [self.inspectTime saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [HUD hide:YES];
        
    }];

}

@end
