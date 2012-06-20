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
//  XAxisBand.m
//  MIM2D Library
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "XAxisBand.h"
#import "XAxisLabel.h"

@implementation XAxisBand
@synthesize xElements,multipleOf,scalingFactor,style,lineChart,xIsString;
@synthesize lineColor,lineWidth;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        _tileWidth=50;
        _gridWidth=self.frame.size.width-20;

    }
    return self;
}







// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    if([xElements count]==0)
        return;
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);

    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    //Draw Gray Lines for X-axis
    [self drawXAxis:ctx];
    
    
    //Draw the sticks down
    if(lineChart)
    {
        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
        CGContextSetLineWidth(ctx, lineWidth);
        CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
        for (int i=0; i<[xElements count]; i++) {
            
            if(xIsString)
            {
                CGContextMoveToPoint(ctx,i*scalingFactor,self.frame.size.height);
                CGContextAddLineToPoint(ctx,i*scalingFactor, self.frame.size.height-5);
            }
            else
            {
                CGContextMoveToPoint(ctx,[[xElements objectAtIndex:i]intValue]*scalingFactor,self.frame.size.height);
                CGContextAddLineToPoint(ctx,[[xElements objectAtIndex:i]intValue]*scalingFactor, self.frame.size.height-5);
            }
           
        }
        CGContextDrawPath(ctx, kCGPathStroke);
    
    }
    else
    {
        CGContextSetLineWidth(ctx, lineWidth);
        for (int i=0; i<[xElements count]; i++) {
            
            CGContextMoveToPoint(ctx,i*scalingFactor+ (scalingFactor * 0.8)/2,self.frame.size.height);
            CGContextAddLineToPoint(ctx,i*scalingFactor + (scalingFactor* 0.8)/2, self.frame.size.height-5);
        }
        CGContextDrawPath(ctx, kCGPathStroke);
    
    
    }
    
    
    
    //draw the labels
    for (int i=0; i<[xElements count]; i++) 
    {
        
        XAxisLabel *label;
        int v;
        
        
        if(xIsString) v=i;
        else v=[[xElements objectAtIndex:i]intValue];

            
        
        float offset=(scalingFactor * 0.8)/2;
        
        if(lineChart)
            offset=0;
        else
            offset=(scalingFactor * 0.8)/2;  
            
        switch (style) {
            case 1:
                label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor+ offset, 0, scalingFactor, 15.0)];
                break;
            case 2:
                label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor, 0, scalingFactor, 15.0)];
                break;
            case 3:
                label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor-10+ offset, 10, scalingFactor, 15.0)];
                break;
                
            case 4:
                label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor+ (scalingFactor * 0.8)/2, 5, scalingFactor, 15.0)];
                break;
        }
        
        label.lineChart=lineChart;
        label.text=[NSString stringWithFormat:@"%@",[xElements objectAtIndex:i]];
        label.style=self.style;
        label.width=scalingFactor;
        [label drawTitleWithColor:lineColor];
        [self addSubview:label];
        
  
        
    }
 
}

-(void)drawXAxis:(CGContextRef)ctx
{

    if(lineWidth < 1)
        lineWidth=1.0;
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, 0,self.frame.size.height);
    CGContextAddLineToPoint(ctx,self.frame.size.width, self.frame.size.height);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}



- (void)dealloc
{
    ////[super dealloc];
}

@end
