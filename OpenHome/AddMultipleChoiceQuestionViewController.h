//
//  AddMultipleChoiceQuestionViewController.h
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionObject.h"

@interface AddMultipleChoiceQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (weak, nonatomic) IBOutlet UITextField *option1TextField;
@property (weak, nonatomic) IBOutlet UITextField *option2TextField;
@property (weak, nonatomic) IBOutlet UITextField *option3TextField;
@property (weak, nonatomic) IBOutlet UITextField *option4TextField;
@property (nonatomic,retain) QuestionObject * question;

@property (weak, nonatomic) IBOutlet UISwitch *mandatorySwitch;

@end
