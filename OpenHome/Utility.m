//
//  Utility.m
//  OpenHome
//
//  Created by Bo Wang on 25/07/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom
{
    //    GCDiscreetNotificationView *notificationView = [[GCDiscreetNotificationView alloc] initWithText:text showActivity:isLoading inPresentationMode:isBottom ? GCDiscreetNotificationViewPresentationModeBottom : GCDiscreetNotificationViewPresentationModeTop inView:view];
    //    [notificationView show:YES];
    //    [notificationView hideAnimatedAfter:2.6];
    //
    //    NSString *message = @"Please input item name";
    
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:text
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    int duration = 1; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
    
}
@end
