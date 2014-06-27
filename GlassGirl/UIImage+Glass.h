//
//  UIImage+Glass.h
//  LiveBlur
//
//  Created by HalloWorld on 14-6-27.
//  Copyright (c) 2014年 Alex Usbergo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Glass)


- (UIImage *)glassImage;

/**
 *  返回一个毛玻璃效果
 *
 *  @param level 等级值范围0~1.0
 */
- (UIImage *)glassImageWithLevel:(CGFloat)level;

@end
