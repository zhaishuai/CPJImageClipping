//
//  MSMFaceClipperVC.m
//  SweetBeauty
//
//  Created by shuaizhai on 12/13/15.
//  Copyright © 2015 YZX. All rights reserved.
//

#import "MSMFaceClipperVC.h"
#import "ViewController.h"
#define HEADER_SIZE 200

@interface MSMFaceClipperVC ()



@end

@implementation MSMFaceClipperVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.imageClipping = [[CPJImageClipping alloc] init];
    [self addChildViewController:self.imageClipping];
    self.imageClipping.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 35);
    self.imageClipping.clippingPanel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95];
    self.imageClipping.clippingRect = CGRectMake(SCREEN_WIDTH/2 - HEADER_SIZE/2, SCREEN_HEIGHT/2 - HEADER_SIZE/2, HEADER_SIZE, HEADER_SIZE);
    UIImageView *coverView = [[UIImageView alloc] initWithFrame:self.imageClipping.clippingRect];
    [self.imageClipping.view addSubview:coverView];
    [self.imageClipping.clippingPanel setNeedsDisplay];
    [self.view addSubview:self.imageClipping.view];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAcvtion:(id)sender {
    
}

- (IBAction)clipAction:(id)sender {
    [(ViewController *)self.pvc imageView].image = [self.imageClipping clippImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
