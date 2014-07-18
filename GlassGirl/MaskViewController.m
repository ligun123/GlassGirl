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
#import "WXApi.h"
#import "UIImage+Expand.h"

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
    CGRect f = self.srcImageView.frame;
    f.size = CGSizeMake(img.size.width/2, img.size.height/2);
    f = CGRectOffset(f, 0, -(f.size.height - self.view.bounds.size.height) / 2);
    self.srcImageView.frame = f;
    self.srcImageView.image = img;
    self.maskView = [[ImageMaskView alloc] initWithFrame:self.srcImageView.frame image:[img glassImage]];
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
    
    UIButton *btnQQZone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnQQZone.frame = CGRectMake(160, 5, 34, 34);
    [btnQQZone setImage:[UIImage imageNamed:@"sns_icon_22"] forState:UIControlStateNormal];
    [btnQQZone addTarget:self action:@selector(btnQQZone:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolbar addSubview:btnQQZone];

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

- (UIImage*)convertImage {
    CGSize size = self.srcImageView.image.size;
    UIGraphicsBeginImageContext(size);
    [self.srcImageView.image drawAtPoint:CGPointZero];
    [self.maskView.image drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark - 分享

//微信朋友圈
- (void)btnQQZone:(id)sender
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"Icon.jpg"]];
    
    WXImageObject *ext = [WXImageObject object];
    
    UIImage* image = [self convertImage];
    ext.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


//废弃的方法
- (void) sendAppContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"App消息";
    message.description = @"这种消息只有App自己才能理解，由App指定打开方式！";
    UIImage *img = [self convertImage];
    NSData *data = UIImageJPEGRepresentation(img, 0.4);
    [message setThumbData:data];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>extend info</xml>";
    ext.url = @"wx2ebe84f18a103b15://platformId=wechat";
    ext.fileData = data;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


- (void)btnFacebook:(id)sender
{
    SLComposeViewController *comp = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    if (comp == nil) return ;
    [comp setInitialText:NSLocalizedString(@"RecommendText", nil)];
    UIImage *imgSend = [self convertImage];
    [comp addImage:imgSend];
    [comp addURL:[NSURL URLWithString:k_URL_APP]];
    [comp setCompletionHandler:^(SLComposeViewControllerResult result) {
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
//        [comp dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:comp animated:YES completion:nil];
}


- (void)btnTwitter:(id)sender
{
    SLComposeViewController *comp = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    if (comp == nil) return ;
    [comp setInitialText:@""];
    UIImage *imgSend = [self convertImage];
    [comp addImage:imgSend];
    [comp addURL:[NSURL URLWithString:k_URL_APP]];
    [comp setCompletionHandler:^(SLComposeViewControllerResult result) {
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:comp animated:YES completion:nil];
}

- (void)btnSina:(id)sender
{
    SLComposeViewController *comp = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    if (comp == nil) return ;
    [comp setInitialText:@""];
    UIImage *imgSend = [self convertImage];
    [comp addImage:imgSend];
    [comp addURL:[NSURL URLWithString:k_URL_APP]];
    [comp setCompletionHandler:^(SLComposeViewControllerResult result) {
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self presentViewController:comp animated:YES completion:nil];
}


@end
