//
//  GlassView.m
//  GlassGirl
//
//  Created by HalloWorld on 14-6-30.
//  Copyright (c) 2014年 HalloWorld. All rights reserved.
//

#import "GlassView.h"

@implementation GlassView

- (id)initWithImage:(UIImage *)image
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    self = [super initWithFrame:CGRectMake(0, 0, width / 2, height / 2)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //code init
        self.originImage = image;
        [self setNeedsDisplay];
    }
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (CGRectEqualToRect(rect, self.bounds)) {
        [self.originImage drawInRect:rect];
        return ;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGImageRef ori = self.originImage.CGImage;
    CGRect scaleRect = CGRectMake(rect.origin.x * 2, rect.origin.y * 2, rect.size.height * 2, rect.size.width * 2);
    CGImageRef img = CGImageCreateWithImageInRect(ori, scaleRect);
    UIImage *imgge = [UIImage imageWithCGImage:img];
    [imgge drawInRect:rect];
    
    /*
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextSetLineWidth(context, 10.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    CGContextStrokePath(context);
     */
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    CGContextClearRect(context, rect);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint lastPoint = CGPointMake(currentPoint.x-60, currentPoint.y-60);
    CGRect r = CGRectMake(lastPoint.x, lastPoint.y, currentPoint.x - lastPoint.x, currentPoint.y - lastPoint.y);
    [self setNeedsDisplayInRect:r];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    /*
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint lastPoint = [touch previousLocationInView:self];
    CGRect r = CGRectMake(lastPoint.x, lastPoint.y, currentPoint.x - lastPoint.x, currentPoint.y - lastPoint.y);
    NSLog(@"%s -> %@", __FUNCTION__, NSStringFromCGRect(r));
    [self setNeedsDisplayInRect:r];
     */
}


@end
