//
//  QuestionObject.m
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "QuestionObject.h"
#import "Common.h"

@implementation QuestionObject

@dynamic question,currentUser,sequence,option1,option2,option3,option4,questionType,mandatory;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Question";
}

+(void)initQuestions{
    QuestionObject * question = [QuestionObject object];
    
    question.question=@"Name";
    question.currentUser=[PFUser currentUser];
    question.mandatory = [NSNumber numberWithInt:mandatoryQuestion];
    question.questionType=[NSNumber numberWithInt:textQuestion];
    [question saveInBackground];
    
    question = [QuestionObject object];
    question.question=@"Phone Number";
    question.currentUser=[PFUser currentUser];
    question.mandatory = [NSNumber numberWithInt:mandatoryQuestion];
    question.questionType=[NSNumber numberWithInt:textQuestion];
    [question saveInBackground];
    
    
    question = [QuestionObject object];
    question.question=@"Email";
    question.currentUser=[PFUser currentUser];
    question.mandatory = [NSNumber numberWithInt:mandatoryQuestion];
    question.questionType=[NSNumber numberWithInt:textQuestion];
    [question saveInBackground];
    

}
@end
