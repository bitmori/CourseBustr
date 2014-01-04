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
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //self.backgroundColor
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect newrect = CGRectMake(1,1,rect.size.width-2,rect.size.height-2);
    UIColor * color = [self titleColorForState:UIControlStateNormal];
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextBeginPath(ctx);
    CGContextAddEllipseInRect(ctx, newrect);
    
    CGContextDrawPath(ctx, kCGPathFill);
}

@end
