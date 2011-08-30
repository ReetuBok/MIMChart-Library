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
//  BarChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BarChart.h"
#import "BarView.h"
#import "LineInfoBox.h"

@implementation BarChart
@synthesize groupBars,xIsString,barWidth,needStyleSetter,style,isGradient,horizontalGradient;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        groupBars=NO;
        
    }
    return self;
}

#pragma mark - X and Y Axis stuff

-(void)displayYAxis
{
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame))];
    [_yBand setScaleForYTile:pixelsPerTile withNumOfLines:numOfHLines];
    [self addSubview:_yBand];
    
    
}


-(void)displayXAxisWithStyle:(int)xstyle
{
    

    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    [_xBand readTitleFromCSV:filePath AtColumn:xColumn];
    _xBand.style=xstyle;
    _xBand.xIsString=xIsString;
    if(groupBars)
    {
        if (barWidth==0) _xBand.scalingFactor=[self FindBestScaleForGraph];
        else  _xBand.scalingFactor=barWidth*[_xElements count]+20;
    }
    else
    {
        if (barWidth==0) {
            _xBand.scalingFactor=[self FindBestScaleForGraph];
        }
        else
            _xBand.scalingFactor=barWidth;
    }
    
    
    [self addSubview:_xBand];
    
}



-(void)initAll
{
    
    srand(time(NULL));
    

    [self FindTileWidth];
    [self CalculateGridDimensions];
    [self ScalingFactor]; 
    [self addSetterButton];
    //[self drawLineInfoBox];
   
    
    
    //If these property are not set by users
    //set them here.
    
    if(style==0)
        style=0;
    
    if(!groupBars)
    {
        if(barWidth==0)
            barWidth=_scalingX;
    }
    
    
    
}


-(void)drawLineInfoBox
{
    LineInfoBox *box=[[LineInfoBox alloc]initWithFrame:CGRectMake(0, 440, CGRectGetWidth(self.frame), 400)];
    box.lineArray=[[NSMutableArray alloc]initWithArray:_xElements];
    [self addSubview:box];
}


-(void)CalculateGridDimensions
{
    
    _gridWidth=self.frame.size.width;
    _gridHeight=self.frame.size.height;
}


-(void)FindTileWidth
{
    
    _tileWidth=50;
    
    
}



#pragma mark - Scale


-(void)ScalingFactor
{
    if(groupBars){
    
        maxOfY=[self findMaximumValue:_yValElements];

    }
    else
    {
        maxOfY=[self findMaximumValue:_yElements];

        
    }
    
    [self findScaleForYTile:_gridHeight]; // Find Scaling factor for Y    
    [self findScaleForXTile];

}


-(float)FindMaxOfY
{
    
    return maxOfY;
    
}

-(float)FindScaleOfX
{
    
    return _scalingX;
    
}

-(float)FindBestScaleForGraph
{
    
    return MAX(_scalingX, _scalingY);
    
}


-(void)findScaleForYTile:(float)screenHeight
{
    int HorLines=screenHeight/_tileWidth;
    numOfHLines=HorLines;
    
    float maxY=maxOfY;
    float pixelPerTile=maxY/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    pixelsPerTile=pixelPerTile;
    
    _scalingY=_tileWidth/pixelPerTile;
    
    
}


-(void)findScaleForXTile
{
    if(xIsString){
        _scalingX=_gridWidth/[_yElements count];
        return;
    }
    
    int VerLines=_gridWidth/_tileWidth;
    float maxX=[self findMaximumValue:_xElements];
    float pixelPerTile=maxX/(VerLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingX=_tileWidth/pixelPerTile;
    
}




-(float)findMaximumValue:(NSArray *)array
{
    
    float maxVal=[[array objectAtIndex:0] floatValue];
    for (int i=1; i<[array count]; i++) {
        
        if(maxVal<[[array objectAtIndex:i] floatValue])
            maxVal=[[array objectAtIndex:i] floatValue];
    }   
    


    return maxVal;
    
}



#pragma  mark - read
-(void)readFromCSV:(NSString*)csvPath  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dColumn
{
    xColumn=tcolumn;

    int _column;
    if(groupBars) _column=0;
    else _column=dColumn; 
    
    //  here - stores all values for y.
    _yElements=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    filePath=[csvPath retain];
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [_yElements addObject:[columnArray objectAtIndex:_column]];
            k++;
            
        }
    [_yElements removeObjectAtIndex:0];
    
    //--
    
    
    if(groupBars) _column=0;
    else _column=tcolumn;
    
    //stores all values of x.
    _xElements=[[NSMutableArray alloc]init];
    
    
    fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    if(groupBars)
    {
        
        NSArray *columnArray=[[linesArray objectAtIndex:_column] componentsSeparatedByString:@";"];
        
        int k=0;
        for (id string in columnArray)
        if(k<[columnArray count]){
            
            [_xElements addObject:[columnArray objectAtIndex:k]];
            k++;
            
        }
    }
    else
    {
        
        int k=0;
        for (id string in linesArray)
            if(k<[linesArray count]-1){
                
                NSString *lineString=[linesArray objectAtIndex:k];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                [_xElements addObject:[columnArray objectAtIndex:_column]];
                k++;
                
            }
        
        
    }
    
    
    [_xElements removeObjectAtIndex:0];
    
    
    
    //populate
    if(groupBars)
    {
        _yValElements=[[NSMutableArray alloc]init];
        _xValElements=[[NSMutableArray alloc]init];
        
        fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
        linesArray=[fileDataString componentsSeparatedByString:@"\n"];

        
        for(int k=0;k<[linesArray count]-1;k++)
        {
            
            [_xValElements addObject:[NSNumber numberWithFloat:k]];
            
            NSString *lineString=[linesArray objectAtIndex:k+1];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            for(int i=0;i<[columnArray count]-1;i++)
            {
                float value=[[columnArray objectAtIndex:i+1] floatValue];
                [_yValElements addObject:[NSNumber numberWithFloat:value]];
            }
            
            

        }
    }

    NSLog(@"%@",_yValElements);
    [self initAll];

}

/*This method is needed only if you use Style setter*/
-(IBAction)styleButtonClicked:(id)sender
{
 
    if(isGradient)    style=[sender tag]+2;
    else     style=[sender tag]+1;
    
    
    
    [(UIButton*)sender setTag:style];
    [styleLabel setText:[NSString stringWithFormat:@"style=%i",style]];
    
    
    //Remove all FragmentedBar
    for(UIView *view in self.subviews)
    if([view isKindOfClass:[BarView class]])
    [view removeFromSuperview];
    
    
    [self setNeedsDisplay];
    
}




-(void)addSetterButton
{
    if(needStyleSetter)
    {
        
        //Style setter code start
        styleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        styleButton.tag=style;
        [styleButton setFrame:CGRectMake(10, 10, 100, 30)];
        [styleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [styleButton setTitle:@"Next" forState:UIControlStateNormal];
        [styleButton addTarget:self action:@selector(styleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:styleButton];
        //Style setter code end
        
        
        styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
        [styleLabel setBackgroundColor:[UIColor clearColor]];
        [styleLabel setText:[NSString stringWithFormat:@"style=%i",style]];
        [styleLabel setTextColor:[UIColor blackColor]];
        [styleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [self addSubview:styleLabel];
        
    }
    
    
}




-(void)drawBarGraph
{
    
    [self setNeedsDisplay];
   // [self drawAnchorPoints];
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    

    CGContextRef context = UIGraphicsGetCurrentContext();

    //Draw the bg gradient
    [self drawBg:context];
    [self drawHorizontalBgLines:context];
    
    int totalColors=[MIMColor sizeOfColorArray];

    
    // Drawing code
    if(groupBars)
    {
        int barsPerDivision=[_xElements count];
        int SpaceOfEachBar;
        
        if(barWidth==0) SpaceOfEachBar=_scalingX/barsPerDivision-5;
        else SpaceOfEachBar=barWidth;
        
        if(barWidth!=0) _scalingX=barWidth*barsPerDivision+20;
        
        for (int j=0; j<[_yElements count]; j++) {
        for (int i=0; i< barsPerDivision; i++) {

    
        int _height=[[_yValElements objectAtIndex:(j* barsPerDivision)+i] intValue];
        _height=_height*_scalingY;
            
        BarView *view=[[BarView alloc]initWithFrame:CGRectMake(j* _scalingX + (i *SpaceOfEachBar) , _gridHeight-_height, SpaceOfEachBar, _height)];

        view.isGradient=isGradient;
        view.horGradient=horizontalGradient;
            
        if(isGradient)
        {
            view.dColor=[MIMColor GetColorAtIndex:(2*i+style+1)%totalColors];
            view.lColor=[MIMColor GetColorAtIndex:(2*i+style)%totalColors];
        }
        else
            view.color=[MIMColor GetColorAtIndex:(i+style)%totalColors];
        
            
            
  
        view.borderColor=[UIColor blackColor];
            
        //Draw the shadow
        [view.layer setShadowRadius:1.0];
        [view.layer setShadowColor:[UIColor grayColor].CGColor];
        [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
        [view.layer setShadowOpacity:0.8];
        [self addSubview:view];
            
        }
        
            
        }
        
        
    }
    else
    {
                
        for (int i=0; i<[_xElements count]; i++) { 
            
            int _height=[[_yElements objectAtIndex:i] floatValue]*_scalingY;
            BarView *view=[[BarView alloc]initWithFrame:CGRectMake(i* barWidth, _gridHeight-_height, barWidth-10, _height)];
            view.isGradient=isGradient;
            
            if(isGradient)
            {
                view.dColor=[MIMColor GetColorAtIndex:(style)%totalColors];
                view.lColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
            }
            else
                view.color=[MIMColor GetColorAtIndex:style%totalColors];

            

            
            
            //Draw the shadow
            [view.layer setShadowRadius:1.0];
            [view.layer setShadowColor:[UIColor grayColor].CGColor];
            [view.layer setShadowOffset:CGSizeMake(2.0, 1.0)];
            [view.layer setShadowOpacity:0.8];

            
            [self addSubview:view];
        }
    
    }
    
    
}

-(void)drawBg:(CGContextRef)context
{
    
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
    
}
-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0].CGColor);
    CGContextSetLineWidth(ctx, 0.1);
    int numHorzLines=_gridHeight/_tileWidth;
    for (int i=0; i<numHorzLines; i++) {
        
        CGContextMoveToPoint(ctx, 0,i*_tileWidth);
        CGContextAddLineToPoint(ctx,_gridWidth , i*_tileWidth);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
}
- (void)dealloc
{
    [super dealloc];
}

@end
