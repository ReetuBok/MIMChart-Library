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
//  BarChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "BarChart.h"
#import "BarView.h"
#import "LineInfoBox.h"
@interface BarChart()
{
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    
    
    NSMutableDictionary *barProperties;
    NSMutableDictionary *hlProperties;
    NSMutableDictionary *vlProperties;
    NSMutableDictionary *xLProperties;
    NSMutableDictionary *yLProperties;
    
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    float _tileHeight;
    BOOL xIsString;
    NSArray *_xTitles;
    
    float minimumOnY;
    
    float pixelsPerTile;
    int numOfHLines;
    float barWidth;
    
    LineScrollView *lineGScrollView;
    
    
    float animationDelayValue;
    float animationDurationvalue;
    int animationType;
    
    int barsPerDivision;
    int spaceBetweenSameGroupBar;
    
    int style;
    float gapBetweenBars; // for now it is 10 fixed.needs to be variable
    float gapBetweenBarsDifferentGroup;
    BOOL isLongGraph_;
    float contentSizeX;
    float barYOffsetForNegativeGraphs;
    
}
@end
@implementation BarChart
@synthesize isGradient,gradientStyle,minimumLabelOnYIsZero;
@synthesize delegate,xTitleStyle,backgroundcolor,barcolorArray;
@synthesize groupedBars,stackedBars,barLabelStyle;


static NSInteger firstNumSort(id str1, id str2, void *context) {
    
    int num1 = [str1 integerValue];
    int num2 = [str2 integerValue];
    
    if (num1 < num2)
        return NSOrderedAscending;
    else if (num1 > num2)
        return NSOrderedDescending;
    
    return NSOrderedSame;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        groupedBars=NO;
        stackedBars=NO;
        gradientStyle=VERTICAL_GRADIENT_STYLE;
        xTitleStyle=X_TITLES_STYLE1;
        barYOffsetForNegativeGraphs=0;
        animationType=0;
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}


-(void)drawBarChart
{
    
    [self getAnimationProperties];
    [self initAndWarnings];
    [self createLongBarGraphScrollView];
  
    
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
}

-(void)initAndWarnings 
{
    
    srand(time(NULL));
    
    
    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    
    
    if([delegate respondsToSelector:@selector(valuesForGraph:)])
    {
        NSArray *valueArray_=[delegate valuesForGraph:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available to draw graph.");
        
        //See if the its an array or array or just one array
        if([valueArray_ count]>0)
        {
            _yValElements=[NSMutableArray arrayWithArray:valueArray_];
        }
        
        
    }
    else
    {
        NSLog(@"Error: Use delegate Method valuesForGraph: to give values for graph.");
    }
    
    
    
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available for x-Axis Labels.");
        
        
        if([valueArray_ count]>0)
        {
            _xValElements=[NSMutableArray arrayWithArray:valueArray_];
        }
        if(groupedBars || stackedBars)
            xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[[_xValElements objectAtIndex:0]objectAtIndex:0]];
        else 
            xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[_xValElements objectAtIndex:0]];
        
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
    }
    
    
    if([delegate respondsToSelector:@selector(titlesForXAxis:)])
    {
        _xTitles=[delegate titlesForXAxis:self];
        NSLog(@"_xTitles at p,%@",[_xTitles objectAtIndex:0]);
        NSAssert(([_xTitles count] !=0),@"WARNING::No values available for x-Axis Labels.");
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
    }
    
    
    if (groupedBars ||stackedBars)  barWidth=30;
    else  barWidth=40;
    
    if([delegate respondsToSelector:@selector(barProperties:)])
    {
        barProperties=[NSMutableDictionary dictionaryWithDictionary:[delegate barProperties:self]];
        
        if([barProperties valueForKey:@"barwidth"])
            barWidth=[[barProperties valueForKey:@"barwidth"] floatValue];                
    }
    
    
    

    
    
    [MIMColor nonAdjacentGradient];
    [self CalculateGridDimensions];
    [self FindTileWidthAndHeight];
    [self ScalingFactor]; 
    

}


-(void)drawLineInfoBox
{
    LineInfoBox *box=[[LineInfoBox alloc]initWithFrame:CGRectMake(0, 440, CGRectGetWidth(self.frame), 400)];
    box.lineArray=[[NSMutableArray alloc]initWithArray:_xValElements];
    [self addSubview:box];
}


-(void)CalculateGridDimensions
{
    
    _gridWidth=self.frame.size.width;
    _gridHeight=self.frame.size.height;
}

-(void)FindTileWidthAndHeight
{
    
    //Check if Tilewidth is defined by user
    _tileWidth=50;
    if([vlProperties valueForKey:@"gap"]) 
        _tileWidth=[[vlProperties valueForKey:@"gap"] floatValue];
    
    if(_tileWidth==0)
    {
        _tileWidth=10;
        NSLog(@"WARNING: Minimum gap between vertical lines is 10.");
    }
    
    //HEIGHT
    _tileHeight=50;
    if([hlProperties valueForKey:@"gap"]) 
        _tileHeight=[[hlProperties valueForKey:@"gap"] floatValue];
    
    if(_tileHeight==0)
    {
        _tileHeight=10;
        NSLog(@"WARNING: Minimum gap between horizontal lines is 10.");
    }
    

    
    
    
}

-(void)ScalingFactor
{
    [self _findScaleForYTile];
    [self _findScaleForXTile];

}

-(void)_findScaleForYTile
{
    int HorLines=_gridHeight/_tileHeight;
    numOfHLines=HorLines;
    
    float maxOfY;
    float minOfY;
    
    if(groupedBars || stackedBars)
    {
    
        maxOfY=[MIM_MathClass getMaxFloatValue:[_yValElements objectAtIndex:0]];
        for (int i=1; i<[_yValElements count]; i++) 
        {
            float maxOfY1=[MIM_MathClass getMaxFloatValue:[_yValElements objectAtIndex:i]];
            if(maxOfY1>maxOfY)
                maxOfY=maxOfY1;
        }
        
        
        
        minOfY=[MIM_MathClass getMinFloatValue:[_yValElements objectAtIndex:0]];
        for (int i=1; i<[_yValElements count]; i++) 
        {
            float minOfY1=[MIM_MathClass getMinFloatValue:[_yValElements objectAtIndex:i]];
            if(minOfY1<minOfY)
                minOfY=minOfY1;
        }
        
    }
    else 
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
        minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
    }
    
    
    
    
    
    float pixelPerTile=(maxOfY-minOfY)/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    pixelsPerTile=pixelPerTile;
    
    _scalingY=_tileHeight/pixelPerTile;
    
    
    
    //Negative Bars Scaling
    if(minOfY<0)
    {
        minimumOnY=floorf(minOfY/pixelsPerTile);     
        barYOffsetForNegativeGraphs=fabsf(minimumOnY)*_tileHeight;
        //NSLog(@"%f,%f",minOfY,pixelsPerTile);
        //NSLog(@"%f",minimumOnY);
        minimumOnY*=pixelsPerTile;
        
        
        return;
    }
    minimumOnY=0;
    
//    countDigits=[[NSString stringWithFormat:@"%.0f",fabs(minOfY)] length];
//    minimumOnY=minOfY/pow(10, countDigits-1);
//    minimumOnY=floorf(minimumOnY);
//    minimumOnY=minimumOnY*pow(10, countDigits-1);
    
}


-(void)_findScaleForXTile
{
    int count=0;
    
   
    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        count=[_xValElements count];
        
    }
    else
    {
        //groupBars
        count=[[_xValElements objectAtIndex:0] count];
    }
    
    
    
    if(xIsString)
    {
        
        _scalingX=_gridWidth/count;
        return;
    }
    
    
    
    int VerLines=_gridWidth/_tileWidth;
    float maxX=[MIM_MathClass getMaxFloatValue:_xValElements];
    float minX=[MIM_MathClass getMinFloatValue:_xValElements];
    
    float pixelPerTile=(maxX-minX)/(VerLines-1);
    
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingX=_tileWidth/pixelPerTile;
    
}




-(void)createLongBarGraphScrollView
{
    
    int yCount=[_yValElements count];
    if(groupedBars)
    {
        
        barsPerDivision=[[_yValElements objectAtIndex:0] count];
        spaceBetweenSameGroupBar=barWidth/10;
        gapBetweenBarsDifferentGroup=barWidth;
        contentSizeX=(barsPerDivision * barWidth * yCount) + (barsPerDivision-1 * spaceBetweenSameGroupBar * yCount) + (barWidth * yCount +1) ;
        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
        
    }
    else if(stackedBars)
    {
        
        barsPerDivision=1;
        spaceBetweenSameGroupBar=0;
        contentSizeX=(barsPerDivision * barWidth * yCount) + (barsPerDivision-1 * spaceBetweenSameGroupBar * yCount) + (barWidth * yCount +1) ;
        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
    }
    else
    {
        spaceBetweenSameGroupBar=10;
        contentSizeX=(yCount* barWidth) + 10*(yCount+1);
        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
        
    }
    
    
    
    if(isLongGraph_)
    {
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, _gridHeight)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.tag=LINESCROLLVIEWTAG;
        [self addSubview:lineGScrollView];        
    }
}


//Delegate Methods gets the priority
-(void)getColorArray
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    
    BOOL pickDefaultColor=TRUE;
    if([delegate respondsToSelector:@selector(colorsForBarChart:)])
    {
        barcolorArray=[NSMutableArray arrayWithArray:[delegate colorsForBarChart:self]];
        if(barcolorArray) pickDefaultColor=FALSE;
    }
    
    
    if(pickDefaultColor)
    {
        barcolorArray=[[NSMutableArray alloc]init];
        if(DEBUG_MODE) NSLog(@"WARNING:Color of Bar Chart not defined,hence picking up random color.");
        
        int totalBarColors =1;
        
        if(groupedBars ||stackedBars) totalBarColors=[[_yValElements objectAtIndex:0] count];
        
        for (int i=0; i<totalBarColors; i++) 
            [barcolorArray addObject:[MIMColor GetMIMColorAtIndex:style%totalColors]];

    }
}


-(void)getAnimationProperties
{
    
    NSDictionary *animationDict;
    BOOL animationOnBars;
    if([delegate respondsToSelector:@selector(animationOnBars:)])
    {
        animationDict=[delegate animationOnBars:self];
        if([animationDict respondsToSelector:@selector(allKeys)])
        if([[animationDict allKeys] count]>0)
        {
            animationOnBars=TRUE;
        }
        else 
        {
            if(DEBUG_MODE) NSLog(@"WARNING:animationOnBars delegate method returns nil.");
        }
        
        
    }
    
    //animation block
    
    if(animationOnBars)
    {
        
        
        NSArray *keysArray=[animationDict allKeys];
        if ([keysArray containsObject:@"animationDelay"]) 
        {
            animationDelayValue=[[animationDict valueForKey:@"animationDelay"] floatValue];
        }
        else 
        {
            animationDelayValue=0;
        }
        
        if ([keysArray containsObject:@"animationDelay"]) 
        {
            animationDurationvalue=[[animationDict valueForKey:@"animationDuration"] floatValue];
        }
        else 
        {
            animationDurationvalue=1.0;
        }
        
        if ([keysArray containsObject:@"type"]) 
        {
            animationType=[[animationDict valueForKey:@"type"] intValue];
        }
        else 
        {
            animationType=1;
        }
        
    }
    

}


-(void)createAnimationOn:(BarView *)view withBarHeight:(float)height negativeBars:(BOOL)negativeBars
{
    //animation block
  
    
        switch (animationType) 
        {
            case 0:
            {

            }
                break;
            case 1:
            {
                
                float tempHeight=height;
                float negativeM=1;
                if(negativeBars)negativeM=-1;
               
                [view setTransform:CGAffineTransformConcat(CGAffineTransformMakeScale(1.0,0.001), CGAffineTransformMakeTranslation(0,negativeM* tempHeight/2))];
                    
                    
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelay:animationDelayValue];
                [UIView setAnimationDuration:animationDurationvalue];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                [view setTransform:CGAffineTransformConcat( CGAffineTransformMakeTranslation(0, 0.5*(tempHeight-view.bounds.size.height)*negativeM),CGAffineTransformMakeScale(1.0,1.0))]; 
                [UIView commitAnimations];
                

                
            }
                break;
        }
    
    

}
#pragma mark - DRAW CHARTS
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int totalColors=[MIMColor sizeOfColorArray];
    style=rand()%totalColors;
    [self getColorArray];
    
    
    for (UIView *view in self.subviews)
    if([view isKindOfClass:[XAxisBand class]] || [view isKindOfClass:[YAxisBand class]]) {}
    else [view removeFromSuperview];
    
    

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);
    
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    //Draw the bg gradient
    [self drawBg:context];
    [self drawHorizontalBgLines:context];
    

   
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
   
    
    if(isGradient) style=2*style;
    
    // Drawing code
    if(groupedBars)
    {
    
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            for (int i=0; i< [[_yValElements objectAtIndex:j] count]; i++) 
            {
                
        
                BOOL isNegativeBar=FALSE;
                
                int _height=[[[_yValElements objectAtIndex:j] objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)isNegativeBar=TRUE;
                if(_height<0)_height=-_height;
                

                    
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin, originY, barWidth, _height)];

                view.isGradient=isGradient;
                view.gradientStyle=gradientStyle;
                
                if(isNegativeBar) view.negativeBar=TRUE;
                else view.negativeBar=FALSE;
                
                if(isGradient)
                {
                    view.dColor=[MIMColor GetColorAtIndex:((2*i)+style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:((2*i)+style)%totalColors];
                }
                else view.color=[MIMColor GetMIMColorAtIndex:(i+style)%totalColors];

                view.borderColor=[UIColor blackColor];
                    
                //Draw the shadow
                [view.layer setShadowRadius:1.0];
                [view.layer setShadowColor:[UIColor grayColor].CGColor];
                if(isNegativeBar)[view.layer setShadowOffset:CGSizeMake(2.0, 1.0)];
                else [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
                [view.layer setShadowOpacity:0.8];
                
                
                [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar];
                
                
                if(isLongGraph_) 
                    [lineGScrollView addSubview:view];
                else 
                    [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=spaceBetweenSameGroupBar;
                
                xOrigin+=barWidth;
            }
            
            xOrigin+=barWidth;
        }

        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, _gridHeight);
        
    }
    else if(stackedBars)
    {

       
        
        
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            
            //Find ordered elements of [_yValElements objectAtIndex:j]
            NSArray *stackArray=[_yValElements objectAtIndex:j];
            stackArray=[stackArray sortedArrayUsingFunction:firstNumSort context:NULL];
            
            for (int i=[stackArray count]-1; i >=0; i--) 
            {
                
                BOOL isNegativeBar=FALSE;
                
                int _height=[[stackArray objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)isNegativeBar=TRUE;
                if(_height<0)_height=-_height;
                
                
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin,originY, barWidth, _height)];
                
                view.isGradient=isGradient;
                view.gradientStyle=gradientStyle;
                if(isNegativeBar) view.negativeBar=TRUE;
                else view.negativeBar=FALSE;
                
                int t=0;
                for (int k=0; k<[[_yValElements objectAtIndex:j] count]; k++) 
                {
                    int _h=[[[_yValElements objectAtIndex:j] objectAtIndex:k] intValue];
                    _h=_h*_scalingY;
                    
                    if(_h==_height)
                    {
                        t=k;
                        break;
                    }
                }
                
                if(isGradient)
                {
                    view.dColor=[MIMColor GetColorAtIndex:((2*t)+style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:((2*t)+style)%totalColors];
                }
                else
                    view.color=[MIMColor GetMIMColorAtIndex:(i+style)%totalColors];
                
                
                
                
                view.borderColor=[UIColor blackColor];
                
                //Draw the shadow
                [view.layer setShadowRadius:1.0];
                [view.layer setShadowColor:[UIColor grayColor].CGColor];
                if(isNegativeBar)[view.layer setShadowOffset:CGSizeMake(2.0, 1.0)];
                else [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
                [view.layer setShadowOpacity:0.8];
                
                [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar];
                
                
                if(isLongGraph_) [lineGScrollView addSubview:view];
                else [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=spaceBetweenSameGroupBar;
                
            }
            
            xOrigin+=(barWidth+10);
        }
        
        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, _gridHeight);

    }
    else
    {
       
       
        
        for (int i=0; i<[_yValElements count]; i++) 
        { 
            BOOL isNegativeBar=FALSE;
            float _height=[[_yValElements objectAtIndex:i] floatValue]*_scalingY;
            float originY;
            if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
            else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
            
            if(_height<0)isNegativeBar=TRUE;
            if(_height<0)_height=-_height;
            
            
            BarView *view=[[BarView alloc]initWithFrame:CGRectMake((i* barWidth) + spaceBetweenSameGroupBar*(i+1),originY,barWidth,_height)];
            view.isGradient=isGradient;
            view.gradientStyle=gradientStyle;
            if(isNegativeBar) view.negativeBar=TRUE;
            else view.negativeBar=FALSE;
            
            if(isGradient)
            {
                view.dColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
                view.lColor=[MIMColor GetColorAtIndex:(style)%totalColors];
            }
            else 
                view.color=[barcolorArray objectAtIndex:0];
        
            //Draw the shadow
            [view.layer setShadowRadius:1.0];
            [view.layer setShadowColor:[UIColor grayColor].CGColor];
            if(isNegativeBar)[view.layer setShadowOffset:CGSizeMake(2.0, 1.0)];
            else [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
            [view.layer setShadowOpacity:0.8];
            

            [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar];
             
            
            
            if(isLongGraph_)[lineGScrollView addSubview:view];
            else [self addSubview:view];
            
            
            
                      
            
        }
        
        
    }
    [self drawBarInfoBoxForGraph];

    if(isLongGraph_ && !groupedBars) 
        lineGScrollView.contentSize=CGSizeMake(contentSizeX, _gridHeight);

    if(isLongGraph_) 
    {  
        CGRect a=lineGScrollView.frame;
        a.size.height+=50;
        lineGScrollView.frame=a;
        [self addSubview:lineGScrollView];  
    } 

    
}

-(void)drawBg:(CGContextRef)ctx
{
    
 
    //Check if User has given any color for Background
    if(self.backgroundcolor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:backgroundcolor.red green:backgroundcolor.green blue:backgroundcolor.blue alpha:backgroundcolor.alpha].CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, _gridWidth, _gridHeight));
        CGContextRestoreGState(ctx);
        return;
        
        
    }
    
    if([delegate respondsToSelector:@selector(backgroundViewForLineChart:)])
    {
        
        
        return;
    }
    
    
    
    //Else Draw the background with the gray Gradient
    CGContextSaveGState(ctx);
    CGFloat BGLocations[3] = { 0.0,0.5 ,1.0 };
    CGFloat BgComponents[12] = { 0.96, 0.96, 0.96 , 1.0,  // Start color
        0.99, 0.99, 0.99 , 1.0,  // Start color
        1.0, 1.0, 1.0 , 1.0 }; // Mid color and End color
    
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    CGContextDrawLinearGradient(ctx, bgRadialGradient, CGPointMake(0, 0), CGPointMake(0, _gridHeight), 1);
    if(!CGContextIsPathEmpty(ctx))     CGContextClip(ctx);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    CGContextRestoreGState(ctx);
    
    
}

-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    BOOL horizontalLinesVisible=TRUE;
    if([hlProperties valueForKey:@"hide"]) 
        horizontalLinesVisible=[[hlProperties valueForKey:@"hide"] boolValue];
    
    if(!horizontalLinesVisible)
    {
        NSLog(@"Caution:Horizontal Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawHorizontalLines:");
        return;
    }
    
    
    
    //Width
    float widthOfLine=0.1;
    if([hlProperties valueForKey:@"width"]) 
        widthOfLine=[[hlProperties valueForKey:@"width"] floatValue];
    
    if(widthOfLine==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    //Color
    MIMColorClass *c=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
    if([hlProperties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[hlProperties valueForKey:@"color"]];
    
    
    
    
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    int numHorzLines=_gridHeight/_tileHeight;
    for (int i=0; i<=numHorzLines; i++) 
    {    
        CGContextMoveToPoint(ctx, 0,i*_tileHeight);
        CGContextAddLineToPoint(ctx,_gridWidth , i*_tileHeight);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    
    
    
    
}
#pragma mark - draw Bar Info Box

-(void)drawBarInfoBoxForGraph
{
    switch (animationType) 
    {
        case 0:
        {
            [self performSelector:@selector(drawBarInfoBoxes)];
        }
            break;
            
        case 1:
        {
            [self performSelector:@selector(drawBarInfoBoxes) withObject:nil afterDelay:animationDurationvalue+animationDelayValue];
        }
            break;
    }

}
-(void)drawBarInfoBoxes
{
    if(!barLabelStyle)return;
    
    
    if(groupedBars)
    {
        
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            for (int i=0; i< [[_yValElements objectAtIndex:j] count]; i++) 
            {
                
                
                BOOL isNegativeBar=FALSE;
                
                int _height=[[[_yValElements objectAtIndex:j] objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)isNegativeBar=TRUE;
                if(_height<0)_height=-_height;
                
                float yOffset=-20;
                if(isNegativeBar)yOffset=20;
                

                
                BarInfoBox *view=[[BarInfoBox alloc]initWithFrame:CGRectMake(xOrigin,originY+yOffset,barWidth,25)];
                [view setText:[[_xTitles objectAtIndex:j] objectAtIndex:i]];
                
                if(isLongGraph_) 
                    [lineGScrollView addSubview:view];
                else 
                    [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=spaceBetweenSameGroupBar;
                
                xOrigin+=barWidth;
            }
            
            xOrigin+=barWidth;
        }
    
    }
    else if(stackedBars)
    {
    
        
    }
    else 
    {

        for (int i=0; i<[_yValElements count]; i++) 
        { 
            BOOL isNegativeBar=FALSE;
            float _height=[[_yValElements objectAtIndex:i] floatValue]*_scalingY;
            float originY;
            if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
            else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
            
            if(_height<0)isNegativeBar=TRUE;
            if(_height<0)_height=-_height;
            
            float yOffset=-20;
            if(isNegativeBar)yOffset=20;
            
            BarInfoBox *view=[[BarInfoBox alloc]initWithFrame:CGRectMake((i* barWidth) + spaceBetweenSameGroupBar*(i+1),originY+yOffset,barWidth,25)];
            [view setText:[_xTitles objectAtIndex:i]];
            
            if(isLongGraph_)[lineGScrollView addSubview:view];
            else [self addSubview:view];
            
            
            
            
            
        }
    }
    
}
#pragma mark - X and Y Axis

-(void)_displayXAxisLabels
{
    
    BOOL xLabelsVisible=TRUE;
    if([xLProperties valueForKey:@"hide"]) 
        xLabelsVisible=[[xLProperties valueForKey:@"hide"] boolValue];
    
    if(!xLabelsVisible)
        return;
    
    if([[xLProperties allKeys] count]==0)
        xLProperties=[[NSMutableDictionary alloc] init];
    
    
    if(groupedBars)
    {
        if(xTitleStyle==2 || xTitleStyle==4) xTitleStyle=1;
        [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];   
    }
    else[xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"barchart"];
    [xLProperties setValue:[NSNumber numberWithFloat:barWidth] forKey:@"xscaling"];
    
    if(groupedBars)[xLProperties setValue:[NSNumber numberWithFloat:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    else if(stackedBars)[xLProperties setValue:[NSNumber numberWithInt:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    else [xLProperties setValue:[NSNumber numberWithInt:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    
    if(groupedBars)[xLProperties setValue:[NSNumber numberWithFloat:gapBetweenBarsDifferentGroup] forKey:@"gapBetweenGroup"];
    if(groupedBars)[xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"groupedBars"];

    
    //contentSizeX=1810;
    
    XAxisBand *_xBand;
    
    if(isLongGraph_)
        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), contentSizeX, 100)];
    else 
        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
        
    _xBand.properties=xLProperties;
    _xBand.tag=XBANDTAG;
    _xBand.xElements=[[NSArray alloc]initWithArray:_xTitles];

    
    if(isLongGraph_) [lineGScrollView addSubview:_xBand];
    else [self addSubview:_xBand];

}



-(void)_displayYAxisLabels
{
    BOOL yLabelsVisible=TRUE;
    if([yLProperties valueForKey:@"hide"]) 
        yLabelsVisible=[[yLProperties valueForKey:@"hide"] boolValue];
    
    if(!yLabelsVisible)
        return;
    
    if([[yLProperties allKeys] count]==0)
        yLProperties=[[NSMutableDictionary alloc] init];
    
    [yLProperties setValue:[NSNumber numberWithFloat:pixelsPerTile] forKey:@"pxpertile"];
    [yLProperties setValue:[NSNumber numberWithInt:numOfHLines] forKey:@"num"];
    [yLProperties setValue:[NSNumber numberWithFloat:minimumOnY] forKey:@"minY"];
    [yLProperties setValue:[NSNumber numberWithFloat:_tileHeight] forKey:@"tileHeight"];
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame)+10)];
    _yBand.tag=YBANDTAG;
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
