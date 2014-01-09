//
//  CBUserRoundImage.m
//  courseBustr
//
//  Created by Ke Yang on 1/8/14.
//  Copyright (c) 2014 Pyrus. All rights reserved.
//

#import "CBUserRoundImage.h"

@implementation CBUserRoundImage

@synthesize image = _image;
@synthesize bgimage = _bgimage;
@synthesize imgOffset = _imgOffset;


- (void)setImage:(UIImage *)image
{
    self.backgroundColor = [UIColor clearColor];
    _image = image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgimage = [UIImage imageNamed:@"user_profile_circle.png"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.bgimage drawInRect:self.bounds];
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(c);
    
    CGRect clipRect = CGRectMake(self.imgOffset, self.imgOffset, self.frame.size.width-(self.imgOffset*2), self.frame.size.width-(self.imgOffset*2));
    
    CGContextAddEllipseInRect(c, clipRect);
    CGContextClip(c);
    CGContextClearRect(c, clipRect);
    
    [self.image drawInRect:CGRectMake(clipRect.origin.x, clipRect.origin.y, clipRect.size.width, clipRect.size.height)];

    CGContextRestoreGState(c);
}


@end
