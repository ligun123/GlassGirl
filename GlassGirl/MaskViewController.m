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

#define k_URL_APP @"http://www.baidu.com"

@interface MaskViewController ()

@end

@implementation MaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    isToolbarHidden = NO;
    // Do any additional setup after loading the view from its nib.
    UIImage *img = [[ImageManager shareManager] imageOfName:self.srcImgName];
    self.srcImageView.image = img;
    self.maskView = [[ImageMaskView alloc] initWithFrame:self.view.bounds image:[img glassImage]];
    [self.view insertSubview:self.maskView aboveSubview:self.srcImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    [self performSelector:@selector(hideToolbar) withObject:nil afterDelay:3.0f];
    
    //设置toolbar
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 2, 50, 40);
    [btnBack setImage:[UIImage imageNamed:@"pb_back_btn"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btnBack];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 6.999) {
        //IOS7+可以QQZone分享
        UIButton *btnQQZone = [UIButton buttonWithType:UIButtonTypeCustom];
        btnQQZone.frame = CGRectMake(160, 5, 34, 34);
        [btnQQZone setImage:[UIImage imageNamed:@"sns_icon_6"] forState:UIControlStateNormal];
        [btnQQZone addTarget:self action:@selector(btnQQZone:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolbar addSubview:btnQQZone];
    }
    
    UIButton *btnSina = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSina.frame = CGRectMake(200, 5, 34, 34);
    [btnSina setImage:[UIImage imageNamed:@"sns_icon_1"] forState:UIControlStateNormal];
    [btnSina addTarget:self action:@selector(btnSina:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btnSina];
    
    UIButton *btnFacebook = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFacebook.frame = CGRectMake(240, 5, 34, 34);
    [btnFacebook setImage:[UIImage imageNamed:@"sns_icon_10"] forState:UIControlStateNormal];
    [btnFacebook addTarget:self action:@selector(btnFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btnFacebook];
    
    UIButton *btnTwitter = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwitter.frame = CGRectMake(280, 5, 34, 34);
    [btnTwitter setImage:[UIImage imageNamed:@"sns_icon_11"] forState:UIControlStateNormal];
    [btnTwitter addTarget:self action:@selector(btnTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btnTwitter];
}

- (void)btnBackTap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnQQZone:(id)sender
{
    self.slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
    [self.slComposerSheet setInitialText:@""];
    UIImage *imgSend = [self convertViewToImage:self.view];
    [self.slComposerSheet addImage:imgSend];
    [self.slComposerSheet addURL:[NSURL URLWithString:k_URL_APP]];
    [self presentViewController:self.slComposerSheet animated:YES completion:nil];
    [self.slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                NSLog(@"%s -> SLComposeViewControllerResultCancelled", __FUNCTION__);
                break;
            case SLComposeViewControllerResultDone:
                NSLog(@"%s -> SLComposeViewControllerResultDone", __FUNCTION__);
                break;
            default:
                break;
        }
        [self.slComposerSheet dismissModalViewControllerAnimated:NO];
    }];
}

- (void)btnFacebook:(id)sender
{
    self.slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [self.slComposerSheet setInitialText:@""];
    UIImage *imgSend = [self convertViewToImage:self.view];
    [self.slComposerSheet addImage:imgSend];
    [self.slComposerSheet addURL:[NSURL URLWithString:k_URL_APP]];
    [self presentViewController:self.slComposerSheet animated:YES completion:nil];
    [self.slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                NSLog(@"%s -> SLComposeViewControllerResultCancelled", __FUNCTION__);
                break;
            case SLComposeViewControllerResultDone:
                NSLog(@"%s -> SLComposeViewControllerResultDone", __FUNCTION__);
                break;
            default:
                break;
        }
        [self.slComposerSheet dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)btnTwitter:(id)sender
{
    self.slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self.slComposerSheet setInitialText:@""];
    UIImage *imgSend = [self convertViewToImage:self.view];
    [self.slComposerSheet addImage:imgSend];
    [self.slComposerSheet addURL:[NSURL URLWithString:k_URL_APP]];
    [self presentViewController:self.slComposerSheet animated:YES completion:nil];
    [self.slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                NSLog(@"%s -> SLComposeViewControllerResultCancelled", __FUNCTION__);
                break;
            case SLComposeViewControllerResultDone:
                NSLog(@"%s -> SLComposeViewControllerResultDone", __FUNCTION__);
                break;
            default:
                break;
        }
        [self.slComposerSheet dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)btnSina:(id)sender
{
    self.slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    [self.slComposerSheet setInitialText:@""];
    UIImage *imgSend = [self convertViewToImage:self.view];
    [self.slComposerSheet addImage:imgSend];
    [self.slComposerSheet addURL:[NSURL URLWithString:k_URL_APP]];
    [self presentViewController:self.slComposerSheet animated:YES completion:nil];
    [self.slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                NSLog(@"%s -> SLComposeViewControllerResultCancelled", __FUNCTION__);
                break;
            case SLComposeViewControllerResultDone:
                NSLog(@"%s -> SLComposeViewControllerResultDone", __FUNCTION__);
                break;
            default:
                break;
        }
        [self.slComposerSheet dismissViewControllerAnimated:YES completion:nil];
    }];
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


- (void)singleTap:(UITapGestureRecognizer *)tap
{
    if (isToolbarHidden) {
        [UIView animateWithDuration:0.5 animations:^{
            self.toolbar.frame = CGRectOffset(self.toolbar.frame, 0, -self.toolbar.frame.size.height);
        } completion:^(BOOL finished) {
            isToolbarHidden = NO;
        }];
        
        [self performSelector:@selector(hideToolbar) withObject:nil afterDelay:3.0f];
    }
}

- (void)hideToolbar
{
    [UIView animateWithDuration:0.5 animations:^{
        self.toolbar.frame = CGRectOffset(self.toolbar.frame, 0, self.toolbar.frame.size.height);
    } completion:^(BOOL finished) {
        isToolbarHidden = YES;
    }];
}



-(UIImage*)convertViewToImage:(UIView*)v {
    UIGraphicsBeginImageContext(v.bounds.size);
//    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    [self.srcImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    [self.maskView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
