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
@synthesize color,borderColor,lColor,dColor,isGradient,gradientStyle,glossStyle,negativeBar;
@synthesize delegate;
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
    int height=self.frame.size.height;
    float red,green,blue,alpha,Dred,Dgreen,Dblue,DAlpha;

 
    
    
    if (isGradient) 
    {
        
        Dred=[[dColor valueForKey:@"red"] floatValue];
        Dgreen=[[dColor valueForKey:@"green"] floatValue];
        Dblue=[[dColor valueForKey:@"blue"] floatValue];
        if([dColor valueForKey:@"alpha"]) DAlpha=[[dColor valueForKey:@"alpha"] floatValue];
        else DAlpha=1.0;
        
        if(lColor==nil)
        {
            UIColor *_color=[[UIColor alloc]initWithRed:Dred green:Dgreen blue:Dblue alpha:1.0]; 
            CGContextSetFillColorWithColor(context, _color.CGColor);
            CGContextAddRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));  
            CGContextFillPath(context);
  
            if(gradientStyle==VERTICAL_GRADIENT_STYLE)
            {
                Dred=0;
                Dgreen=0;
                Dblue=0;
                DAlpha=0.1;
                
                
                red=1.0;
                green=1.0;
                blue=1.0;
                alpha=0.5;
            
            }
            else
            {
                Dred=1.0;
                Dgreen=1.0;
                Dblue=1.0;
                DAlpha=0.5;
                
                red=0.0;
                green=0.0;
                blue=0.0;
                alpha=0.1;
            }
            
            
           
            
            
        }
        else
        {
            red=[[lColor valueForKey:@"red"] floatValue];
            green=[[lColor valueForKey:@"green"] floatValue];
            blue=[[lColor valueForKey:@"blue"] floatValue];
            if([lColor valueForKey:@"alpha"]) alpha=[[lColor valueForKey:@"alpha"] floatValue];
            else alpha=1.0;
        }
        
        
        
        
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { red, green, blue, alpha,  // Start color
            Dred, Dgreen, Dblue, DAlpha }; // Mid color and End color
        
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        
       
        
        CGRect myrect = CGRectMake(0,0,CGRectGetWidth(rect), height);
        CGContextSaveGState(context);
        CGContextClipToRect(context, myrect);
        
        
        
        if(gradientStyle==HORIZONTAL_GRADIENT_STYLE)
        {
            CGPoint start = CGPointMake(0,0); 
            CGPoint end = CGPointMake(CGRectGetWidth(rect), 0);
            CGContextDrawLinearGradient(context, glossGradient, end, start, kCGGradientDrawsBeforeStartLocation);
        }
        else if(gradientStyle==HORIZONTAL_GRADIENT_STYLE_2)
        {
            CGPoint start = CGPointMake(0,0); 
            CGPoint end = CGPointMake(CGRectGetWidth(rect), 0);
            CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
        }
        else if(gradientStyle==VERTICAL_GRADIENT_STYLE || gradientStyle ==VERTICAL_GRADIENT_STYLE_2)
        {
            if(negativeBar)
            {
                CGPoint start = CGPointMake(CGRectGetWidth(rect),-5); 
                CGPoint end = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)+10);
                CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
            }
            else
            {
                CGPoint start = CGPointMake(CGRectGetWidth(rect),CGRectGetHeight(rect)); 
                CGPoint end = CGPointMake(CGRectGetWidth(rect), -5);
                CGContextDrawLinearGradient(context, glossGradient, start, end, 0);
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
       
 
    
    
    
    
    
    if(glossStyle!=GLOSS_NONE)
    {
        Dred=1.0;
        Dgreen=1.0;
        Dblue=1.0;
        DAlpha=0.5;
        
        
        red=1.0;
        green=1.0;
        blue=1.0;
        alpha=0.05;
        
        switch (glossStyle) 
        {
            case GLOSS_STYLE_1:
            default:
            {
                CGContextSaveGState(context);
                
                
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, height);
                CGPathAddCurveToPoint(path, NULL, 0, height,CGRectGetWidth(rect)/2 ,height/5, CGRectGetWidth(rect),  height/10);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
                
            case GLOSS_STYLE_2:
            {
                CGContextSaveGState(context);
            
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, height*0.6);
                
                CGPathAddQuadCurveToPoint(path, NULL, CGRectGetWidth(rect)*0.5, height*0.55, CGRectGetWidth(rect), height*0.4);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
        }
        
        
        
        //DRaw the gloss gradient
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { red, green, blue, alpha,  // Start color
            Dred, Dgreen, Dblue, DAlpha }; // Mid color and End color
        
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        CGPoint start = CGPointMake(CGRectGetWidth(rect),CGRectGetHeight(rect)*0.7); 
        CGPoint end = CGPointMake(CGRectGetWidth(rect), -5);
        CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
 

        CGContextRestoreGState(context);
        

    }
    
    
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Display the bar floating info view
    NSLog(@"bar touched");
    [delegate displayFloatingView:self];
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
