//
//  iPCmyView.m
//  TimeLine
//
//  Created by Udayan Mandavia on 8/13/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import "iPCmyView.h"

@implementation iPCmyView

@synthesize scale;

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
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect bounds = self.bounds;
    bounds.size.width /= scale;
    bounds.size.height /= scale;
    
    CGContextScaleCTM(ctx, scale, scale);
    
    [[UIColor blackColor] set];
    
    CGContextSetLineWidth(ctx, 3);
    CGContextStrokeRect(ctx, CGRectInset(bounds, 1.5*scale, 1.5*scale));
    
    CGContextScaleCTM(ctx, 1.0/scale, 1.0/scale);
    
    [@"Hello!" drawAtPoint:CGPointMake(20,20) withFont:[UIFont systemFontOfSize:8*scale]];
}


@end
