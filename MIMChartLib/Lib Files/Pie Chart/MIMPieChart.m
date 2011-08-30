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
//  MIMPieChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MIMPieChart.h"
#import "MIMColor.h"

@implementation MIMPieChart
@synthesize radius;
@synthesize backgroundColor;
@synthesize enableBottomTitles;
@synthesize titleArray;
@synthesize tintValue;
@synthesize tint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        
    }
    return self;
}
-(void)readFromCSV:(NSString*)path  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dcolumn
{
    
    valuesReadFromCSV=YES;
    valueArray=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [valueArray addObject:[columnArray objectAtIndex:dcolumn]];
            k++;
            
        }

    
    titleArray=[[NSMutableArray alloc]init];
    

    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [titleArray addObject:[columnArray objectAtIndex:tcolumn]];
            k++;
            
        }
    

}




-(void)initAndWarnings
{
    if(radius==0)
    NSLog(@"WARNING::Radius is 0. Please set some value to radius.");

    if(self.backgroundColor)
        [self setBackgroundColor:backgroundColor];
    else
        [self setBackgroundColor:[UIColor whiteColor]];
    
    
}

-(void)drawPieChart
{
    selectedPie=-99;
    [self initAndWarnings];
    [self findCenter];
    [self drawBottomTitlesText];
    [self setNeedsDisplay];
    
    
    
}


-(void)drawBottomTitlesText
{
    float sum=0;
    for(int i=0;i<[valueArray count];i++)
    {
        
        sum+=[[valueArray objectAtIndex:i] floatValue];
    }


    //Only  text
    for(int i=0;i<[titleArray count];i++)
    {
        
        float percent=([[valueArray objectAtIndex:i] floatValue]/sum)*100;
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(2*radius + 60,i*30+ 25,130,30)];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextAlignment:UITextAlignmentLeft];
        [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [title setTextColor:[UIColor blackColor]];
        [title setText:[NSString stringWithFormat:@"  %@  (%.0f %@)",[titleArray objectAtIndex:i],percent,@"%"]];
        title.tag=1000+i;
        [self addSubview:title];
    }
    
}

-(void)highlightTheTitle
{
    //First remove all the highlights
    for (id view in self.subviews)
    if([view isKindOfClass:[UILabel class]]){

        UILabel *viewLabel=(UILabel *)view;

        [viewLabel.layer setBorderWidth:0.0];
        [viewLabel.layer setShadowOpacity:0];
    }
    
    
    
    UILabel *view=(UILabel *)[self viewWithTag:1000+selectedPie];
    [view.layer setBorderColor:[UIColor grayColor].CGColor];
    [view.layer setBorderWidth:1.0];        
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:5.0];
    [view.layer setShadowRadius:2.0];
    [view.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [view.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    [view.layer setShadowOpacity:0.8];
        
}




-(void)drawBottomTitles:(CGContextRef)context
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    int tintOffset;
    if(tint==REDTINT)
        tintOffset=17;
    if(tint==GREENTINT)
        tintOffset=0;
    if(tint==BEIGETINT)
        tintOffset=30;
    
    
    //Draw the squares ONly
    
    for(int i=0;i<[titleArray count];i++)
    {
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    

        
        //Simple Colored Rect
        CGRect rectangle = CGRectMake(2*radius + 30,i*30+ 30,15,15);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rectangle);
//    
    }
}



- (void)drawRect:(CGRect)rect
{

    
    
    int c=[valueArray count];
    
   // CGFloat angleArray[c];
    angleArrays=[[NSMutableArray alloc]initWithCapacity:c];
    CGFloat offset;
    int sum=0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Draw the background with the gray Gradient
    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
 
    
    CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
    CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.9, 0.9, 0.9 , 1.0,  // Start color
        0.75, 0.75, 0.75 , 1.0 }; // Mid color and End color
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    
    CGPoint startBg = CGPointMake(_viewWidth/2,_viewHeight/2); 
    CGFloat endRadius=MAX(_viewWidth/2, _viewHeight/2);
    
    
    CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    

    int totalColors=[MIMColor sizeOfColorArray];
    
    
    for(int i=0;i<[valueArray count];i++)
    {
        
        sum+=[[valueArray objectAtIndex:i] intValue];
    }
    
    for(int i=0;i<[valueArray count];i++)
    {
        
        float myAngle=(float)(([[valueArray objectAtIndex:i] intValue])/(float)sum)*(2*3.14); // in radians
        [angleArrays addObject:[NSNumber numberWithFloat:myAngle]];
        
        CGContextMoveToPoint(context, _centerX , _centerY);
       
        if(selectedPie==i)
        {
            if(returnBackToOriginalLocation){
            CGContextAddArc(context, _centerX, _centerY, radius,offset,offset+myAngle, 0);
            selectedPie=-99;
            }
            else
            CGContextAddArc(context, _centerX, _centerY, radius+10,offset,offset+myAngle, 0);
                
        
        }
        else
        CGContextAddArc(context, _centerX, _centerY, radius,offset,offset+myAngle, 0);
        
        offset+=myAngle;
        
        int tintOffset;
        if(tint==REDTINT)
            tintOffset=17;
        if(tint==GREENTINT)
            tintOffset=0;
        if(tint==BEIGETINT)
            tintOffset=30;
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    //i+17 brown tint//30 dark colors(like beige)// // total 43
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
        CGContextSetFillColorWithColor(context, color.CGColor);    

    

        
        
        CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 2.0, [UIColor blackColor].CGColor);
        
        CGContextClosePath(context); 
        CGContextFillPath(context);
        
        
    }
    
    
    
    /*
    float innerRadius=300;
    
    CGContextSetFillColorWithColor( context, [UIColor lightGrayColor].CGColor );
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGRect holeRect= CGRectMake(_centerX - innerRadius/2 , _centerY - innerRadius/2, innerRadius, innerRadius);
    CGContextFillEllipseInRect( context, holeRect ); 
    CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 2.0, [UIColor blackColor].CGColor);
     */
    
    
    //Create the titles in the bottom
    if([titleArray count]>0)
    {
        
        [self drawBottomTitles:context];
        
    
    }
    
    

}

-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    float _viewHeight=self.frame.size.height;
    
    
    _centerX=radius + 20;
    _centerY=_viewHeight/2;

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint=[touch locationInView:self];

    float angle=atanf((touchPoint.y -_centerY)/(touchPoint.x-_centerX));
    int quadrant=[self findQuadrant:touchPoint];
    
    if(quadrant !=0)
    {
    
    float radian;
    
    switch (quadrant) {
        case 1:
        {
            radian=(2*3.14)+angle;
        }
        break;
            
        case 2:
        {
            radian=3.14+angle;
        }
        break;
            
        case 3:
        {
            angle=1.57+angle;
            radian=1.57+angle;

        }
            break;
            
        case 4:
        {
            radian=angle;
            
        }
            break;
    }
  
    //Find which pie has to be highlighted.
    int pieToBeSelected=0;
    float offset=0;
    
    
    for(int i=0;i<[valueArray count];i++)
    {
        
        float myAngle=[[angleArrays objectAtIndex:i] floatValue];
        
        if((radian>=offset)&&(radian<offset+myAngle)){
        pieToBeSelected=i;
        break;
        }

        offset+=myAngle;
    }
    
    if(selectedPie==pieToBeSelected)
    {
        
        //Selected Pie is touched Again to return it back to original Location
        returnBackToOriginalLocation=YES;
        
        
    }else{
        
        selectedPie=pieToBeSelected;
        returnBackToOriginalLocation=NO;
    
    }
    [self highlightTheTitle];
    [self setNeedsDisplay];
        
    }


}

-(int)findQuadrant:(CGPoint)touchPoint
{
    //top right
    CGRect rect=CGRectMake(_centerX, 0, radius,_centerY );
    BOOL contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 1;
    
    
    //top left
    rect=CGRectMake(0, 0, radius+20, _centerY);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 2;
    
    //bottom left
    rect=CGRectMake(0, _centerY, radius + 20, _centerY);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 3;
    
    
    //bottom right
    rect=CGRectMake(_centerX, _centerY, radius, _centerY);
    contains = CGRectContainsPoint(rect, touchPoint);
    if(contains)
        return 4;
    
    
    
    
    return 0;
}


- (void)dealloc
{
    [super dealloc];
}



@end
