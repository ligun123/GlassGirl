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
#import "ImageManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.imageArray = [[ImageManager shareManager] resourceImages];
    self.coverFlow.delegate = self;
    self.coverFlow.dataSource = self;
    self.coverFlow.type = iCarouselTypeCoverFlow;
    
    /*
    UIImage *tmp = [UIImage imageNamed:@"test.jpg"];
    UIImage *fish = [tmp glassImage];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:tmp];
    imgview.frame = CGRectMake(0, 0, imgview.frame.size.width /2, imgview.frame.size.height /2);
    [self.view addSubview:imgview];
    
    ImageMaskView *glass = [[ImageMaskView alloc] initWithFrame:imgview.frame image:fish];
    [self.view addSubview:glass];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cover Flow Delegate

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.imageArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    NSString *imgRes = self.imageArray[index];
    UIImage *oriImg = [[ImageManager shareManager] imageOfName:imgRes];
    UIView *view = [[UIImageView alloc] initWithImage:oriImg];
    
    view.frame = CGRectMake(70, 80, 213, 320);
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.coverFlow.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.coverFlow.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (carousel.currentItemIndex == index) {
        //开始擦玻璃
    }
}

@end
