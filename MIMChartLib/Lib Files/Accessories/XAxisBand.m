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
//  XAxisBand.m
//  MIM3D
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XAxisBand.h"
#import "XAxisLabel.h"

@implementation XAxisBand
@synthesize xElements,multipleOf,scalingFactor,style,lineChart,xIsString;


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


-(void)readTitleFromCSV:(NSString*)path AtColumn:(int)column
{
    
    if(column==-1)
    {
        //Its a lines Graph
        xElements=[[NSMutableArray alloc]init];
        
        NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
        
        int k=0;
        for (id string in linesArray)
            if(k<[linesArray count]-1){
                
                NSString *lineString=[linesArray objectAtIndex:k];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                [xElements addObject:[columnArray objectAtIndex:0]];
                k++;
                
            }
        
        
        
    }
    else
    {
        xElements=[[NSMutableArray alloc]init];
        
        
        NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
        
        
        int k=0;
        for (id string in linesArray)
            if(k<[linesArray count]-1){
                
                NSString *lineString=[linesArray objectAtIndex:k];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                [xElements addObject:[columnArray objectAtIndex:column]];
                k++;
                
            }
        
        
    }
    
    
    
    [xElements removeObjectAtIndex:0];
    
}


/*This method is needed when the all the x-axis element are numbers/ints*/
-(void)readTitleFromCSV:(NSString*)path
{
        xElements=[[NSMutableArray alloc]init];
        
        
        NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
        
        for (int k=1; k<[linesArray count]-1; k++) {
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [xElements addObject:[columnArray objectAtIndex:0]];
        }
        
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    //Draw Gray Lines for X-axis
    [self drawXAxis:ctx];
    
    
    //Draw the sticks down
    if(lineChart)
    {
        CGContextSetLineWidth(ctx, 2.0);
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
        CGContextSetLineWidth(ctx, 2.0);
        for (int i=0; i<[xElements count]; i++) {
            
            CGContextMoveToPoint(ctx,i*scalingFactor+ (scalingFactor * 0.8)/2,self.frame.size.height);
            CGContextAddLineToPoint(ctx,i*scalingFactor + (scalingFactor* 0.8)/2, self.frame.size.height-5);
        }
        CGContextDrawPath(ctx, kCGPathStroke);
    
    
    }
    
    
    
    
    for (int i=0; i<[xElements count]; i++) {
        
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
        [label setNeedsDisplay];
        [self addSubview:label];
        
  
        
    }
 
}

-(void)drawXAxis:(CGContextRef)ctx
{

    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8].CGColor);
    CGContextSetLineWidth(ctx, 1.6);
    CGContextMoveToPoint(ctx, 0,self.frame.size.height);
    CGContextAddLineToPoint(ctx,self.frame.size.width, self.frame.size.height);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}



- (void)dealloc
{
    [super dealloc];
}

@end
