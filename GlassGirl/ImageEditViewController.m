//
//  ImageEditViewController.m
//  GlassGirl
//
//  Created by HalloWorld on 14-7-17.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "ImageEditViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Expand.h"
#import "ImageManager.h"

@interface ImageEditViewController ()

@end

@implementation ImageEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    self.rootScrollView.maximumZoomScale = 2.0;
    self.rootScrollView.minimumZoomScale = 0.25;
    
    CGSize imgSize = self.originalImage.size;
    self.rootScrollView.contentSize = imgSize;
    self.imgView.frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
    self.imgView.image = self.originalImage;
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnDoneTap:)];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    self.view.layer.borderColor = [UIColor orangeColor].CGColor;
    self.view.layer.borderWidth = 2.0f;
    
    self.rootScrollView.zoomScale = 0.5;
    scaleResult = 0.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btnDoneTap:(id)sender {
    CGPoint offset = self.rootScrollView.contentOffset;
    int x = offset.x / scaleResult;
    int y = offset.y / scaleResult;
    CGRect cutRect = CGRectZero;
    cutRect.origin = CGPointMake(x, y);
    
    int width = self.view.bounds.size.width / scaleResult;
    int height = self.view.bounds.size.height / scaleResult;
    cutRect.size = CGSizeMake(width, height);
    
    NSLog(@"%s -> %@", __FUNCTION__, NSStringFromCGRect(cutRect));
    
    CGRect imgRect = CGRectZero;
    imgRect.size = self.originalImage.size;
    if (CGRectContainsRect(imgRect, cutRect)) {
        NSLog(@"%s -> Good scale", __FUNCTION__);
        UIImage *cuttedImage = [self.originalImage imageAtRect:cutRect];
        UIImage *goodImage = [cuttedImage imageByScalingProportionallyToSize:[UIScreen mainScreen].bounds.size];
        [[ImageManager shareManager] saveNewImage:goodImage];
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:k_Name_Add_New_Pic object:nil];
        }];
    } else {
        NSLog(@"%s -> Bad scale", __FUNCTION__);
    }
}

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    scaleResult = scale;
}

@end
