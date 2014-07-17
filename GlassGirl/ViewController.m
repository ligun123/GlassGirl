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
#import "MaskViewController.h"
#import "ImageEditViewController.h"

#define k_Tag_Delete_Begin 1000

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCover) name:k_Name_Add_New_Pic object:nil];
    
    self.imageArray = [[ImageManager shareManager] resourceImages];
    self.coverFlow.delegate = self;
    self.coverFlow.dataSource = self;
    self.coverFlow.type = iCarouselTypeCoverFlow;
    
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GreenBack@2x.jpg"]];
    backImg.frame = self.view.bounds;
    [self.view insertSubview:backImg belowSubview:self.coverFlow];
    
    UIButton *photoPick = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect f = self.view.frame;
    photoPick.frame = CGRectMake(f.size.width/2 - 76, f.size.height - 56, 152, 36);
    [photoPick setBackgroundImage:[UIImage imageNamed:@"btnSavePlay@2x.png"] forState:UIControlStateNormal];
    [photoPick setTitle:NSLocalizedString(@"Album", nil) forState:UIControlStateNormal];
    [photoPick addTarget:self action:@selector(showPhotoPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoPick];
    
    UILabel *notiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 20, self.view.bounds.size.width, 20)];
    [self.view addSubview:notiLabel];
    notiLabel.backgroundColor = [UIColor clearColor];
    notiLabel.textColor = [UIColor orangeColor];
    notiLabel.font = [UIFont systemFontOfSize:13.f];
    notiLabel.textAlignment = 1;
    notiLabel.text = NSLocalizedString(@"LongTapOnPicToDelete", nil);
}


- (void)reloadCover
{
    self.imageArray = [[ImageManager shareManager] resourceImages];
    [self.coverFlow reloadData];
}


- (void)showPhotoPicker:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *oriImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%s -> %@", __FUNCTION__, NSStringFromCGSize(oriImage.size));
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageEditViewController *edit = [board instantiateViewControllerWithIdentifier:@"ImageEditViewController"];
    edit.originalImage = oriImage;
    [picker pushViewController:edit animated:NO];
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

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIView *view = [gesture view];
        NSInteger index =  [self.coverFlow indexOfItemView:view];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"DeleteSure", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"NO", nil) otherButtonTitles:NSLocalizedString(@"YES", nil), nil];
        alert.tag = k_Tag_Delete_Begin + index;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag >= k_Tag_Delete_Begin && buttonIndex == 1) {
        NSInteger index = alertView.tag - k_Tag_Delete_Begin;
        NSString *name = self.imageArray[index];
        [[ImageManager shareManager] removeItem:name];
        self.imageArray = [[ImageManager shareManager] resourceImages];
        [self.coverFlow removeItemAtIndex:index animated:YES];
    }
}

#pragma mark - Cover Flow Delegate

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.imageArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    NSString *imgRes = self.imageArray[index];
    UIImage *oriImg = [[ImageManager shareManager] glassImageOfName:imgRes];
    UIView *view = [[UIImageView alloc] initWithImage:oriImg];
    view.frame = CGRectMake(70, 80, 213, 320);
    
    //添加长按删除手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [view addGestureRecognizer:longPress];
    longPress.minimumPressDuration = 1.2;
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
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MaskViewController *mask = [story instantiateViewControllerWithIdentifier:@"MaskViewController"];
        mask.srcImgName = self.imageArray[index];
        [self presentViewController:mask animated:YES completion:nil];
    }
}

@end
