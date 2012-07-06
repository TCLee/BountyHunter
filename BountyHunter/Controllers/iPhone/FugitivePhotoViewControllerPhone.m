//
//  FugitivePhotoViewController.m
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/8/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import "FugitivePhotoViewControllerPhone.h"
#import "Fugitive.h"

// UIActionSheet button index.
#define ActionSheetButtonIndexNewPhoto      0
#define ActionSheetButtonIndexExistingPhoto 1

@implementation FugitivePhotoViewControllerPhone

@synthesize fugitive = _fugitive;
@synthesize imageView = _imageView;

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

/* Show the fugitive's image when this view appears on the screen. */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.fugitive.image) {         
        self.imageView.image = [[UIImage alloc] initWithData:self.fugitive.image];
    }
}

- (void)viewDidUnload
{
    self.fugitive = nil;
    [super viewDidUnload];    
}

#pragma mark - Device Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)theSourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = theSourceType;
    [self presentModalViewController:imagePickerController animated:YES];
}

#pragma mark - UI Actions

- (IBAction)addPhoto:(id)sender {
    // If device has a camera, user gets to take a new photo or select
    // an existing photo from photo library.
    // Otherwise without a camera, user can only select an existing photo.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *photoSourceSheet = [[UIActionSheet alloc] 
                                           initWithTitle:@"Select Fugitive Photo" 
                                           delegate:self 
                                           cancelButtonTitle:@"Cancel" 
                                           destructiveButtonTitle:nil 
                                           otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        [photoSourceSheet showFromTabBar:self.tabBarController.tabBar];
    } else {
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }    
}

#pragma mark - Image Picker Controller Delegate

- (void)imagePickerController:(UIImagePickerController *)picker 
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.fugitive.image = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerEditedImage]);    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];    
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet 
    didDismissWithButtonIndex:(NSInteger)buttonIndex
{    
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        // User tapped the Cancel button.
        return;
    } else if (buttonIndex == ActionSheetButtonIndexNewPhoto) {
        // User wants to take a new photo with the device's camera.
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        // User wants to select an existing photo from photo library.
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

@end
