//
//  GlassImageView.h
//  LiveBlur
//
//  Created by HalloWorld on 14-6-27.
//  Copyright (c) 2014年 Alex Usbergo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlassImageView : UIImageView
{
    CGContextRef myContext;
}

- (id)initWithImage:(UIImage *)image;


@end
