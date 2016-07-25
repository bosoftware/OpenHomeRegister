//
//  ThanksRegisterViewController.m
//  OpenHome
//
//  Created by Bo Wang on 25/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "ThanksRegisterViewController.h"
#import "AddEditVisitorViewController.h"

@interface ThanksRegisterViewController ()

@end

@implementation ThanksRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbk.png"]];
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    
    [self.view addGestureRecognizer:singleTapGestureRecognizer];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    //AddEditVisitorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddEditVisitorViewController"];
    
    //[self.navigationController presentViewController:vc animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)startNextRegister:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
