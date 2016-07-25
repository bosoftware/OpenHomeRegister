//
//  MutipleChoiceQuestionTableViewCell.m
//  OpenHome
//
//  Created by Bo Wang on 24/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "MutipleChoiceQuestionTableViewCell.h"

@implementation MutipleChoiceQuestionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _myPickerView.delegate = self;
    _myPickerView.dataSource = self;
    //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbk.png"]];
    
}
/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _optionArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _optionArray[row];
}

-(NSString *) getRowValue:(NSInteger)row{
    return _optionArray[row];
}
@end
