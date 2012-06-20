/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  Cluster.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "Cluster.h"


@implementation Cluster

@synthesize style;
@synthesize radius;
@synthesize shadow;
@synthesize color;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    //clear the background
//    CGContextSetBlendMode(context,kCGBlendModeClear);
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextAddRect(context, CGRectMake(0, 0, 20, 20));      
//    CGContextStrokePath(context);
    

    CGContextSetFillColorWithColor(context, color.CGColor);
    
    float _width=CGRectGetWidth(rect);
    float _height=CGRectGetHeight(rect);
    
    switch (style) {
        case 1:
            CGContextFillEllipseInRect(context, CGRectMake(0, 0, radius, radius));
            break;
            
        case 2:
            CGContextFillRect(context, CGRectMake(0, 0, _width, _height));
            break;
    }
    
    
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
