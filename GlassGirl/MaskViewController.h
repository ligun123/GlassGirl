//
//  MaskViewController.h
//  GlassGirl
//
//  Created by HalloWorld on 14-7-4.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageMaskView.h"

@interface MaskViewController : UIViewController
{
    BOOL isToolbarHidden;
}

@property (weak, nonatomic) IBOutlet UIImageView *srcImageView;

@property (copy, nonatomic) NSString *srcImgName;

@property (strong, nonatomic) NSTimer *toolTimer;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
