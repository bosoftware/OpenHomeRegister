//
//  AddTextQuestionViewController.m
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "AddTextQuestionViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "Common.h"

@interface AddTextQuestionViewController (){
     MBProgressHUD *HUD;
}

@end

@implementation AddTextQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.question!=nil){
        self.questionTextField.text = self.question.question;
        if (self.question.mandatory.intValue==mandatoryQuestion){
            [self.mandatorySwitch setOn:YES];
        }else{
            [self.mandatorySwitch setOn:NO];
        }
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    self.questionTextField.delegate = self;
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
- (IBAction)saveQuestion:(id)sender {
    if (self.questionTextField.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Question cannot be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (self.question==nil){
        self.question = [QuestionObject object];
        self.question.currentUser=[PFUser currentUser];
        self.question.questionType=[NSNumber numberWithInt:textQuestion];
    }
    if (self.mandatorySwitch.isOn){
        self.question.mandatory = [NSNumber numberWithInt:mandatoryQuestion];
    }else{
        self.question.mandatory = [NSNumber numberWithInt:optionalQuestion];
    }
    self.question.question=self.questionTextField.text;
    [HUD show:YES];
    [self.question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [HUD hide:YES];
        
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}
@end
