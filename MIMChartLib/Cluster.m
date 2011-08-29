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
//  Cluster.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
    [super dealloc];
}

@end
