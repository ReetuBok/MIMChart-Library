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
@synthesize xElements,scalingFactor,style,lineChart,xIsString;
@synthesize barChart,gapDistance,lineColor,lineWidth;
@synthesize properties,groupTitles,groupTitleOffset;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        _tileWidth=50;
        _gridWidth=self.frame.size.width-20;
        groupTitleOffset=50;

    }
    return self;
}



-(void)setVariables
{

    if([xElements count]==0)
        return;
    
    
    //LineColor
    MIMColorClass *c=[MIMColorClass colorWithRed:0.7 Green:0.7 Blue:0.7 Alpha:1.0];
    if([properties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[properties valueForKey:@"color"]];
    lineColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    
    c=[MIMColorClass colorWithRed:0.7 Green:0.7 Blue:0.7 Alpha:1.0];
    if([properties valueForKey:@"groupTitleColor"]) 
        c=[MIMColorClass colorWithComponent:[properties valueForKey:@"groupTitleColor"]];
    groupTitleColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    
    c=[MIMColorClass colorWithRed:0.7 Green:0.7 Blue:0.7 Alpha:0];
    if([properties valueForKey:@"groupTitleBgColor"]) 
        c=[MIMColorClass colorWithComponent:[properties valueForKey:@"groupTitleBgColor"]];
    groupTitleBgColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    
    
    //Width
    lineWidth=0.1;
    if([properties valueForKey:@"width"]) 
        lineWidth=[[properties valueForKey:@"width"] floatValue];
    if(lineWidth==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    style=X_TITLES_STYLE1;
    if([properties valueForKey:@"style"]) 
        style=[[properties valueForKey:@"style"] intValue];
    
    
    
    lineChart=FALSE;
    if([properties valueForKey:@"linechart"]) 
        lineChart=[[properties valueForKey:@"linechart"] boolValue];
    
    
    barChart=FALSE;
    if([properties valueForKey:@"barchart"]) 
        barChart=[[properties valueForKey:@"barchart"] boolValue];
    
    xIsString=TRUE;
    if([properties valueForKey:@"xisstring"]) 
        xIsString=[[properties valueForKey:@"xisstring"] boolValue];
    
    if([properties valueForKey:@"xscaling"]) 
        scalingFactor=[[properties valueForKey:@"xscaling"] floatValue];
    
    if([properties valueForKey:@"gapBetweenBars"]) 
        gapDistance=[[properties valueForKey:@"gapBetweenBars"] floatValue];
    
    if([properties valueForKey:@"gapBetweenGroup"]) 
        groupGapDistance=[[properties valueForKey:@"gapBetweenGroup"] floatValue];

    
    groupBarChart=FALSE;
    if([properties valueForKey:@"groupedBars"]) 
        groupBarChart=[[properties valueForKey:@"groupedBars"] boolValue];
    
    stackedBarChart=FALSE;
    if([properties valueForKey:@"stackedBars"]) 
        stackedBarChart=[[properties valueForKey:@"stackedBars"] boolValue];
    
}





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    [self setVariables];
    

    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);

    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    //Clear the color of background
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextAddRect(ctx, r);      
    CGContextFillPath(ctx);
    
    
    
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);
    //Draw Gray Lines for X-axis
    [self drawXAxis:ctx];
    
    BOOL xLabelsVisible=FALSE;
    if([properties valueForKey:@"hide"]) 
        xLabelsVisible=[[properties valueForKey:@"hide"] boolValue];
    
    if(xLabelsVisible)
        return;
    
    
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
    else if(barChart)
    {
        
        
        
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
    
    
    
    
    
    if(barChart && groupBarChart)
    {

        
        float offset=scalingFactor;
        for (int i=0; i<[xElements count]; i++) 
        {
         
            for(int j=0;j<[[xElements objectAtIndex:i] count];j++)
            {
                XAxisLabel *label;
                int v;
                
                
                if(xIsString) v=i;
                else v=[[[xElements objectAtIndex:i] objectAtIndex:j] intValue];
                
                
                if(style==3){
                    
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset, 0, scalingFactor, 15.0)];
                    label.style=5;label.width=scalingFactor;
                }
                if(style ==1)
                {
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset+(0.4*scalingFactor) , 0, 50, 15.0)];
                    label.style=1;
                    label.width=50;
                }
                
                
                
                if(j<[[xElements objectAtIndex:i] count]-1)
                    offset+=gapDistance;

                
                offset+=scalingFactor;
                
                label.lineChart=lineChart;
                label.text=[NSString stringWithFormat:@"%@",[[xElements objectAtIndex:i] objectAtIndex:j]];
                
                [label drawTitleWithColor:lineColor];
                [self addSubview:label];
            }
            
            offset+=groupGapDistance;
        
        }
            
            
        
        
    
        
    
    }
    else if(barChart && stackedBarChart)
    {
        float offset=scalingFactor;
        for (int i=0; i<[xElements count]; i++) 
        {
            
           
            
                XAxisLabel *label;
                int v;
                
                
                if(xIsString) v=i;
                else v=[[xElements objectAtIndex:i] intValue];
                
                
                if(style==3){
                    
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset, 0, scalingFactor, 15.0)];
                    label.style=5;
                    label.width=scalingFactor;
                }
                if(style ==1)
                {
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset+(0.4*scalingFactor) , 0, 50, 15.0)];
                    label.style=1;
                    label.width=50;
                }
                if(style ==2)
                {
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset+(0.1*scalingFactor) , 0, 50, 15.0)];
                    label.style=2;
                    label.width=50;
                }

       
            
                offset+=scalingFactor;
                
                label.lineChart=lineChart;
                label.text=[NSString stringWithFormat:@"%@",[xElements objectAtIndex:i]];
                
                [label drawTitleWithColor:lineColor];
                [self addSubview:label];
            
                offset+=groupGapDistance;
        }
            
           
            
    
        
        
    }
    else
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
        else if(barChart)
            offset=0;
        else
            offset=(scalingFactor * 0.8)/2;  
         
        if(barChart)
        {
            switch (style) 
            {
                case 1:
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake((v*scalingFactor) +(0.3*scalingFactor) +  ((v+1) *gapDistance), 0, scalingFactor+gapDistance, 15.0)];
                    label.style=self.style;
                    break;
                case 2:
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor+  ((v+1) *gapDistance), 0, scalingFactor+gapDistance, 15.0)];
                    label.style=self.style;
                    break;
                case 3:
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake((v*scalingFactor) +  ((v+1) *gapDistance), 10, scalingFactor+gapDistance, 15.0)];
                    label.style=5;
                    break;
                    
                case 4:
                    label=[[XAxisLabel alloc]initWithFrame:CGRectMake(v*scalingFactor+ (scalingFactor * 0.8)/2, 5, gapDistance, 15.0)];
                    label.style=self.style;
                    break;
            }
        }
        else
        {
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
            
            label.style=self.style;
        }
        
        
        label.lineChart=lineChart;
        label.text=[NSString stringWithFormat:@"%@",[xElements objectAtIndex:i]];

        label.width=scalingFactor;
        [label drawTitleWithColor:lineColor];
        [self addSubview:label];
        
  
        
    }
    
    
    
    //Group Titles
    if(!groupBarChart)return;
    
    float offset=scalingFactor;
    for (int i=0; i<[groupTitles count]; i++) 
    {
        XAxisLabel *label=[[XAxisLabel alloc]initWithFrame:CGRectMake(offset, 40, scalingFactor, 15.0)];
        label.style=5;
        
        for(int j=0;j<[[xElements objectAtIndex:i] count];j++)
        {
            if(j<[[xElements objectAtIndex:i] count]-1)
                offset+=gapDistance;
               
            offset+=scalingFactor;
        
        }
        
        //Resize the width of group title label
        CGRect r=label.frame;
        r.size.width=offset-CGRectGetMinX(r);
        label.frame=r;

        
        label.lineChart=lineChart;
        label.width=CGRectGetWidth(r);
        label.mBackgroundColor=groupTitleBgColor;
        
        label.text=[NSString stringWithFormat:@"%@",[groupTitles objectAtIndex:i]];
        [label drawTitleWithColor:groupTitleColor];
        
        [self addSubview:label];
        
        
        offset+=groupGapDistance;
        
    }
    
    
    
 
}

-(void)drawXAxis:(CGContextRef)ctx
{
    
    if(lineWidth<1) lineWidth=1;
    
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
