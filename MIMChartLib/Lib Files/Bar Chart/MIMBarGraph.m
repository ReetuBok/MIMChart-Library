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

#import "MIMBarGraph.h"

@interface MIMBarGraph()
{
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    NSMutableArray *myPathArray;
    
    NSMutableArray *aPropertiesArray;
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
    int itemCountOnXAxis;
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
    

    float gapBetweenBars; // for now it is 10 fixed.needs to be variable
    float gapBetweenBarsDifferentGroup;
    BOOL isLongGraph_;
    float contentSizeX;
    float barYOffsetForNegativeGraphs;
    
    BOOL pickLibColors;
    BOOL transparentBgForStackedBars;
    
    float yAxisWidth;
    float xAxisHeight;
    BOOL drawLineNow;
    NSArray *yLineValueArray;
    
    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
    

}
@end

#define TITLELABEL 1001

@implementation MIMBarGraph
@synthesize groupTitlesOffset,gradientStyle,glossStyle,minimumLabelOnYIsZero;
@synthesize delegate,xTitleStyle,mbackgroundcolor,barcolorArray;
@synthesize style,barLabelStyle,margin,titleLabel;
@synthesize floatingView;
@synthesize barGraphStyle;

static NSInteger firstNumSort(id str1, id str2, void *context) {
    
    int num1 = [str1 integerValue];
    int num2 = [str2 integerValue];
    
    if (num1 < num2)
        return NSOrderedAscending;
    else if (num1 > num2)
        return NSOrderedDescending;
    
    return NSOrderedSame;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self doInit];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self doInit];
    return self;
}

- (void)doInit
{
    // Initialization code
    rightMargin=0;
    topMargin=0;
    leftMargin=0;
    bottomMargin=0;
    
    yAxisWidth=50;
    xAxisHeight=70;
    barGraphStyle=BAR_GRAPH_STYLE_DEFAULT;
    gradientStyle=NONE_GRADIENT_STYLE;
    glossStyle=GLOSS_NONE;//Default there is no gloss
    xTitleStyle=XTitleStyle1;
    barYOffsetForNegativeGraphs=0;
    animationType=0;
    [self setBackgroundColor:[UIColor clearColor]];
    
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.tag=TITLELABEL;
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [self addSubview:titleLabel];
    
    titleLabel.text=@"Bar Chart Title";
    
  
}


-(void)drawBarChart
{

    //offsetXLabelOnLongGraph=0;
    //Get the margins
    rightMargin=margin.rightMargin;
    topMargin=margin.topMargin;
    leftMargin=margin.leftMargin;
    bottomMargin=margin.bottomMargin;
    
    
    [self getAnimationProperties];
    [self initAndWarnings];
    if([_yValElements count]==0)return;
    
    [self createLongBarGraphScrollView];
  
    titleLabel.frame=CGRectMake(leftMargin, topMargin+_gridHeight+xAxisHeight+5, CGRectGetWidth(self.frame)-leftMargin-rightMargin, 20);
    
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
    
    //[self setNeedsDisplay];
  
}

-(void)reloadBarChartWithAnimation
{
    NSLog(@"reloadBarChartWithAnimation");
    
    [_yValElements removeAllObjects];
    

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
    
    
    
    
    
    BOOL recalculation=[self findIfRecalculatingYScalingIsRequired];
   
    if(recalculation)
    {
        [self _findScaleForYTile];
        [[self viewWithTag:YBANDTAG] removeFromSuperview];
        [self _displayYAxisLabels];
    }
    
    // Drawing code
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
    {
        
        for (int j=0; j<[_yValElements count]; j++) 
        {
            for (int i=0; i< [[_yValElements objectAtIndex:j] count]; i++) 
            {
                
                
                
                int _height=[[[_yValElements objectAtIndex:j] objectAtIndex:i] intValue];
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)_height=-_height;
                
                
                BarView *view;
                if(isLongGraph_)
                {
                    view =(BarView *)[lineGScrollView viewWithTag:300*j +i +1];
                }
                else
                {
                    view =(BarView *)[self viewWithTag:300*j +i+1];
                    
                }
                

                
                [UIView beginAnimations:[NSString stringWithFormat:@"%i",300*j +i +1] context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.5];
                
                
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                
                CGRect a=view.frame;
                a.origin.y=originY+topMargin;
                a.size.height=_height;
                view.frame=a;
                
                [UIView commitAnimations];
                
                
           
            }
            
        }
        
     
        
        
    }
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
    {
        
        for (int j=0; j<[_yValElements count]; j++) 
        {
            
            NSArray *stackArray=[_yValElements objectAtIndex:j];
            float totalQ=[[stackArray lastObject] floatValue];
            int heightOffset=0;
            for (int i=[stackArray count]-2; i >=0; i--) 
            {
                
                BOOL isNegativeBar=FALSE;
                
                int _height=[[stackArray objectAtIndex:i] intValue]*.01*totalQ;
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)isNegativeBar=TRUE;
                if(_height<0)_height=-_height;
                
                
                
                BarView *view;
                if(isLongGraph_)
                {
                    view =(BarView *)[lineGScrollView viewWithTag:300*j +i +1];
                }
                else
                {
                    view =(BarView *)[self viewWithTag:300*j +i +1];
                    
                }
                
                [UIView beginAnimations:[NSString stringWithFormat:@"%i",300*j +i +1] context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDuration:0.5];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                
                CGRect a=view.frame;
                a.origin.y=originY+topMargin-heightOffset;
                a.size.height=_height;
                view.frame=a;
                
                [UIView commitAnimations]; 
                heightOffset+=_height;
                
            }
            
        
        }
        
        
    
    }
    else
    {

        for (int i=0; i<[_yValElements count]; i++) 
        { 
            
            int _height=[[_yValElements objectAtIndex:i] intValue]*_scalingY;
            float originY;
            if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
            else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
            
            if(_height<0)_height=-_height;
            
            
            BarView *view;
            if(isLongGraph_)
            {
                view =(BarView *)[lineGScrollView viewWithTag:300+i];
            }
            else
            {
                view =(BarView *)[self viewWithTag:300+i];

            }

            [UIView beginAnimations:[NSString stringWithFormat:@"%i",300+i] context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.5];
            
        
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            
            CGRect a=view.frame;
            a.origin.y=originY+topMargin;
            a.size.height=_height;
            view.frame=a;
            
            [UIView commitAnimations];
            
            
 
        }
        
        
    }
    
    
    
    
}

- (void) animationDone:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    int tagid=[animationID intValue];

    
    
    BOOL isNegativeBar=FALSE;

    int _height=[[_yValElements objectAtIndex:tagid-300] floatValue]*_scalingY;
    float originY;
    if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
    else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;

    if(_height<0)isNegativeBar=TRUE;
    if(_height<0)_height=-_height;


    
    BarView *view;
    if(isLongGraph_)
    {
        view =(BarView *)[lineGScrollView viewWithTag:tagid];
    }
    else
    {
        view =(BarView *)[self viewWithTag:tagid];

    }

    
    CGRect a=view.frame;
    a.origin.y=originY+topMargin;
    a.size.height=_height;
    view.frame=a;

    
}

-(BOOL)findIfRecalculatingYScalingIsRequired
{
    BOOL required=FALSE;
    
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
    {
        
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
                 
                
                 if(abs(_height)>_gridHeight)
                 {
                     required=TRUE;
                     break;
                 }
             
             }
         

         }
                
    }
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
    {
         
         for (int j=0; j<[_yValElements count]; j++) 
         {
         
             NSArray *stackArray=[_yValElements objectAtIndex:j];
             float totalQ=[[stackArray lastObject] floatValue];
       
                 
             
             for (int i=[stackArray count]-2; i >=0; i--) 
             {
             
             BOOL isNegativeBar=FALSE;
             
             int _height=[[stackArray objectAtIndex:i] intValue]*.01*totalQ;
             _height=_height*_scalingY;
             
             float originY;
             if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
             else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
             
             if(_height<0)isNegativeBar=TRUE;
             if(_height<0)_height=-_height;
             
             
             
                 if(abs(_height)>_gridHeight)
                 {
                     required=TRUE;
                     break;
                 }
             }
    
         }
            
    }
    else
    {
        for (int i=0; i<[_yValElements count]; i++) 
        { 
            BOOL isNegativeBar=FALSE;
            
            
            int _height=[[_yValElements objectAtIndex:i] intValue]*_scalingY;
            float originY;
            if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
            else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
            
            if(_height<0)isNegativeBar=TRUE;
            if(_height<0)_height=-_height;
            
            if(abs(_height)>_gridHeight)
            {
                required=TRUE;
                break;
            }
            
        }

    }
    return required;
    
}

#pragma mark - LINE CHART OVER BARS

-(void)drawLines:(NSArray *)pathArray
{
    //Draw with yellow color for now.
    //Draw the bexier path arra
    NSLog(@"drawLines:minimumOnY=%f",minimumOnY);
    
    yLineValueArray=[[NSArray alloc]initWithArray:pathArray];
    
    drawLineNow=TRUE;
    //[self setNeedsDisplay];

    
    

}


-(void)removeLines
{
    NSLog(@"removeLines :minimumOnY=%f",minimumOnY);
    drawLineNow=FALSE;
    //[self setNeedsDisplay];


}

#pragma mark - Internal Drawing Method

-(void)initAndWarnings
{
    //reMove everythng which is there
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    srand(time(NULL));
    isLongGraph_=FALSE;
    
    
    _xValElements=[[NSMutableArray alloc]init];
    
    
    if([delegate respondsToSelector:@selector(valuesForGraph:)])
    {
        NSArray *valueArray_=[delegate valuesForGraph:self];
        if([valueArray_ count]==0)return;
        
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available to draw graph.");
        
        //See if the its an array or array or just one array
        if([valueArray_ count]>0)
        {
            _yValElements=[[NSMutableArray alloc]initWithArray:valueArray_];
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
        if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED || barGraphStyle==BAR_GRAPH_STYLE_STACKED)
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
        NSAssert(([_xTitles count] !=0),@"WARNING::No values available for x-Axis Labels.");
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
    }
    
    
    if (barGraphStyle==BAR_GRAPH_STYLE_GROUPED || barGraphStyle==BAR_GRAPH_STYLE_STACKED)  barWidth=30;
    else  barWidth=40;
    
    if([delegate respondsToSelector:@selector(barProperties:)])
    {
        barProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate barProperties:self]];        
        if(barProperties !=nil)
        {
            if([barProperties objectForKey:@"barwidth"])
                barWidth=[[barProperties valueForKey:@"barwidth"] floatValue];
        }
    }
    
    
    if([delegate respondsToSelector:@selector(AnchorProperties:)])
        if([delegate AnchorProperties:self]!=nil)
        {
            aPropertiesArray=[[NSMutableArray alloc]initWithArray:[delegate AnchorProperties:self]];
        }
    
    
    
    
    //Horizontal Seperator Line
    if([delegate respondsToSelector:@selector(horizontalLinesProperties:)])
        hlProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate horizontalLinesProperties:self]];
    else
        hlProperties=[[NSMutableDictionary alloc]init];
    
    //Vertical Seperator Line
    if([delegate respondsToSelector:@selector(verticalLinesProperties:)])
        vlProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate verticalLinesProperties:self]];
    else
        vlProperties=[[NSMutableDictionary alloc]init];
    
    
    
    if([delegate respondsToSelector:@selector(xAxisProperties:)])
        xLProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate xAxisProperties:self]];
    else
        xLProperties=[[NSMutableDictionary alloc]init];
    
    //Y-Axis
    if([delegate respondsToSelector:@selector(yAxisProperties:)])
        yLProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate yAxisProperties:self]];
    else
        yLProperties=[[NSMutableDictionary alloc]init];

    
    

    if([yLProperties valueForKey:@"width"])
        yAxisWidth=[[yLProperties valueForKey:@"width"] floatValue];
    
    if([xLProperties valueForKey:@"height"])
        xAxisHeight=[[xLProperties valueForKey:@"height"] floatValue];


    if(barGraphStyle==BAR_GRAPH_STYLE_STACKED && rand()%2==1)[MIMColor InitFragmentedBarColors];
    else [MIMColor nonAdjacentGradient];
    
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
    _gridWidth=[MIMProperties CalculateGridWidth:_gridWidth leftMargin:leftMargin rightMargin:rightMargin yAxisSpace:yAxisWidth];
    
    _gridHeight=self.frame.size.height;
    _gridHeight=[MIMProperties CalculateGridHeight:_gridHeight bottomMargin:bottomMargin topMargin:topMargin xAxisSpace:xAxisHeight];
    
}

-(void)FindTileWidthAndHeight
{
    itemCountOnXAxis=[MIMProperties countXValuesInArray:_xValElements];
    
    
    //[self FindTileWidthAndHeight];
    _tileHeight=[MIMProperties FindTileHeight:hlProperties GridHeight:_gridHeight];
    _tileWidth=[MIMProperties FindTileWidth:vlProperties GridWidth:_gridWidth xItemsCount:itemCountOnXAxis];
    
    
    /*
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
    
    
    if(_tileHeight+10 > _gridHeight)
    {
        NSLog(@"ERROR: frame too small to draw.!!");
        
    }
     */
    
    
    
}

-(void)ScalingFactor
{
    [self _findScaleForYTile];
    [self _findScaleForXTile];

}

-(void)_findScaleForYTile
{
    
    //WE need to figure out if tileHeight*numOfHLines + 10 >=_gridHeight
    //If not, then try reducing numOfHLines
    numOfHLines=_gridHeight/_tileHeight;
    
    if(numOfHLines < 3)
        _tileHeight=[MIMProperties fixTileHeight:_gridHeight];
    
    float minOfY=[MIMProperties findGlobalMinimum:_yValElements];
    float minOfYLine=[MIM_MathClass getMinFloatValue:yLineValueArray];//[MIMProperties findGlobalMinimum:[NSMutableArray arrayWithArray:yLineValueArray]];
    if(minOfYLine<minOfY)minOfY=minOfYLine;
    //minOfY=0;//
    
    float maxOfY=[MIMProperties findGlobalMaximum:_yValElements];
    float maxOfYLine=[MIM_MathClass getMaxFloatValue:yLineValueArray];
    if(maxOfYLine>maxOfY)maxOfY=maxOfYLine;
    
    
    minimumOnY=[MIMProperties findMinimumOnY:minOfY];
    _scalingY=[MIMProperties findScaleForYTile:_yValElements gridHeight:_gridHeight tileHeight:_tileHeight :numOfHLines Min:minOfY Max:maxOfY];
    pixelsPerTile=_tileHeight/_scalingY;
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED || barGraphStyle==BAR_GRAPH_STYLE_STACKED)
         barYOffsetForNegativeGraphs=fabsf(minimumOnY)*_scalingY;
    

    return;
    /*
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
    
    
    
    
    
    float pixelPerTile;
    int divider=HorLines;
    
    
    if(HorLines<=3)divider=3;
    else divider=HorLines-1;
    
    
    
    if(maxOfY==minOfY) pixelPerTile=(maxOfY)/divider;
    else pixelPerTile=(maxOfY)/divider;
    
    
    
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
    else{
    
        
        countDigits=[[NSString stringWithFormat:@"%.0f",fabs(minOfY)] length];
        minimumOnY=minOfY/pow(10, countDigits-1);
        minimumOnY=floorf(minimumOnY);
        minimumOnY=minimumOnY*pow(10, countDigits-1);
    
        
    
    }
     
     */

    
}


-(void)_findScaleForXTile
{
    int count=0;
    
   
    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]] || [[_xValElements objectAtIndex:0] isKindOfClass:[NSNumber class]])
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
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
    {
        
        barsPerDivision=[[_yValElements objectAtIndex:0] count];

        
        if([barProperties valueForKey:@"gapBetweenBars"]) 
            spaceBetweenSameGroupBar=[[barProperties valueForKey:@"gapBetweenBars"] floatValue];
        else 
            spaceBetweenSameGroupBar=barWidth/10;
        
        
        if([barProperties valueForKey:@"gapBetweenGroup"]) 
            gapBetweenBarsDifferentGroup=[[barProperties valueForKey:@"gapBetweenGroup"] floatValue];
        else 
            gapBetweenBarsDifferentGroup=barWidth;
        
        
        contentSizeX=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            for (int i=0; i< [[_yValElements objectAtIndex:j] count]; i++) 
            {
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    contentSizeX+=spaceBetweenSameGroupBar;
                
                contentSizeX+=barWidth;
            }
            
            contentSizeX+=gapBetweenBarsDifferentGroup;
        }
        
        contentSizeX+=barWidth;
        
        
        

        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
        
    }
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
    {
        
        barsPerDivision=1;
        spaceBetweenSameGroupBar=0;
        gapBetweenBarsDifferentGroup=barWidth;
        
        contentSizeX=(barsPerDivision * barWidth * yCount) + (barsPerDivision-1 * spaceBetweenSameGroupBar * yCount) + (barWidth * yCount +1) ;
        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
    }
    else
    {
        if([barProperties valueForKey:@"gapBetweenBars"])
            spaceBetweenSameGroupBar=[[barProperties valueForKey:@"gapBetweenBars"] floatValue];
        else
            spaceBetweenSameGroupBar=10;
        

        contentSizeX=(yCount* barWidth) + spaceBetweenSameGroupBar*(yCount+1);
        if(contentSizeX>_gridWidth)
        {
            isLongGraph_=TRUE;
        }
        
    }
    
    
    
    if(isLongGraph_)
    {
        float contentHeight=self.frame.size.height-bottomMargin-topMargin;

        
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, topMargin, _gridWidth-10, contentHeight)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];


        lineGScrollView.tag=LINESCROLLVIEWTAG;
        
        [lineGScrollView setShowsHorizontalScrollIndicator:NO];
        [lineGScrollView setShowsVerticalScrollIndicator:NO];

        [self addSubview:lineGScrollView];        
    }
}


//Delegate Methods gets the priority
-(void)getColorArray
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    if([barcolorArray count]>0)
    {
        pickLibColors=FALSE;
        return;
    }
    
    BOOL pickDefaultColor=TRUE;
    if([delegate respondsToSelector:@selector(colorsForBarChart:)])
    {
        barcolorArray=[NSMutableArray arrayWithArray:[delegate colorsForBarChart:self]];
        if(barcolorArray) pickDefaultColor=FALSE;
    }
    
    
    if(pickDefaultColor)
    {
        barcolorArray=[[NSMutableArray alloc]init];
        //if(DEBUG_MODE) NSLog(@"WARNING:Color of Bar Chart not defined,hence picking up random color.");
        
        int totalBarColors =1;
        
        if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED || barGraphStyle==BAR_GRAPH_STYLE_STACKED) totalBarColors=[[_yValElements objectAtIndex:0] count];
        
        for (int i=0; i<totalBarColors; i++) 
            [barcolorArray addObject:[MIMColor GetMIMColorAtIndex:style%totalColors]];

    }
    
    
    pickLibColors=pickDefaultColor;
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
        
        
        animationType=0;
        if ([keysArray containsObject:@"type"]) 
        {
            animationType=[[animationDict valueForKey:@"type"] intValue];
        }
        
        transparentBgForStackedBars=NO;
        if ([keysArray containsObject:@"transparentBg"]) 
        {
            transparentBgForStackedBars=[[animationDict valueForKey:@"transparentBg"] boolValue];
        }
    
        
    }
    

}


-(void)createAnimationOn:(BarView *)view withBarHeight:(float)height negativeBars:(BOOL)negativeBars idValue:(int)idVal
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
                if (idVal!=-1) {
                    [UIView setAnimationDelay: (idVal*animationDurationvalue)+ animationDelayValue];
                }
                else
                [UIView setAnimationDelay:animationDelayValue];
                [UIView setAnimationDelegate:self];
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
    if([view isKindOfClass:[XAxisBand class]] || [view isKindOfClass:[YAxisBand class]] || (view.tag ==TITLELABEL)) {}
    else [view removeFromSuperview];
    
    

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddRect(context, r);      
    CGContextFillPath(context);
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    
    
    
    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);
    
    

    //Draw the bg gradient

    [MIMProperties drawBgPattern:context color:mbackgroundcolor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    [MIMProperties drawHorizontalBgLines:context withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:_gridWidth-5 leftMargin:leftMargin+yAxisWidth topMargin:topMargin];

    CGContextSaveGState(context);
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
   
    float _leftMargin=leftMargin+yAxisWidth;

    
    if(isLongGraph_)
    {
        _leftMargin=0;

        
    }
    
    float contentHeight=self.frame.size.height-bottomMargin-topMargin;

    
    
    if(gradientStyle !=0) style=2*style;
    
    NSLog(@"draw rect %i",self.tag);
    // Drawing code
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
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
     
                
                int originYNew=originY+topMargin;
                if(isLongGraph_)
                    originYNew=originY;
                
                                    
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin+_leftMargin, originYNew, barWidth, _height)];
                view.tag=300*j +i + 1;
                view.gradientStyle=gradientStyle;
                view.glossStyle=glossStyle;
                
                if(isNegativeBar) view.negativeBar=TRUE;
                else view.negativeBar=FALSE;
                
                if(gradientStyle !=0)
                {
                    view.dColor=[MIMColor GetColorAtIndex:((2*i)+style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:((2*i)+style)%totalColors];
                }
                else view.color=[MIMColor GetMIMColorAtIndex:(i+style)%totalColors];

                view.borderColor=[UIColor blackColor];
                    
                //Draw the shadow
                [self drawShadowOnView:view negativeBars:isNegativeBar];

                
                [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar idValue:-1];
                
                
                if(isLongGraph_) 
                    [lineGScrollView addSubview:view];
                else 
                    [self addSubview:view];
                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=spaceBetweenSameGroupBar;
                
                xOrigin+=barWidth;
            }
            
            xOrigin+=gapBetweenBarsDifferentGroup;
        }

        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, contentHeight);
        contentSizeX=xOrigin;
        
     
        
        
    }
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
    {

       
        
        
        int xOrigin=barWidth;
        for (int j=0; j<[_yValElements count]; j++) 
        {
            
            //Find ordered elements of [_yValElements objectAtIndex:j]
            NSArray *stackArray=[_yValElements objectAtIndex:j];

            
            float totalQ=[[stackArray lastObject] floatValue];
            int heightOffset=0;
            float totalHeight=0;
            
            
            for (int i=[stackArray count]-2; i >=0; i--) 
            {
                
                BOOL isNegativeBar=FALSE;
                
                int _height=[[stackArray objectAtIndex:i] intValue]*.01*totalQ;
                _height=_height*_scalingY;
                
                float originY;
                if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
                else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
                
                if(_height<0)isNegativeBar=TRUE;
                if(_height<0)_height=-_height;
                
//                int originYNew=originY+topMargin;
//                if(isLongGraph_)
//                    originYNew=originY;
            
                BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin+_leftMargin,originY+topMargin-heightOffset, barWidth, _height)];
                view.tag=300*j +i +1;
                view.gradientStyle=gradientStyle;
                view.glossStyle=GLOSS_NONE;
                
                if(isNegativeBar) view.negativeBar=TRUE;
                else view.negativeBar=FALSE;
                
                
                
              
                if(gradientStyle !=0)
                {
                    view.dColor=[MIMColor GetColorAtIndex:((2*i)+style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:((2*i)+style)%totalColors];
                }
                else
                    view.color=[MIMColor GetMIMColorAtIndex:(i+style)%totalColors];
                
                
                
                
                view.borderColor=[UIColor blackColor];
                
                [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar idValue:([stackArray count]-1 - i)];
                [self drawShadowOnView:view negativeBars:isNegativeBar];
                
                if(isLongGraph_) [lineGScrollView addSubview:view];
                else [self addSubview:view];
                
                //for gloss
                if (i==0) 
                {
                    
                    
                    BarView *view=[[BarView alloc]initWithFrame:CGRectMake(xOrigin+_leftMargin,originY+topMargin-heightOffset, barWidth, totalHeight)];
                    
                    view.gradientStyle=gradientStyle;
                    view.glossStyle=glossStyle;
                    view.color=[MIMColorClass colorWithComponent:@"1,0,0,0"];
                    
                    if(isNegativeBar) view.negativeBar=TRUE;
                    else view.negativeBar=FALSE;
                    
                    if(isLongGraph_) [lineGScrollView addSubview:view];
                    else [self addSubview:view];
                    
                }
                
                heightOffset+=_height;

                
                if(i<[[_yValElements objectAtIndex:j] count]-1)
                    xOrigin+=spaceBetweenSameGroupBar;
                
                
                               
                
            }
            
            
            
            
            
            xOrigin+=barWidth;
            xOrigin+=gapBetweenBarsDifferentGroup;
        }
        
        
        
        xOrigin+=barWidth;
        lineGScrollView.contentSize=CGSizeMake(xOrigin, contentHeight);
        contentSizeX=xOrigin;
    }
    else
    {
        
        NSLog(@"on bar graph _gridHeight=%f",_gridHeight);
        //NSLog(@"minimumOnY=%f",minimumOnY);
     

        //if (pickLibColors) 
           
        //NSLog(@"Style of view with tag %i is %i , %i",self.tag,style,[_yValElements count]);
        float xOrigin=spaceBetweenSameGroupBar;
        //NSLog(@"minimumOnY=%f",minimumOnY);
        
        for (int i=0; i<[_yValElements count]; i++)
        { 
            BOOL isNegativeBar=FALSE;
            
  
            int _height=[[_yValElements objectAtIndex:i] intValue]-minimumOnY;
            _height=_height*_scalingY;
            

            float originY;
            if(_height<0)originY=_gridHeight-barYOffsetForNegativeGraphs;
            else originY=_gridHeight-_height-barYOffsetForNegativeGraphs;
            
            if(_height<0)isNegativeBar=TRUE;
            if(_height<0)_height=-_height;
            
            int heightInt=(int)_height;
            
            int originYNew=originY+topMargin;
            if(isLongGraph_)
                originYNew=originY;
            
            BarView *view=[[BarView alloc]initWithFrame:CGRectMake((i* barWidth) + spaceBetweenSameGroupBar*(i+1) +_leftMargin,originYNew,barWidth,heightInt)];
            view.alpha=0.7;
            view.delegate=self;
            view.tag=300+i;
            view.gradientStyle=gradientStyle;
            view.glossStyle=glossStyle;
            if(isNegativeBar) view.negativeBar=TRUE;
            else view.negativeBar=FALSE;
            
            if(gradientStyle !=0)
            {
                
                if(pickLibColors)
                {
                    //Colors of gradients NOT provided by user.
                    view.dColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
                    view.lColor=[MIMColor GetColorAtIndex:(style)%totalColors];
                }
                else
                {
                    if([barcolorArray count]==1)
                    {
                        //Only 1 Color of gradients IS provided by user.
                        MIMColorClass *l=[barcolorArray objectAtIndex:0];
                        view.dColor=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:l.red],@"red",[NSNumber numberWithFloat:l.green],@"green",[NSNumber numberWithFloat:l.blue],@"blue",[NSNumber numberWithFloat:l.alpha],@"alpha", nil];
                        
                        view.lColor=nil;
                    }
                    else if([barcolorArray count]==2)
                    {
                        //Colors of gradients ARE provided by user.
                        MIMColorClass *l=[barcolorArray objectAtIndex:0];
                        MIMColorClass *d=[barcolorArray objectAtIndex:1];

                        
                        view.dColor=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:d.red],@"red",[NSNumber numberWithFloat:d.green],@"green",[NSNumber numberWithFloat:d.blue],@"blue",[NSNumber numberWithFloat:d.alpha],@"alpha", nil];
                        view.lColor=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:l.red],@"red",[NSNumber numberWithFloat:l.green],@"green",[NSNumber numberWithFloat:l.blue],@"blue",[NSNumber numberWithFloat:l.alpha],@"alpha", nil];
                    }
                }
                
                
            }
            else
            {
                if(isNegativeBar && ([barcolorArray count]==2))
                {
                    if([[_yValElements objectAtIndex:i] floatValue] > 0)view.color=[barcolorArray objectAtIndex:0];
                            else view.color=[barcolorArray objectAtIndex:1];
                    
                }
                else
                    view.color=[barcolorArray objectAtIndex:0];
                
            }
        
            xOrigin+=spaceBetweenSameGroupBar;
            xOrigin+=barWidth;
            
            [self drawShadowOnView:view negativeBars:isNegativeBar];
            [self createAnimationOn:view withBarHeight:_height negativeBars:isNegativeBar idValue:-1];
             
            
            
            if(isLongGraph_)[lineGScrollView addSubview:view];
            else [self addSubview:view];
            
            
            
                      
            
        }
        
        if(isLongGraph_)  
            lineGScrollView.contentSize=CGSizeMake(xOrigin, contentHeight);
        contentSizeX=xOrigin;
        
    }
    
    
    [self drawBarInfoBoxForGraph];

    if(isLongGraph_ && barGraphStyle==BAR_GRAPH_STYLE_STACKED)
        lineGScrollView.contentSize=CGSizeMake(contentSizeX, contentHeight);

    if(isLongGraph_)
    {  
        
        [[lineGScrollView viewWithTag: XBANDTAG] setFrame:CGRectMake(0,_gridHeight, contentSizeX, xAxisHeight)];
        CGRect a=lineGScrollView.frame;
        a.size.height+=X_AXIS_HEIGHT;
        lineGScrollView.frame=a;
        [self addSubview:lineGScrollView];  
    } 

    
    
    if(drawLineNow)
    {
        
        
        float _leftMargin=leftMargin+yAxisWidth;
        float _bottomMargin=bottomMargin+xAxisHeight;
      
        
        
        if(!myPathArray)
        myPathArray=[[NSMutableArray alloc]init];
        else
            [myPathArray removeAllObjects];
  
        
        
        if(isLongGraph_)
        {
            _leftMargin=0;
            _bottomMargin=0;
        }
        
        //Create the Bezier Path
        UIBezierPath *lineBezierPath=[[UIBezierPath alloc]init];
        lineBezierPath.lineWidth=1.0;
        lineBezierPath.lineJoinStyle=kCGLineJoinRound;
        
        NSLog(@"line draw now : minimumOnY=%f",minimumOnY);
        
        for (int l=0; l<[yLineValueArray count]; l++)
        {
            float valueY=[[yLineValueArray objectAtIndex:l] floatValue]-minimumOnY;
            float valueX;
            if(xIsString)
                valueX=(float)l;
            else
                valueX=[[_xValElements objectAtIndex:l] floatValue];
            
            float mX=(barWidth*0.5)+(valueX*barWidth)+ spaceBetweenSameGroupBar*(l+1) +_leftMargin;//(i* barWidth) + spaceBetweenSameGroupBar*(i+1)
            float mY=valueY*_scalingY+ _bottomMargin;
            
            if (isLongGraph_) {
                
                mY+=xAxisHeight;
            }
            //NSLog(@"bar line y=%f",mY);
            
            if(l==0)
                [lineBezierPath moveToPoint:CGPointMake(mX,mY)];
            else
                [lineBezierPath addLineToPoint:CGPointMake(mX,mY)];
            
        }
        
        
        [myPathArray addObject:lineBezierPath];
        
        
        if(isLongGraph_)
        {
            CGContextRestoreGState(context);
            
            for (UIView *view in lineGScrollView.subviews)
            if([view isKindOfClass:[MultiLineLongGraph class]])
            {
                [view removeFromSuperview];
            }
        
            //Needs to be changed, should be an array
            NSDictionary *aProperties=[self aPropertiesDictAtIndex:0];
            
            
            float contentHeight=self.frame.size.height-bottomMargin-topMargin;
            
            MultiLineLongGraph *graph=[[MultiLineLongGraph alloc]initWithFrame:CGRectMake(0, 0, contentSizeX, contentHeight)];
            graph.gridHeight=_gridHeight;
            graph.scalingX=barWidth;
            graph.scalingY=_scalingY;
            graph.xIsString=xIsString;
            graph.xOffset=0;
            graph.barOffset=spaceBetweenSameGroupBar;
            graph.lineColorArray=[NSArray arrayWithObjects:[MIMColorClass colorWithRed:255 Green:0 Blue:0 Alpha:255], nil];
            graph.lineBezierPath=myPathArray;
            graph.aPropertiesArray=[NSMutableArray arrayWithObjects:aProperties,nil];
            graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
            graph.yValElements=[[NSMutableArray alloc]initWithArray:yLineValueArray];
            //graph.anchorTypeArray=[[NSMutableArray alloc]initWithArray:yLineValueArray];
            graph.anchorTypeArray=[[NSMutableArray alloc]initWithArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:CIRCLEFILLED], nil]];
            graph.minimumOnY=minimumOnY;
            graph.leftMargin=leftMargin;
            graph.bottomMargin=bottomMargin;
            graph.xAxisHeight=xAxisHeight;
            [lineGScrollView addSubview:graph];
            
            
            
            return;
            
        }
        
        for (int i=0; i<[myPathArray count]; i++)
        {
            
            UIColor *_color=[[UIColor alloc]initWithRed:1 green:0 blue:0 alpha:1.0];
            [_color setStroke];
            UIBezierPath *myP=[myPathArray objectAtIndex:i];
            [myP setLineWidth:1.0];
            [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
            
        }
        
        CGContextRestoreGState(context);
        [self _drawAnchorPoints];
        
        
    }
    
   
    
    
}

-(NSDictionary *)aPropertiesDictAtIndex:(int)index
{
    NSMutableDictionary *aProperties;
    if ([aPropertiesArray count]>index)
        aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
    else
        aProperties=[[NSMutableDictionary alloc] init];
    
    
    
    if([aProperties valueForKey:@"hide"])
        if([[aProperties valueForKey:@"hide"] boolValue])
            return nil;
    
    
    
    
    float red=1;
    float green=0;
    float blue=0;
    float alpha=255;
    
    
    
    if(![aProperties valueForKey:@"fillColor"])
        [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
    
    
    
    
    [aProperties setValue:@"2" forKey:@"style"];
    [aProperties setValue:@"5" forKey:@"radius"];
    
    return aProperties;
}

-(void)_drawAnchorPoints
{
    //Remove Any if there from previous draw
    for (UIView *view in self.subviews)
        if([view isKindOfClass:[Anchor class]])
        {
            [view removeFromSuperview];
        }
    
    
    
    
    for (int index=0; index<[myPathArray count]; index++)
    {
        
        
        NSDictionary *aProperties=[self aPropertiesDictAtIndex:index];
        
        if([[yLineValueArray objectAtIndex:index] isKindOfClass:[NSString class]]||[[yLineValueArray objectAtIndex:index] isKindOfClass:[NSNumber class]])
        {
            for (int l=0; l<[yLineValueArray count]; l++)
            {
                float valueY=[[yLineValueArray objectAtIndex:l] floatValue]-minimumOnY;
                if(valueY < 0)valueY=0;
                
                float valueX;
                if(xIsString)
                    valueX=(float)l;
                else
                    valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                

                
                
                //NSLog(@"_scalingX=%f,%f",_scalingX,_scalingY);
                float mX=barWidth/2+ valueX*barWidth+ leftMargin+yAxisWidth + spaceBetweenSameGroupBar*(l+1);
                
                
                float mY=valueY*_scalingY;
                mY=_gridHeight-mY;
                mY+=topMargin;
                
                Anchor *anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
                anchor.center=CGPointMake(mX,mY);
                anchor.properties=aProperties;
                anchor.anchorTag=l;
                anchor.delegate=self;
                [self addSubview:anchor];
                [anchor drawAnchor];
                
            }
            
        }
        else
        {
            for (int k=index; k<index+1; k++)
            {

                NSArray *yArray_=[yLineValueArray objectAtIndex:k];
                
                for (int l=0; l<[yArray_ count]; l++)
                {
                    float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                    if(valueY < 0)valueY=0;
                    
                    float valueX;
                    if(xIsString)
                        valueX=(float)l;
                    else
                        valueX=[[_xValElements objectAtIndex:l] floatValue];
                    
                    
                    
                    
                    float mX=valueX*_scalingX+ leftMargin+yAxisWidth;
                    float mY=valueY*_scalingY;
                    mY=_gridHeight-mY;
                    mY+=topMargin;
                    
                    Anchor *anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
                    anchor.center=CGPointMake(mX,mY);
                    anchor.properties=aProperties;
                    anchor.anchorTag=l;
                    anchor.delegate=self;
                    [self addSubview:anchor];
                    [anchor drawAnchor];
                }
                
            }
        }
        
        
    }
    
}

-(void)drawShadowOnView:(BarView *)view  negativeBars:(BOOL)isNegativeBar
{
    //Draw the shadow
    BOOL drawShadow=FALSE;
    if(![barProperties objectForKey:@"shadow"])
    {
        drawShadow=TRUE;
    }
    else
    {
        if([[barProperties valueForKey:@"shadow"] boolValue]==YES) 
            drawShadow=TRUE;
        
    }
    
    if(drawShadow)
    {
        float shadowRadius=1.0;
        if([barProperties valueForKey:@"shadowRadius"])
            shadowRadius=[[barProperties valueForKey:@"shadowRadius"] floatValue];
        
        UIColor *shadowColor=[UIColor grayColor];
        if([barProperties valueForKey:@"shadowColor"])
        {
            MIMColorClass *sC=[barProperties valueForKey:@"shadowColor"];
            shadowColor=[UIColor colorWithRed:sC.red green:sC.green blue:sC.blue alpha:sC.alpha];
        }
        
        float xShadowOffset=2.0;
        float yShadowOffset=0.0;
        if([barProperties valueForKey:@"shadowOffset"])
        {
            CGSize shadowSize=[[barProperties valueForKey:@"shadowOffset"] CGSizeValue];
            xShadowOffset=shadowSize.width;
            yShadowOffset=shadowSize.height;
        }
        
        float shadowOpacity=0.8;
        if([barProperties valueForKey:@"shadowOpacity"])
        {
            shadowOpacity=[[barProperties valueForKey:@"shadowOpacity"] floatValue];
        }

        
        [view.layer setShadowRadius:shadowRadius];
        [view.layer setShadowColor:shadowColor.CGColor];
        [view.layer setShadowOpacity:shadowOpacity];
        
        if(isNegativeBar)[view.layer setShadowOffset:CGSizeMake(xShadowOffset, yShadowOffset)];
        else [view.layer setShadowOffset:CGSizeMake(xShadowOffset, -yShadowOffset)];
        
    }
    else
        [view removeFromSuperview];
    

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
    
    
    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin;
    
    if(isLongGraph_)
    {
        _leftMargin=0;
        _bottomMargin=0;
        
    }

    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
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
                

                
                BarInfoBox *view=[[BarInfoBox alloc]initWithFrame:CGRectMake(xOrigin+_leftMargin,originY+yOffset+topMargin,barWidth,25)];
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
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
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
            
            BarInfoBox *view=[[BarInfoBox alloc]initWithFrame:CGRectMake((i* barWidth) + spaceBetweenSameGroupBar*(i+1)+_leftMargin,originY+yOffset,barWidth,25)];
            [view setText:[_xTitles objectAtIndex:i]];
            
            if(isLongGraph_)[lineGScrollView addSubview:view];
            else [self addSubview:view];
            
            
            
            
            
        }
    }
    
}

-(void)displayFloatingView:(id)view
{
    BarView *bView=(BarView *)view;
    int totalColors=[MIMColor sizeOfColorArray];
    int tagVal=bView.tag-300;

    
    if(!floatingView)
    {
        floatingView=[[MIMFloatingView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        
    }
    
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
    {
    
    }
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)
    {
    
    }
    else
    {
        
        if(gradientStyle !=0)
        {
            
            if(pickLibColors)
            {
                //Colors of gradients NOT provided by user.
                NSDictionary *l=[MIMColor GetColorAtIndex:(style+1)%totalColors];
                floatingView.barColor=[UIColor colorWithRed:[[l valueForKey:@"red"]floatValue] green:[[l valueForKey:@"green"]floatValue] blue:[[l valueForKey:@"blue"]floatValue] alpha:1.0];
            }
            else
            {
                if([barcolorArray count]>=1)
                {
                    //Only 1 Color of gradients IS provided by user.
                    MIMColorClass *l=[barcolorArray objectAtIndex:0];
                    floatingView.barColor=[UIColor colorWithRed:l.red green:l.green blue:l.blue alpha:1.0];
                }
               
            }
            
            
        }
        else
        {    
            MIMColorClass *l=[barcolorArray objectAtIndex:0];
            floatingView.barColor=[UIColor colorWithRed:l.red green:l.green blue:l.blue alpha:1.0];
        }
        

        if([_xTitles count]>0)
        [floatingView setLabelsOnView:[_yValElements objectAtIndex:tagVal] subtitle:[_xTitles objectAtIndex:tagVal]];
        else
        [floatingView setLabelsOnView:[_yValElements objectAtIndex:tagVal] subtitle:[_xValElements objectAtIndex:tagVal]];
    }

    if(isLongGraph_)[lineGScrollView addSubview:floatingView];
    else [self addSubview:floatingView];
    
    //Create border of floatingview layer
    CALayer *layer=floatingView.layer;
    layer.borderWidth=1;
    layer.borderColor=[UIColor darkGrayColor].CGColor;
    layer.cornerRadius=3;
        
         
    
    CGRect a=floatingView.frame;
    a.origin.x=CGRectGetMaxX(bView.frame)-10;
    a.origin.y=CGRectGetMinY(bView.frame)-40;
    floatingView.frame=a;
}
#pragma mark - X and Y Axis

-(void)_displayXAxisLabels
{
    
 
    
    if([[xLProperties allKeys] count]==0)
        xLProperties=[[NSMutableDictionary alloc] init];
    
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)
    {
        xTitleStyle=1;
        [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];   
    }
    else[xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"barchart"];
    [xLProperties setValue:[NSNumber numberWithFloat:barWidth] forKey:@"xscaling"];
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)[xLProperties setValue:[NSNumber numberWithFloat:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    else if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)[xLProperties setValue:[NSNumber numberWithInt:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    else [xLProperties setValue:[NSNumber numberWithInt:spaceBetweenSameGroupBar] forKey:@"gapBetweenBars"];
    
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED || barGraphStyle==BAR_GRAPH_STYLE_STACKED)[xLProperties setValue:[NSNumber numberWithFloat:gapBetweenBarsDifferentGroup] forKey:@"gapBetweenGroup"];
    if(barGraphStyle==BAR_GRAPH_STYLE_GROUPED)[xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"groupedBars"];
    if(barGraphStyle==BAR_GRAPH_STYLE_STACKED)[xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"stackedBars"];
    

    
    XAxisBand *_xBand;
      
   
    //NSLog(@"_gridWidth=%f,%f",_gridWidth,contentSizeX);
    //if(isLongGraph_)NSLog(@"LONG GRAPH_gridWidth=%f,%f",_gridWidth,contentSizeX);
    
    NSLog(@"XAxisBand.frame=%f,%f,%f",self.frame.size.height,topMargin,bottomMargin);
    NSLog(@"content height %f",lineGScrollView.contentSize.height);
    
    
    if(isLongGraph_)
    _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,_gridHeight, contentSizeX, xAxisHeight)];
    else 
    _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth,_gridHeight+topMargin, _gridWidth, xAxisHeight)];
        
    
    
    _xBand.properties=xLProperties;
    if([delegate respondsToSelector:@selector(grouptitlesForXAxis:)])
    {
        _xBand.groupTitles=[delegate grouptitlesForXAxis:self];            
    }
    
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
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(leftMargin,topMargin, yAxisWidth, _gridHeight+10)];

    _yBand.tag=YBANDTAG;
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
