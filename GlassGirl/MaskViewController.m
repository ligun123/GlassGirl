//
//  MaskViewController.m
//  GlassGirl
//
//  Created by HalloWorld on 14-7-4.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "MaskViewController.h"
#import "UIImage+Glass.h"
#import "ImageManager.h"

@interface MaskViewController ()

@end

@implementation MaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *img = [[ImageManager shareManager] imageOfName:self.srcImgName];
    self.srcImageView.image = img;
//    self.dsrImageView.image = [img glassImage];
    ImageMaskView *mskView = [[ImageMaskView alloc] initWithFrame:self.view.bounds image:[img glassImage]];
    [self.view insertSubview:mskView aboveSubview:self.srcImageView];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
