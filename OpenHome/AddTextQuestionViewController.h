//
//  AddTextQuestionViewController.h
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionObject.h"
@interface AddTextQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *questionTextField;
@property (nonatomic,retain) QuestionObject * question;
@property (weak, nonatomic) IBOutlet UISwitch *mandatorySwitch;

@end
