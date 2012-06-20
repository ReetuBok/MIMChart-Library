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
//  LineInfoBox.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "LineInfoBox.h"


@implementation LineInfoBox
@synthesize lineArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createColorArray];
    }
    return self;
}

-(void)createColorArray
{
    colorArray=[[NSMutableArray alloc]init];
    
    [colorArray addObject:[UIColor redColor]];
    [colorArray addObject:[UIColor greenColor]];
    [colorArray addObject:[UIColor blueColor]];
    [colorArray addObject:[UIColor yellowColor]];
    [colorArray addObject:[UIColor magentaColor]];
    [colorArray addObject:[UIColor darkGrayColor]];
    [colorArray addObject:[UIColor orangeColor]];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context,kCGBlendModeNormal);

    
    // Drawing code
    for (int i=0; i<[lineArray count]; i++) {
        
        //Draw the line
        UIColor *lineColor=[colorArray objectAtIndex:i];
        CGContextSetFillColorWithColor(context, lineColor.CGColor);
        CGContextAddRect(context, CGRectMake(5, 30* i + 10, 20, 10));  
        CGContextFillPath(context);
        
        
        //Stick the Label
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 30* i, 200, 30)];
        [label setText:[lineArray objectAtIndex:i]];
        [label setBackgroundColor:[UIColor blackColor]];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [label setTextColor:[UIColor whiteColor]];
        [self addSubview:label];
    }
    
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
