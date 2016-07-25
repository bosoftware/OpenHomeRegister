//
//  AddEditVisitorViewController.m
//  OpenHome
//
//  Created by Bo Wang on 23/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "AddEditVisitorViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Parse/Parse.h>
#import "QuestionObject.h"
#import "Common.h"
#import "TextQuestionTableViewCell.h"
#import "MutipleChoiceQuestionTableViewCell.h"
#import <iToast/iToast.h>

@interface AddEditVisitorViewController (){
    MBProgressHUD * HUD;
    NSMutableArray * questionArray;
    NSMutableArray * allCellArray;
}


@end

@implementation AddEditVisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    self.QuestionListTableView.dataSource = self;
    self.QuestionListTableView.delegate = self;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbk.png"]];
    //self.QuestionListTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbk.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    allCellArray = [[NSMutableArray alloc]init];
    [self query];
}

-(void) query{
    [HUD show:YES];
    PFQuery *query = [QuestionObject query];
    [query whereKey:@"currentUser" equalTo:[PFUser currentUser]];
    [query orderByAscending:@"sequence"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            questionArray = objects;
            
            [self.QuestionListTableView reloadData];
            [HUD hide:YES];
        }
    }];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return questionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionObject * question = [questionArray objectAtIndex:indexPath.row];
    NSString * index = [[NSString alloc] initWithFormat:@"%ld",(long)indexPath.row];
    if (question.questionType.intValue==1){
        static NSString *textQuestionCellIdentifier = @"textQuestionCell";
        
        TextQuestionTableViewCell *cell = (TextQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:textQuestionCellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextQuestionTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.answer.delegate = self;
        if (question.mandatory.intValue == 1){
            cell.question.text = [NSString stringWithFormat:@"%@ *",question.question];
        }else{
            cell.question.text = question.question;
        }
        cell.questionObject=question;
        cell.answer.text = @"";
        
        if (_userObject!=nil && [_userObject.dictionary valueForKey:index]!=nil){
            cell.answer.text = [_userObject.dictionary valueForKey:index];
        }
        [allCellArray addObject:cell];
        return cell;
        
    }else{
        static NSString *mutipleChoiceQuestionTableViewCellIdentifier = @"mutipleChoiceQuestionCell";
        
        MutipleChoiceQuestionTableViewCell *cell = (MutipleChoiceQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:mutipleChoiceQuestionTableViewCellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MutipleChoiceQuestionTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if (question.mandatory.intValue == 1){
            cell.question.text = [NSString stringWithFormat:@"%@ *",question.question];
        }else{
            cell.question.text = question.question;
        }
        NSString * selectedOption = @"";
        if (_userObject!=nil&&[_userObject.dictionary valueForKey:index]!=nil){
            selectedOption = [_userObject.dictionary valueForKey:index];
        }
        NSMutableArray * options = [[NSMutableArray alloc]init];
        int selectedRow = 0;
        if (question.option1.length>0){
            [options addObject:question.option1];
        }
        if (question.option2.length>0){
            [options addObject:question.option2];
            if([question.option2 isEqualToString:selectedOption]){
                selectedRow = 1;
            }
        }
        if (question.option3.length>0){
            [options addObject:question.option3];
            if([question.option3 isEqualToString:selectedOption]){
                selectedRow = 2;
            }
        }
        if (question.option4.length>0){
            [options addObject:question.option4];
            if([question.option4 isEqualToString:selectedOption]){
                selectedRow = 3;
            }
        }
        
        //[cell.myPickerView reloadAllComponents];
        cell.questionObject=question;
        //[cell.myPickerView selectRow:0 inComponent:0 animated:NO];
        cell.optionArray = options;
        [cell.myPickerView reloadAllComponents];
        [cell.myPickerView selectRow:selectedRow inComponent:0 animated:NO];
        [allCellArray addObject:cell];
        return cell;
        
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    for (id obj in allCellArray){
        if ([obj isKindOfClass:[TextQuestionTableViewCell class]]){
            TextQuestionTableViewCell * cell = (TextQuestionTableViewCell*)obj;
            if ([cell.answer.text isEqualToString:@""]){
                [cell.answer becomeFirstResponder];
                [[[[iToast makeText:NSLocalizedString(@"Please answer all mandatory questions", @"")]
                   setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
                return NO;
            }
            
        }else{
            MutipleChoiceQuestionTableViewCell * cell = (MutipleChoiceQuestionTableViewCell*)obj;
            
            break;
        }
    }
    
    if (_userObject==nil){
        _userObject = [UserObject object];
        _userObject.propertyInspectTime=self.inspectTime;
        _userObject.propertyObject=self.propertyObject;
        _userObject.dictionary=[[NSMutableDictionary alloc]init];
    }
    int i =0;
    for (id obj in allCellArray){
        if ([obj isKindOfClass:[TextQuestionTableViewCell class]]){
            TextQuestionTableViewCell * cell = (TextQuestionTableViewCell*)obj;
            if (![cell.answer.text isEqualToString:@""]){
                [ _userObject.dictionary setValue:cell.answer.text forKey:[[NSString alloc]initWithFormat:@"%d",i]];
            }
        }else{
            MutipleChoiceQuestionTableViewCell * cell = (MutipleChoiceQuestionTableViewCell*)obj;
            NSInteger row = [cell.myPickerView selectedRowInComponent:0];
            NSString * value = [cell getRowValue:row];
            [ _userObject.dictionary setValue:value forKey:[[NSString alloc]initWithFormat:@"%d",i]];
        }
        i++;
    }
    [HUD show:YES];
    
    
        if (![self.userObject save]){
            [self.userObject pinInBackground];
            [self.userObject saveInBackground];
            [self.userObject saveEventually];
        }
        //[self.navigationController popViewControllerAnimated:YES];
        [HUD hide:YES];
        
    
    
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"doneRegister"]) {
        self.userObject = nil;
    }
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
*/
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
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
