//
//  ViewController.m
//  GlassGirl
//
//  Created by HalloWorld on 14-6-27.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Glass.h"
#import "ImageMaskView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *tmp = [UIImage imageNamed:@"test.jpg"];
    UIImage *fish = [tmp glassImage];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:tmp];
    imgview.frame = CGRectMake(0, 0, imgview.frame.size.width /2, imgview.frame.size.height /2);
    [self.view addSubview:imgview];
    
    ImageMaskView *glass = [[ImageMaskView alloc] initWithFrame:imgview.frame image:fish];
    [self.view addSubview:glass];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
