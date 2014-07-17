//
//  ImageManager.h
//  GlassGirl
//
//  Created by HalloWorld on 14-7-4.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

+ (instancetype)shareManager;


/**
 *  返回Image的路径
 */
- (NSArray *)resourceImages;

- (UIImage *)imageOfName:(NSString *)imgName;

- (UIImage *)glassImageOfName:(NSString *)imgName;

- (void)saveNewImage:(UIImage *)origImg;

- (void)removeItem:(NSString *)itemName;

@end
