/*
 Copyright (C) 2011  Reetu Raj (reetu.raj@gmail.com)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *///
//  FragmentedBar.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FragmentedBar.h"


@implementation FragmentedBar
@synthesize lColor;
@synthesize dColor; 


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawBarWithColor:(NSDictionary *)color
{
    lColor=color;
    isGradient=NO;
    [self setNeedsDisplay];
}


-(void)drawBarWithGradientColor:(NSDictionary *)color And:(NSDictionary *)dcolor
{
    
    lColor=color;
    dColor=dcolor;
    isGradient=YES;
    [self setNeedsDisplay];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    
    
    // Drawing code
    if(isGradient)
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
        CGRect myrect = CGRectMake(0,0,CGRectGetWidth(rect), CGRectGetHeight(rect));
        CGContextSaveGState(context);
        CGContextClipToRect(context, myrect);
        CGPoint start = CGPointMake(0,0); 
        CGPoint end = CGPointMake(CGRectGetWidth(rect), 0);
        CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
        CGContextRestoreGState(context);
        
        
    
    }
    else
    {
    
        float red=[[lColor valueForKey:@"red"] floatValue];
        float green=[[lColor valueForKey:@"green"] floatValue];
        float blue=[[lColor valueForKey:@"blue"] floatValue];
        
        UIColor *myColor=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0];
        
        //Draw the bar
        CGContextSetFillColorWithColor(context, myColor.CGColor);
        CGContextAddRect(context, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));  
        CGContextFillPath(context);

    
    }
}


- (void)dealloc
{
    [super dealloc];
}

@end
