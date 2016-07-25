#import "StarterViewController.h"
#import <Parse/Parse.h>

@interface StarterViewController ()

@end

@implementation StarterViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    } else {
        [self performSegueWithIdentifier:@"mainVC" sender:nil];
    }
}


@end
