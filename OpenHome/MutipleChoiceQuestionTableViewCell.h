//
//  MutipleChoiceQuestionTableViewCell.h
//  OpenHome
//
//  Created by Bo Wang on 24/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionObject.h"

@interface MutipleChoiceQuestionTableViewCell : UITableViewCell<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) IBOutlet UILabel *question;
@property(nonatomic,weak) IBOutlet UIPickerView * myPickerView;
@property(nonatomic,retain) NSMutableArray * optionArray;
@property(nonatomic,retain) QuestionObject *questionObject;

-(NSString *) getRowValue:(NSInteger)row;
@end
