//
//  GlassImageView.m
//  LiveBlur
//
//  Created by HalloWorld on 14-6-27.
//  Copyright (c) 2014年 Alex Usbergo. All rights reserved.
//

#import "GlassImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GlassImageView

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        // Initialization code
        self.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/2);
        self.multipleTouchEnabled = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    [self clearFrom:lastPoint to:currentPoint];
}


- (void)clearFrom:(CGPoint)pFrom to:(CGPoint)pTo
{
    int perDis = 10;
    CGPoint pd = CGPointMake(pTo.x - pFrom.x, pTo.y - pFrom.y);
    int dis = (int)sqrt((int)pd.x * (int)pd.x + (int)pd.y * (int)pd.y);
    int count = (int) (dis / perDis);
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:self.bounds];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < count; i ++) {
        CGFloat widthAdd = pd.x / count;
        CGFloat heightAdd = pd.y / count;
        CGPoint nextPoint = CGPointMake(pFrom.x + widthAdd, pFrom.y + heightAdd);
        [self paintOnPoint:nextPoint onContext:&context];
    }
    [self paintOnPoint:pTo onContext:&context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = img;
}

- (void)paintOnPoint:(CGPoint)p onContext:(CGContextRef *)context
{
    CGRect cirleRect = CGRectMake(p.x-20, p.y-20, 40, 40);
    CGContextAddArc(*context, p.x, p.y, 20, 0.0, 2*M_PI, 0);
    CGContextClip(*context);
    CGContextClearRect(*context,cirleRect);
}

@end
