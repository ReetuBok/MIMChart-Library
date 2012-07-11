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
 */
//
//  BarView.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "BarView.h"


@implementation BarView
@synthesize color,borderColor,lColor,dColor,isGradient,gradientStyle,negativeBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    
 
    
    
    if (isGradient) 
    {
        
        
        float red=[[lColor valueForKey:@"red"] floatValue];
        float green=[[lColor valueForKey:@"green"] floatValue];
        float blue=[[lColor valueForKey:@"blue"] floatValue];
        
        float Dred=[[dColor valueForKey:@"red"] floatValue];
        float Dgreen=[[dColor valueForKey:@"green"] floatValue];
        float Dblue=[[dColor valueForKey:@"blue"] floatValue];
        
        
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { red, green, blue, 1.0,  // Start color
            Dred, Dgreen, Dblue, 1.0 }; // Mid color and End color
        
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        int height=self.frame.size.height;
        CGRect myrect = CGRectMake(0,0,CGRectGetWidth(rect), height);
        CGContextSaveGState(context);
        CGContextClipToRect(context, myrect);
        
        if(gradientStyle==HORIZONTAL_GRADIENT_STYLE)
        {
            CGPoint start = CGPointMake(0,0); 
            CGPoint end = CGPointMake(CGRectGetWidth(rect), 0);
            CGContextDrawLinearGradient(context, glossGradient, end, start, kCGGradientDrawsBeforeStartLocation);
        }
        else if(gradientStyle==VERTICAL_GRADIENT_STYLE)
        {
            if(negativeBar)
            {
                CGPoint start = CGPointMake(CGRectGetWidth(rect),-5); 
                CGPoint end = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)+10);
                CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
            }
            else
            {
                CGPoint start = CGPointMake(CGRectGetWidth(rect),CGRectGetHeight(rect)+10); 
                CGPoint end = CGPointMake(CGRectGetWidth(rect), -5);
                CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
            }
            
        }
        
        CGContextRestoreGState(context);
        
        

        
        
    }
    else
    {
        
        UIColor *_color=[[UIColor alloc]initWithRed:color.red green:color.green blue:color.blue alpha:color.alpha]; 
        CGContextSetFillColorWithColor(context, _color.CGColor);
        CGContextAddRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));  
        CGContextFillPath(context);
    
    }
       
    
    //Set BorderLin
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
//    CGContextAddRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)+4));  
//    CGContextStrokePath(context);

}


- (void)dealloc
{
    ////[super dealloc];
}

@end
