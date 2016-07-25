//
//  TextQuestionTableViewCell.h
//  OpenHome
//
//  Created by Bo Wang on 24/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionObject.h"

@interface TextQuestionTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *question;
@property(nonatomic,weak) IBOutlet UITextField *answer;

@property(nonatomic,retain) QuestionObject *questionObject;
@end
