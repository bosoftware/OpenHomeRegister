//
//  AddEditPropertyViewController.m
//  OpenHome
//
//  Created by Bo Wang on 13/06/2015.
//  Copyright (c) 2015 Bo Software. All rights reserved.
//

#import "AddEditPropertyViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MBProgressHUD/MBProgressHUD.h>
#define ScaleImage 300;

@interface AddEditPropertyViewController ()<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@end

@implementation AddEditPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePicture)];
    singleTap.numberOfTapsRequired = 1;
    [_propertyImageView setUserInteractionEnabled:YES];
    [_propertyImageView addGestureRecognizer:singleTap];
    if (self.property!=nil){
        self.address.text = self.property.address;
        self.suburb.text = self.property.suburb;
        self.state.text = self.property.state;
        if (self.property.image!=nil){
            [self.property.image getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    self.image=image;
                    self.propertyImageView.image = self.image;
                }
            }];
        }
    }
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    self.address.delegate = self;
    self.suburb.delegate = self;
    self.state.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)changePicture
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Select an Option" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library", nil];
    actionSheet.tag=200;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==200){
        if (buttonIndex==0) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            picker.view.tag=100;
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
        else if(buttonIndex==1){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            picker.view.tag=100;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    image = [self scaledImageWithImage:image];
    self.image = image;
    self.propertyImageView.image=self.image;
}

-(UIImage*)scaledImageWithImage:(UIImage*)sourceImage
{
    float oldWidth = sourceImage.size.width;
    float i_width=ScaleImage;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)saveProperty:(id)sender {
    
    
    if (self.address.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Address cannot be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }else if (self.suburb.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Suburb cannot be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    else if(self.state.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"State cannot be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    

    
    [HUD show:YES];
    if (self.property==nil){
        self.property = [PropertyObject object];
        self.property.currentUser = [PFUser currentUser];
    }
    self.property.address = self.address.text;
    self.property.state = self.state.text;
    self.property.suburb=self.suburb.text;
    if (self.image!=nil){
        NSData *imageData = UIImagePNGRepresentation(self.image);
        PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        [imageFile saveInBackground];
        self.property.image= imageFile;
    }
    
    
    [self.property saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
        [HUD hide:YES];
        
    }];
    
    
    
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
