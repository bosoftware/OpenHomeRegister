//
//  QuestionObject.h
//  OpenHome
//
//  Created by Bo Wang on 14/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface QuestionObject : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property(nonatomic,retain) PFUser * currentUser;
@property (nonatomic,retain) NSString *question;
@property (nonatomic,retain) NSString *option1;
@property(nonatomic,retain)NSString *option2;
@property(nonatomic,retain)NSString * option3;
@property(nonatomic,retain)NSString * option4;
@property(nonatomic,retain) NSNumber *sequence;
@property (nonatomic,retain) NSNumber *questionType;
@property (nonatomic,retain) NSNumber *mandatory;
+(void)initQuestions;
@end
