//
//  ImageEditViewController.h
//  GlassGirl
//
//  Created by HalloWorld on 14-7-17.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditViewController : UIViewController <UIScrollViewDelegate>
{
    float scaleResult;
}

@property (strong, nonatomic) UIImage *originalImage;

@property (weak, nonatomic) IBOutlet UIScrollView *rootScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)btnCancelTap:(id)sender;

- (IBAction)btnDoneTap:(id)sender;

@end
