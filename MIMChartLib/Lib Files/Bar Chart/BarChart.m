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

@implementation BarChart
@synthesize style,isGradient,horizontalGradient;
@synthesize delegate,xTitleStyle;

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
        
        groupBars=NO;
        stackedBars=NO;
        [self setBackgroundColor:[UIColor clearColor]];
        
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
    _xBand.style=xstyle;
    _xBand.xIsString=xIsString;
    if(groupBars ||stackedBars)
    {
        if (barWidth==0) _xBand.scalingFactor=[self FindBestScaleForGraph];
        else  _xBand.scalingFactor=barWidth*[_xValElements count]+20;
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



-(void)initAndWarnings 
{
    
    srand(time(NULL));
    
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
    if([delegate respondsToSelector:@selector(gapBetweenVerticalLines:)])
    {
        _tileWidth=[delegate gapBetweenVerticalLines:self];
        if(_tileWidth==0)
            _tileWidth=10;
        NSLog(@"WARNING: Minimum gap between vertical lines is 10.");
    }
    else
    {
        _tileWidth=50;
    }
    
    
    
    if([delegate respondsToSelector:@selector(gapBetweenHorizontalLines:)])
    {
        _tileHeight=[delegate gapBetweenHorizontalLines:self];
        if(_tileHeight==0)
            _tileHeight=10;
        NSLog(@"WARNING: Minimum gap between horizontal lines is 10.");
    }
    else
    {
        _tileHeight=50;
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
    
    if(groupBars || stackedBars)
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
    
    
}


-(float)FindBestScaleForGraph
{
    
    return MAX(_scalingX, _scalingY);
    
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







-(void)drawBarChart
{
    
    

    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];

    
    if([delegate respondsToSelector:@selector(groupedBars:)])
    {
        groupBars=[delegate groupedBars:self];
        
    }
    else
    {
        groupBars=FALSE;
    }

    
    
    if([delegate respondsToSelector:@selector(stackedBars:)])
    {
        stackedBars=[delegate stackedBars:self];
        
    }
    else
    {
        stackedBars=FALSE;
    }

    
    if([delegate respondsToSelector:@selector(horizontalGradient:)])
    {
        horizontalGradient=[delegate horizontalGradient:self];
    }
    else
    {
        horizontalGradient=FALSE;
    }

    
    
    
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
        if(groupBars || stackedBars)
            xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[[_xValElements objectAtIndex:0]objectAtIndex:0]];
        else 
            xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[_xValElements objectAtIndex:0]];
        
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
        return;
    }
    
    
    
    if([delegate respondsToSelector:@selector(WidthForBarChart:)])
    {
        barWidth=[delegate WidthForBarChart:self];
        if(barWidth==0)
        {
            if (groupBars ||stackedBars) 
                barWidth=30;
            else 
                barWidth=40;

        }
            
            NSLog(@"Warning:Since barWidth is explicitly 0, Code will automatically calculate its bar width.");
        
    }
    else
    {
        if (groupBars ||stackedBars) 
            barWidth=30;
        else 
            barWidth=40;
    }
    
    
 
    if([delegate respondsToSelector:@selector(displayTitlesOnXAxis:)])
    {
        BOOL displayTitleOnXAxis=[delegate displayTitlesOnXAxis:self];
        if(displayTitleOnXAxis)
        {
            
            
            if([delegate respondsToSelector:@selector(titlesForXAxis:)])
            {
                _xTitles=[[NSArray alloc]initWithArray:[delegate titlesForXAxis:self]];
                if([_xTitles count]==0)
                {
                    NSLog(@"WARNING:Give values in titlesForXAxis: to give display values on X-Axis.");   
                }
                
                
            }
            else
            {
                NSLog(@"WARNING:If there are any auto-calculated values for X-Axis, they will be displayed, Otherwise Use delegate Method titlesForXAxis: to give display  specific values on X-Axis.");
            }
            
            
            
        }
        
        
    }
    else
    {
        NSLog(@"WARNING:Use delegate Method displayTitlesOnXAxis: to give display values on X-Axis.");
    }

    
   
    
    
    [self initAndWarnings];
    [self setNeedsDisplay];
   // [self drawAnchorPoints];
    
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    for (UIView *view in self.subviews) 
    {
        [view removeFromSuperview];
    }
    

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);
    
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    //Draw the bg gradient
    [self drawBg:context];
    [self drawHorizontalBgLines:context];
    
    int totalColors=[MIMColor sizeOfColorArray];

   
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    
    
    BOOL pickDefaultColorForLineChart;
    NSArray *colorLineChartArray;
    
    
    if([delegate respondsToSelector:@selector(ColorsForBarChart:)])
    {
        colorLineChartArray=[delegate ColorsForBarChart:self];
        if([colorLineChartArray count]==0)
        {
            pickDefaultColorForLineChart=TRUE;
            NSLog(@"WARNING:Color of Line Chart not defined,hence picking up random color.");
            
            
        }
        else
        {
            pickDefaultColorForLineChart=FALSE;
            
        }
        
        
        
    }
    else
    {
        pickDefaultColorForLineChart=TRUE;
        
    }

    
    
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
            NSLog(@"WARNING:animationOnBars delegate method returns nil.");
        }
                
    
    }
   
    //animation block
    float animationDelayValue;
    float animationDurationvalue;
    int animationType;
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
    
    
    
    
    style=rand()%totalColors;
    if(isGradient)
        style=2*style;
    
    // Drawing code
    if(groupBars)
    {
        int barsPerDivision=[[_yValElements objectAtIndex:0] count];
        int SpaceBetweenSameGroupBar=barWidth/10;
        
    
        
        BOOL addOnScrollView=FALSE;
        LineScrollView *lineGScrollView;
        //Find if there needs to be a scrollview
        if(((barsPerDivision * barWidth * [_yValElements count]) + (barsPerDivision-1 * SpaceBetweenSameGroupBar * [_yValElements count]) + (barWidth * [_yValElements count] +1) )>_gridWidth)
        {
            
            lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [lineGScrollView setBackgroundColor:[UIColor clearColor]];
            
            [self addSubview:lineGScrollView];
            
            
            
            addOnScrollView=TRUE;
        }
        
        
        
        
        
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            for (int i=0; i< [[_yValElements objectAtIndex:j] count]; i++) 
            {
                
        
                int _height=[[[_yValElements objectAtIndex:j] objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                    
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin, _gridHeight-_height, barWidth, _height)];

                view.isGradient=isGradient;
                view.horGradient=horizontalGradient;
                    
                if(isGradient)
                {
                    view.dColor=[MIMColor GetColorAtIndex:((2*i)+style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:((2*i)+style)%totalColors];
                }
                else
                    view.color=[MIMColor GetColorAtIndex:(i+style)%totalColors];
                
                    
                    
          
                view.borderColor=[UIColor blackColor];
                    
                //Draw the shadow
                [view.layer setShadowRadius:1.0];
                [view.layer setShadowColor:[UIColor grayColor].CGColor];
                [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
                [view.layer setShadowOpacity:0.8];
                
                
                //animation block
                if(animationOnBars)
                {
                    
                    switch (animationType) 
                    {
                        case 1:
                        default:
                        {
                            
                            float tempHeight=_height;
                            [view setTransform:CGAffineTransformConcat(CGAffineTransformMakeScale(1.0,0.001), CGAffineTransformMakeTranslation(0, tempHeight/2))];
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDelay:animationDelayValue];
                            [UIView setAnimationDuration:animationDurationvalue];
                            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                            [view setTransform:CGAffineTransformConcat( CGAffineTransformMakeTranslation(0, 0.5*(tempHeight-view.bounds.size.height)),CGAffineTransformMakeScale(1.0,1.0))];        
                            [UIView commitAnimations];
                            
                            
                        }
                            break;
                    }
                }

                
                
                if(addOnScrollView)
                    [lineGScrollView addSubview:view];
                else
                    [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=SpaceBetweenSameGroupBar;
                
                xOrigin+=barWidth;
            }
            
            xOrigin+=barWidth;
        }
        
        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, _gridHeight);
        
    }
    else if(stackedBars)
    {

        int barsPerDivision=1;
        int SpaceBetweenSameGroupBar=0;
        
        
        
        BOOL addOnScrollView=FALSE;
        LineScrollView *lineGScrollView;
        //Find if there needs to be a scrollview
        if(((barsPerDivision * barWidth * [_yValElements count]) + (barsPerDivision-1 * SpaceBetweenSameGroupBar * [_yValElements count]) + (barWidth * [_yValElements count] +1) )>_gridWidth)
        {
            
            lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [lineGScrollView setBackgroundColor:[UIColor clearColor]];
            
            [self addSubview:lineGScrollView];
            
            
            
            addOnScrollView=TRUE;
        }
        
        
        
        
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            
            //Find ordered elements of [_yValElements objectAtIndex:j]
            NSArray *stackArray=[_yValElements objectAtIndex:j];
            stackArray=[stackArray sortedArrayUsingFunction:firstNumSort context:NULL];
            
            for (int i=[stackArray count]-1; i >=0; i--) 
            {
                
                
                int _height=[[stackArray objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin, _gridHeight-_height, barWidth, _height)];
                
                view.isGradient=isGradient;
                view.horGradient=horizontalGradient;
                
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
                    view.color=[MIMColor GetColorAtIndex:(i+style)%totalColors];
                
                
                
                
                view.borderColor=[UIColor blackColor];
                
                //Draw the shadow
                [view.layer setShadowRadius:1.0];
                [view.layer setShadowColor:[UIColor grayColor].CGColor];
                [view.layer setShadowOffset:CGSizeMake(2.0, -1.0)];
                [view.layer setShadowOpacity:0.8];
                
                
                //animation block
                if(animationOnBars)
                {
                    
                    switch (animationType) 
                    {
                        case 1:
                        default:
                        {
                            
                            float tempHeight=_height;
                            [view setTransform:CGAffineTransformConcat(CGAffineTransformMakeScale(1.0,0.001), CGAffineTransformMakeTranslation(0, tempHeight/2))];
                            [UIView beginAnimations:nil context:nil];
                            [UIView setAnimationDelay:animationDelayValue];
                            [UIView setAnimationDuration:animationDurationvalue];
                            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                            [view setTransform:CGAffineTransformConcat( CGAffineTransformMakeTranslation(0, 0.5*(tempHeight-view.bounds.size.height)),CGAffineTransformMakeScale(1.0,1.0))];        
                            [UIView commitAnimations];
                            
                            
                        }
                            break;
                    }
                }

                
                
                if(addOnScrollView)
                    [lineGScrollView addSubview:view];
                else
                    [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=SpaceBetweenSameGroupBar;
                
            }
            
            xOrigin+=(barWidth+10);
        }
        
        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, _gridHeight);

    }
    else
    {
       
        BOOL addOnScrollView=FALSE;
        LineScrollView *lineGScrollView;
        //Find if there needs to be a scrollview
        if((([_yValElements count]* barWidth) + 10*([_yValElements count]+1))>_gridWidth)
        {
        
            lineGScrollView.tag=LINESCROLLVIEWTAG;
            lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [lineGScrollView setBackgroundColor:[UIColor clearColor]];
            lineGScrollView.contentSize=CGSizeMake((([_yValElements count]* barWidth) + 10*([_yValElements count]+2)), _gridHeight);
            [self addSubview:lineGScrollView];
            
        
            
            addOnScrollView=TRUE;
        }
        
        
        
        isLongGraph_=addOnScrollView;
                
        for (int i=0; i<[_yValElements count]; i++) 
        { 
            
            int _height=[[_yValElements objectAtIndex:i] floatValue]*_scalingY;
            BarView *view=[[BarView alloc]initWithFrame:CGRectMake((i* barWidth) + 10*(i+1), _gridHeight-_height, barWidth, _height)];
            view.isGradient=isGradient;
            view.horGradient=horizontalGradient;


            
            
            if(pickDefaultColorForLineChart)
            {
                
                if(isGradient)
                {
                    view.dColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:(style)%totalColors];
                }
                else
                    view.color=[MIMColor GetColorAtIndex:style%totalColors];
            
            }
            else 
            {
                
            }
            
            
            

            
            
            //Draw the shadow
            [view.layer setShadowRadius:1.0];
            [view.layer setShadowColor:[UIColor grayColor].CGColor];
            [view.layer setShadowOffset:CGSizeMake(2.0, 1.0)];
            [view.layer setShadowOpacity:0.8];

             //animation block
            if(animationOnBars)
            {
                
                switch (animationType) 
                {
                    case 1:
                    default:
                    {
                       
                        float tempHeight=_height;
                        [view setTransform:CGAffineTransformConcat(CGAffineTransformMakeScale(1.0,0.001), CGAffineTransformMakeTranslation(0, tempHeight/2))];
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDelay:animationDelayValue];
                        [UIView setAnimationDuration:animationDurationvalue];
                        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                        [view setTransform:CGAffineTransformConcat( CGAffineTransformMakeTranslation(0, 0.5*(tempHeight-view.bounds.size.height)),CGAffineTransformMakeScale(1.0,1.0))];        
                        [UIView commitAnimations];
                        
                    
                    }
                        break;
                }
            }
            
            
            
            if(addOnScrollView)
                [lineGScrollView addSubview:view];
            else
                [self addSubview:view];
            
            
            if(isLongGraph_) 
            {
                [lineGScrollView addSubview:[self viewWithTag:XBANDTAG]];
                CGRect a=lineGScrollView.frame;
                a.size.height+=50;
                lineGScrollView.frame=a;
            }            
            
        }
    
    }
    
    
   
}

-(void)drawBg:(CGContextRef)context
{
    
 
    //Check if background color delegate method exists
    MIMColorClass *bgColor=nil;

    if([delegate respondsToSelector:@selector(colorForBackground:)])
    {
        bgColor=[delegate colorForBackground:self];

        if(bgColor!=nil)
        {
            CGContextSetFillColorWithColor(context, [UIColor colorWithRed:bgColor.red green:bgColor.green blue:bgColor.blue alpha:bgColor.alpha].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, _gridWidth, _gridHeight));
        }
        
    }

    if(bgColor==nil)
    {
        //Draw the background with the gray Gradient
        float _viewWidth=self.frame.size.width;
        float _viewHeight=self.frame.size.height;
        
        
        
        CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
        CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
            0.98, 0.98, 0.98 , 1.0,  // Start color
            0.85, 0.85, 0.85 , 1.0 }; // Mid color and End color
        CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
        
        
        CGPoint startBg = CGPointMake(_viewWidth/2,_viewHeight/2); 
        CGFloat endRadius=MAX(_viewWidth/2, _viewHeight/2);
        
        
        CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
        CGColorSpaceRelease(BgRGBColorspace);
        CGGradientRelease(bgRadialGradient);
    }
    
    
    
}
-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    
    
    float widthOfLine;
    MIMColorClass *colorOfLine;
    
    //Check if width and color of line can be accessed by delegate methods
    if([delegate respondsToSelector:@selector(widthOfHorizontalLines:)])
    {
        widthOfLine=[delegate widthOfHorizontalLines:self];
        if(widthOfLine==0)
            NSLog(@"WARNING: Line width of horizontal line is 0.");
        
    }
    else
    {
        widthOfLine=0.1;
        
    }
    
    if([delegate respondsToSelector:@selector(colorOfHorizontalLines:)])
    {
        colorOfLine=[delegate colorOfHorizontalLines:self];    
        if(colorOfLine==nil)
            NSLog(@"WARNING:No color defined for vertical line.");
    }
    else
    {
        colorOfLine=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
    }

    
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:colorOfLine.red green:colorOfLine.green blue:colorOfLine.blue alpha:colorOfLine.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    int numHorzLines=_gridHeight/_tileHeight;
    for (int i=0; i<=numHorzLines; i++) {
        
        CGContextMoveToPoint(ctx, 0,i*_tileHeight);
        CGContextAddLineToPoint(ctx,_gridWidth , i*_tileHeight);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    if (xTitleStyle==0)
        xTitleStyle=X_TITLES_STYLE1;
    
    [self _displayXAxisWithStyle:xTitleStyle WithColorRed:colorOfLine.red Blue:colorOfLine.blue Green:colorOfLine.green Alpha:colorOfLine.alpha];

    
    
    //Display Y Axis elements
    [self _displayYAxisWithColorRed:colorOfLine.red Blue:colorOfLine.blue Green:colorOfLine.green Alpha:colorOfLine.alpha];
    
    
}


-(void)_displayYAxisWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha
{
    if([delegate respondsToSelector:@selector(displayTitlesOnYAxis:)])
    {
        BOOL displayY=[delegate displayTitlesOnYAxis:self];
        if(displayY)
        {
            YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame))];
            _yBand.lineColor=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:alpha];
            [_yBand setScaleForYTile:pixelsPerTile withNumOfLines:numOfHLines];
            [self addSubview:_yBand];
        }
        
        
    }
    else
    {
        NSLog(@"WARNING:Use delegate method displayTitlesOnYAxis, to display titles on Y Axis.");
        
    }
    
    
}



-(void)_displayXAxisWithStyle:(int)xstyle WithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha
{
    
    gapBetweenBars=10;
    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    _xBand.xElements=[[NSArray alloc]initWithArray:_xTitles];
    _xBand.style=xstyle;
    _xBand.tag=XBANDTAG;
    _xBand.xIsString=xIsString;
    _xBand.barChart=YES;
    _xBand.scalingFactor=barWidth;
    _xBand.gapDistance=gapBetweenBars;
    
    float widthOfLine;
    
    
    //Check if width and color of line can be accessed by delegate methods
    if([delegate respondsToSelector:@selector(widthOfHorizontalLines:)])
    {
        widthOfLine=[delegate widthOfHorizontalLines:self];
        if(widthOfLine==0)
            NSLog(@"WARNING: Line width of horizontal line is 0.");
        
    }
    else
    {
        widthOfLine=0.1;
        
    }
    _xBand.lineWidth=widthOfLine;
    _xBand.lineColor=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:alpha];
    
    
    [self addSubview:_xBand];
    
}

- (void)dealloc
{
    ////[super dealloc];
}

@end
