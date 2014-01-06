//
//  CBCircleButtonWithLabel.m
//  courseBustr
//
//  Created by Ke Yang on 1/5/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBCircleButtonWithLabel.h"

@implementation CBCircleButtonWithLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIColor * color = [self titleColorForState:UIControlStateNormal];
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 6, 6);
    CGContextAddLineToPoint(ctx, rect.size.width-6, rect.size.height-6);
//    CGContextMoveToPoint(ctx, rect.size.width-6, 6);
//    CGContextAddLineToPoint(ctx, 6, rect.size.height-6);
    CGContextAddEllipseInRect(ctx, CGRectMake(4, 4, rect.size.width-8, rect.size.height-8));
    CGContextDrawPath(ctx, kCGPathStroke);
    if (!self.isEnabled) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2));
        CGContextDrawPath(ctx, kCGPathStroke);
    }
}

@end
