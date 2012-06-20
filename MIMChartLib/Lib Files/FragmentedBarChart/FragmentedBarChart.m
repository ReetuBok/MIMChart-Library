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
//  FragmentedBarChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "FragmentedBarChart.h"
#import "FragmentedBar.h"
#import "MIMColor.h"
#import "YAxisBand.h"
#import "XAxisBand.h"


@implementation FragmentedBarChart
@synthesize xIsString;
@synthesize style;
@synthesize needStyleSetter;
@synthesize isGradient;
@synthesize barWidth;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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


-(void)displayXAxisWithTitleFromColumn:(int)column Style:(int)xstyle
{

    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    //[_xBand readTitleFromCSV:filePath AtColumn:column];
    _xBand.style=xstyle;
    _xBand.xIsString=xIsString;
    if (barWidth==0) {
        _xBand.scalingFactor=[self FindBestScaleForGraph];
    }
    else
        _xBand.scalingFactor=barWidth;
    
    
    [self addSubview:_xBand];

}




-(float)FindMaxOfY
{
    
    return maxOfY;
    
}

-(float)FindBestScaleForGraph
{
    
    return MAX(_scalingX, _scalingY);
    
}


-(float)findMaximumValue:(NSArray *)array
{
    int maxVal=[[array objectAtIndex:0] intValue];
    for (int i=1; i<[array count]; i++) {
        
        if(maxVal<[[array objectAtIndex:i] intValue])
            maxVal=[[array objectAtIndex:i] intValue];
    }   
    return maxVal;
    
}

-(void)FindTileWidth
{
    
    _tileWidth=50;
    
    
}

-(void)findScaleForXTile
{
    float _gridWidth=CGRectGetWidth(self.frame);
    
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


-(void)ScalingFactor
{

    [self findScaleForYTile:CGRectGetHeight(self.frame)]; // Find Scaling factor for Y
    [self findScaleForXTile];
}


-(void)readTitlesFromCSV:(NSString*)path
{
    // will pick Jan, Feb
    _yElements=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    filePath=[path copy];
    
    
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    
    int k=0;
    for (id string in linesArray)
    if(k<[linesArray count]-1){
        
        NSString *lineString=[linesArray objectAtIndex:k];
        NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
        [_yElements addObject:[columnArray objectAtIndex:0]];
        k++;
        
    }
    [_yElements removeObjectAtIndex:0];
    
    
    
    //will pick Food;Education;Medicines;Electronics;Defence
    _xElements=[[NSMutableArray alloc]init];
    
   linesArray=[fileDataString componentsSeparatedByString:@"\n"];
   NSArray *columnArray=[[linesArray objectAtIndex:0] componentsSeparatedByString:@";"];
    
    k=0;
    for (id string in columnArray)
    if(k<[columnArray count]){
        
        [_xElements addObject:[columnArray objectAtIndex:k]];
        k++;
        
    }
    [_xElements removeObjectAtIndex:0];
    
    
    //Put values in valuesArray
    valuesArray=[[NSMutableArray alloc]init];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    for (k=1;k<[linesArray count];k++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:k];
        NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
        
        for (int l=1;l<[columnArray count];l++)
            [valuesArray addObject:[columnArray objectAtIndex:l]];

    }
    
    

    
    NSMutableArray *findMaxArry=[[NSMutableArray alloc]init];
    //find max of all rows.
    int columns=[_xElements count];
    int sum;
   

    for(int l=0;l<[valuesArray count];l+=columns)
    {
        sum=0;
        for (k=0; k<columns; k++) 
        {
            sum+=[[valuesArray objectAtIndex:l+k] floatValue];
        
        }
        [findMaxArry addObject:[NSNumber numberWithFloat:sum]];
    
    }
        
    maxOfY=[self findMaximumValue:findMaxArry];
    

    
    
    //[findMaxArry release];
    
    
}

/*This method is needed only if you use Style setter*/
-(IBAction)styleButtonClicked:(id)sender
{
    
    style=[sender tag]+2;
    
    [(UIButton*)sender setTag:style];
    [styleLabel setText:[NSString stringWithFormat:@"style=%i",style]];
    
    
    //Remove all FragmentedBar
    for(UIView *view in self.subviews)
    if([view isKindOfClass:[FragmentedBar class]])
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



-(void)drawFragmentedBarGraph
{
    


    srand(time(NULL));
    [self FindTileWidth];
    [self ScalingFactor];
    [self addSetterButton];
    
    if(self.style)
        self.style=0;
    
    
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int _frameHeight=CGRectGetHeight(rect);
    
    if(barWidth==0)
        barWidth=_scalingX;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    [self drawBackGroundGradient:context];
    [self drawHorizontalBgLines:context];
    
    //find max of all rows.
    int columns=[_xElements count];
    float offset;
    int column=0;
    
    int totalColors=[MIMColor sizeOfColorArray];

    

    
    for(int l=0;l<[valuesArray count];l+=columns)
    {

        offset=0;
        int k=0;

        
        for (k=0; k<columns; k++) 
        {
            int height=[[valuesArray objectAtIndex:l+k] floatValue]*_scalingY;
            int originX=column*barWidth;
            offset+=height;
            
            FragmentedBar *bar=[[FragmentedBar alloc]initWithFrame:CGRectMake(originX,_frameHeight-offset, barWidth* 0.8, height)];
            
            if(isGradient)
            {
                NSDictionary *color1=[MIMColor GetColorAtIndex:(2*k + style)%totalColors];
                NSDictionary *color2=[MIMColor GetColorAtIndex:(2*k+1 + style)%totalColors];
                [bar drawBarWithGradientColor:color1 And:color2];
                
               
            }
            else
            {
                NSDictionary *color1=[MIMColor GetColorAtIndex:(k+style)%totalColors];
                [bar drawBarWithColor:color1];
            }
            
            //Draw the shadow       
            [bar.layer setShadowRadius:3.0];
            [bar.layer setShadowColor:[UIColor grayColor].CGColor];
            [bar.layer setShadowOffset:CGSizeMake(0.0, -2.0)];
            [bar.layer setShadowOpacity:1.0];
            [self addSubview:bar];
            
        }
        column++;
        
    }
    
    CGContextFlush(context);
    
    if(needStyleSetter)
    [self bringSubviewToFront:styleButton];
    
}


-(void)drawBackGroundGradient:(CGContextRef)context
{
    
    
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
    

    /*    
    //Plain white background but it looks dullll
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));  
    CGContextFillPath(context);
    */
    
    
}

-(void)drawHorizontalBgLines:(CGContextRef)context
{
    float _gridHeight=CGRectGetHeight(self.frame);
    float _gridWidth=CGRectGetWidth(self.frame);
    
    //Draw Gray Lines as the markers
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);

    
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 0.05);
    int numHorzLines=_gridHeight/_tileWidth;
    for (int i=0; i<numHorzLines; i++) {
        
        CGContextMoveToPoint(context, 0,i*_tileWidth);
        CGContextAddLineToPoint(context,_gridWidth , i*_tileWidth);
    }
    CGContextDrawPath(context, kCGPathStroke);
    
    
}

- (void)dealloc
{
    ////[super dealloc];
}

@end
