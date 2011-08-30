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
//  LineInfoBox.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
    [super dealloc];
}

@end
