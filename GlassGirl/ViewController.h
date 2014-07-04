//
//  ViewController.h
//  GlassGirl
//
//  Created by HalloWorld on 14-6-27.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (retain, nonatomic) IBOutlet iCarousel *coverFlow;

@property (retain, nonatomic) NSArray *imageArray;

@end
