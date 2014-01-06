//
//  CBCircleButton.m
//  courseBustr
//
//  Created by Ke Yang on 12/30/13.
//  Copyright (c) 2013 Pyrus. All rights reserved.
//

#import "CBCircleButton.h"

@implementation CBCircleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect newrect = CGRectMake(3,3,rect.size.width-6,rect.size.height-6);
    UIColor * color = [self titleColorForState:UIControlStateNormal];
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, newrect);
    
    CGContextDrawPath(ctx, kCGPathFill);
    if (!self.isEnabled) {
        //[UIColor colorWithWhite:0.1f alpha:1.0f].CGColor
        //CGContextSetFillColorWithColor(ctx, color.CGColor);
        CGContextSetStrokeColorWithColor(ctx, color.CGColor);
        CGContextBeginPath(ctx);
        //CGContextAddEllipseInRect(ctx, CGRectMake(5, 5, 5, 5));
        CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2));
        CGContextDrawPath(ctx, kCGPathStroke);
    }
}

@end
