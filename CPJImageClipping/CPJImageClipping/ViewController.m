//
//  ViewController.m
//  CPJImageClipping
//
//  Created by shuaizhai on 2/18/16.
//  Copyright © 2016 com.zhaishuai.www. All rights reserved.
//

#import "ViewController.h"
#import "MSMFaceClipperVC.h"


@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) NSMutableArray *capturedImages;
@property (nonatomic) UIImagePickerController *imagePickerController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.capturedImages = [[NSMutableArray alloc] init];

}// viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}// didReceiveMemoryWarning

- (IBAction)chooseImage:(id)sender {
    
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
}// chooseImage

- (IBAction)cropImage:(id)sender {
    
    MSMFaceClipperVC *vc = [[MSMFaceClipperVC alloc] initWithNibName:@"MSMFaceClipperVC" bundle:nil];
    vc.pvc = self;
    vc.view.frame = self.view.frame;
    
    [self presentViewController:vc animated:YES completion:nil];
    vc.imageClipping.image = self.imageView.image;
    
}// cropImage

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
    {
        [self.imageView stopAnimating];
    }
    
    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        /*
         The user wants to use the camera interface. Set up our custom overlay view for the camera.
         */
        imagePickerController.showsCameraControls = NO;
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // Camera took a single picture.
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
        }
        else
        {
            // Camera took multiple pictures; use the list of images for animation.
            self.imageView.animationImages = self.capturedImages;
            self.imageView.animationDuration = 5.0;    // Show each captured photo for 5 seconds.
            self.imageView.animationRepeatCount = 0;   // Animate forever (show all photos).
            [self.imageView startAnimating];
        }
        
        // To be ready to start again, clear the captured images array.
        [self.capturedImages removeAllObjects];
    }
    
    self.imagePickerController = nil;
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.capturedImages addObject:image];
    
    [self finishAndUpdate];
    
}// imagePickerController


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}// imagePickerControllerDidCancel


@end
