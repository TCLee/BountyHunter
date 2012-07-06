//
//  FugitivePhotoViewController.h
//  BountyHunter
//
//  Created by Lee Tze Cheun on 6/8/12.
//  Copyright (c) 2012 TC Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fugitive;

@interface FugitivePhotoViewControllerPhone : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) Fugitive *fugitive;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addPhoto:(id)sender;

@end
