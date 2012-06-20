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
//  WallGraph.m
//  MIM2D Library
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "WallGraph.h"
#import "Anchor.h"
#import "AnchorInfo.h"
#import "MIMColor.h"
#import "YAxisBand.h"
#import "XAxisBand.h"




@interface WallGraph()
-(void)initAndWarnings;
-(void)_drawAnchorPointsWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha;
-(void)_displayXAxisWithStyle:(int)xstyle WithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha;
-(void)_displayYAxisWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha;
-(void)_addSetterButtonLabel;


-(void)_findScaleForYTile;
-(void)_findScaleForXTile;


-(void)drawBgPattern:(CGContextRef)ctx;
-(void)drawVerticalBgLines:(CGContextRef)ctx;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;



-(void)drawThePattern:(CGContextRef)ctx;
-(void)drawWallEdge:(CGContextRef)ctx WithColors:(MIMColorClass *)dColor;
@end



@implementation WallGraph
@synthesize xTitleStyle,patternStyle;
@synthesize nonInteractiveAnchorPoints;
@synthesize style,isShadow;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
    }
    return self;
}
#pragma mark - Public Methods

-(void)drawWallGraph
{

    [self initAndWarnings];
    [self setNeedsDisplay];
//    [self drawAnchorPoints];
    
}

-(void)CalculateGridDimensions
{

    if(fitsToScreenWidth)
        _gridWidth=self.frame.size.width;
    else
    {
        int perPixel=self.frame.size.width/[_xElements count];
        if(perPixel < 5)
        {
            //Increase the gridwidth
            _gridWidth=5*[_xElements count];
        }
        else
            _gridWidth=self.frame.size.width;  
    }
    
    _gridHeight=self.frame.size.height; 
}

-(void)ScalingFactor
{
    [self _findScaleForYTile];
    [self _findScaleForXTile];
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

-(void)_findScaleForYTile
{
    int HorLines=_gridHeight/_tileHeight;
    numOfHLines=HorLines;
    
    float maxOfY=[MIM_MathClass getMaxFloatValue:_yElements];
    float minOfY=[MIM_MathClass getMinFloatValue:_yElements];
    
    
    float pixelPerTile=(maxOfY-minOfY)/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    pixelsPerTile=pixelPerTile;
    
    _scalingY=_tileHeight/pixelPerTile;
    
    
}

-(void)_findScaleForXTile
{
    if(xIsString)
    {
        
        _scalingX=_gridWidth/[_xElements count];
        return;
    }
    
    int VerLines=_gridWidth/_tileWidth;
    float maxX=[MIM_MathClass getMaxFloatValue:_xElements];
    float minX=[MIM_MathClass getMinFloatValue:_xElements];
    
    float pixelPerTile=(maxX-minX)/(VerLines-1);
    
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingX=_tileWidth/pixelPerTile;
    
}

-(void)initAndWarnings
{
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available for x-Axis Labels.");
        
        
        if([valueArray_ count]>0)
        {
            _xElements=[NSMutableArray arrayWithArray:valueArray_];
        }
        xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[_xElements objectAtIndex:0]];
        
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
        return;
    }
    
    BOOL multipleLines=FALSE;
    
    if([delegate respondsToSelector:@selector(valuesForGraph:)])
    {
        NSArray *valueArray_=[delegate valuesForGraph:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available to draw graph.");
        
        //See if the its an array or array or just one array
        if([valueArray_ count]>0)
        {
            if([[valueArray_ objectAtIndex:0] respondsToSelector:@selector(count)])//its an array of arrays
            {
                
                multipleLines=TRUE;
            }
            
            _yElements=[NSMutableArray arrayWithArray:valueArray_];
            
        }
        
        
    }
    else
    {
        NSLog(@"Error: Use delegate Method valuesForGraph: to give values for graph.");
    }
    
    
    
    //Check whether to display the vertical lines
    if([delegate respondsToSelector:@selector(drawVerticalLines:)])
    {
        _verticalLinesVisible=[delegate drawVerticalLines:self];    
    }
    else
    {
        NSLog(@"Caution:Vertical Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawVerticalLines:");
    }
    
    //Check whether to display the horizontal lines
    if([delegate respondsToSelector:@selector(drawHorizontalLines:)])
    {
        _horizontalLinesVisible=[delegate drawHorizontalLines:self];    
    }
    else
    {
        NSLog(@"Caution:Horizontal Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawHorizontalLines:");
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
    
    
    
    
    
    if([delegate respondsToSelector:@selector(widthOfWallBorder:)])
    {
        widthOfWallBorder=[delegate widthOfWallBorder:self];
        
        if(widthOfWallBorder==-1)
        {
            widthOfWallBorder=0;
            NSLog(@"WARNING: Border width of Wall Graph is 0.");

        }
        
        if(widthOfWallBorder<0.01)
            widthOfWallBorder=1.0;

    }
    else
    {
        widthOfWallBorder=1.0;
        
    }
    
    [self CalculateGridDimensions];
    [self FindTileWidthAndHeight];
    [self ScalingFactor];

}


#pragma mark - DRAWING




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    if(_xElements==nil)
        return;
    
    
    
    BOOL pickDefaultColorForLineChart;
    MIMColorClass *colorWallChart;
    
    
    if([delegate respondsToSelector:@selector(ColorForWallChart:)])
    {
        colorWallChart=[delegate ColorForWallChart:self];
        if(colorWallChart==nil)
        {
            colorWallChart=[MIMColorClass colorWithComponent:@"0,169,249"];
            pickDefaultColorForLineChart=TRUE;
            NSLog(@"WARNING:Color of Line Chart not defined,hence picking up random color.");
        }
        
    }
    else
    {
        colorWallChart=[MIMColorClass colorWithComponent:@"0,169,249"];
        pickDefaultColorForLineChart=TRUE;
        
    }
    
    
    
    if(_gridWidth > self.frame.size.width)
    {
        WallLongGraph *graph=[[WallLongGraph alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, self.frame.size.height)];
        graph.gridWidth=_gridWidth;
        graph.gridHeight=_gridHeight;
        graph.tileWidth=_tileWidth;
        graph.tileHeight=_tileHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.isShadow=isShadow;
        graph.widthOfWall=widthOfWallBorder;
        graph.patternStyle=patternStyle;
        
        //------
        
        if(pickDefaultColorForLineChart)
            graph.colorWallChart=[MIMColorClass colorWithComponent:@"0,169,249"];
        else
            graph.colorWallChart=[MIMColorClass colorWithRed:colorWallChart.red Green:colorWallChart.green Blue:colorWallChart.blue Alpha:colorWallChart.alpha];
            
        //-----

        graph.verticalLinesVisible=_verticalLinesVisible;
        graph.horizontalLinesVisible=_horizontalLinesVisible;
        
        
        
        //------
        
        
        
        
        //Check if width and color of line can be accessed by delegate methods
        if([delegate respondsToSelector:@selector(widthOfVerticalLines:)])
        {
            graph.widthOfLine=[delegate widthOfVerticalLines:self];
            if(graph.widthOfLine==0)
                NSLog(@"WARNING: Line width of vertical line is 0.");
            
        }
        else
        {
            graph.widthOfLine=0.1;
            
        }
        
        if([delegate respondsToSelector:@selector(colorOfVerticalLines:)])
        {
            graph.colorOfLine=[delegate colorOfVerticalLines:self];    
            if(graph.colorOfLine==nil)
            {  
                NSLog(@"WARNING:No color defined for vertical line.");
                graph.colorOfLine=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
            }
        }
        else
        {
            graph.colorOfLine=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
            
        }
        
        
        
        //------
        graph.xElements=[[NSMutableArray alloc]initWithArray:_xElements];
        graph.yElements=[[NSMutableArray alloc]initWithArray:_yElements];
        graph.xTitleStyle=self.xTitleStyle;
        graph.nonInteractiveAnchorPoints=nonInteractiveAnchorPoints;
        graph.anchorType=anchorType;
        
        
        LineScrollView *lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.contentSize=CGSizeMake(_gridWidth, self.frame.size.height);
        [self addSubview:lineGScrollView];
        
        [lineGScrollView addSubview:graph];
        [graph setNeedsDisplay];
        
        
        //Draw the Background
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetAllowsAntialiasing(ctx, NO);
        CGContextSetShouldAntialias(ctx, NO);
        
        CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
        CGContextConcatCTM(ctx, flipTransform);
        
        
        [self drawBgPattern:ctx];
        
        //[self _displayYAxisWithColorRed:graph.colorOfLine.red Blue:graph.colorOfLine.blue Green:graph.colorOfLine.green Alpha:graph.colorOfLine.alpha];
        
        return;
        
    }
    
    
    
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(ctx, NO);
    CGContextSetShouldAntialias(ctx, NO);

        CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
  
    
    [self drawBgPattern:ctx];
    [self drawVerticalBgLines:ctx];
    [self drawHorizontalBgLines:ctx];
    
    

    
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    

    CGContextSaveGState(ctx);
    
    CGContextBeginPath(ctx);

    CGContextMoveToPoint(ctx,0,0);
    
    
  
    
    if(xIsString)
    {
        

        for (int i=0; i<[_xElements count]; i++)
            CGContextAddLineToPoint(ctx,i*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);

        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,([_xElements count]-1)*_scalingX , 0);
    
    
    }
    else
    {
        for (int i=0; i<[_xElements count]; i++)
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
    }
    
     CGContextClosePath(ctx);


    UIColor *_color=[[UIColor alloc]initWithRed:colorWallChart.red green:colorWallChart.green blue:colorWallChart.blue alpha:0.6];    
    CGContextSetFillColorWithColor(ctx, _color.CGColor);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
    
    

    
    
    /*
    if(isGradient)
    {
        CGContextClip(ctx);

        
        NSDictionary *lColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
        float red=[[lColor valueForKey:@"red"] floatValue];
        float green=[[lColor valueForKey:@"green"] floatValue];
        float blue=[[lColor valueForKey:@"blue"] floatValue];

        
        NSDictionary *dColor=[MIMColor GetColorAtIndex:(style)%totalColors];
        
        float dred=[[dColor valueForKey:@"red"] floatValue];
        float dgreen=[[dColor valueForKey:@"green"] floatValue];
        float dblue=[[dColor valueForKey:@"blue"] floatValue];
        
        
        
        
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { dred, dgreen, dblue, 0.7,  // Start color
            red,green,blue, 0.7 }; // Mid color and End color
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        
        
        
        CGPoint start = CGPointMake(0,0); 
        CGPoint end = CGPointMake(0, maxOfY*_scalingY);
        CGContextDrawLinearGradient(ctx, glossGradient, end ,start , kCGGradientDrawsBeforeStartLocation);
        
        CGColorSpaceRelease(rgbColorspace);
        CGGradientRelease(glossGradient);
        
        //Draw the line on the top edge of the wall
        [self drawWallEdge:ctx WithColors:dColor];

        
    }
    else
     */

    
        
        
        
        
    //Draw the line on the top edge of the wall
    [self drawWallEdge:ctx WithColors:colorWallChart];



    CGContextSetAllowsAntialiasing(ctx, NO);
    CGContextSetShouldAntialias(ctx, NO);
    [self drawThePattern:ctx];
    
    


    
   
    
    CGContextFlush(ctx);
}


-(void)drawBgPattern:(CGContextRef)ctx
{

        
    //Check if User has given any color for Background
    MIMColorClass *colorBg;
    if([delegate respondsToSelector:@selector(backgroundColorForWallChart:)])
    {
        colorBg=[delegate backgroundColorForWallChart:self];    
        if(colorBg==nil)
        {
            NSLog(@"WARNING:No color defined for background of line chart.");
            colorBg=[MIMColorClass colorWithRed:0.4 Green:0.4 Blue:0.4 Alpha:0.7];
        }
        
        //Fill the background
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:colorBg.red green:colorBg.green blue:colorBg.blue alpha:colorBg.alpha].CGColor);
        CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, _gridWidth, _gridHeight));
        CGContextRestoreGState(ctx);
        return;
        
        
    }
    
    
    if([delegate respondsToSelector:@selector(backgroundViewForWallChart:)])
    {
        
        
        return;
    }
    
    
    
    //Else Draw the background with the gray Gradient
    CGContextSaveGState(ctx);
    CGFloat BGLocations[3] = { 0.0,0.5 ,1.0 };
    CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.99, 0.99, 0.99 , 1.0,  // Start color
        0.93, 0.93, 0.93 , 1.0 }; // Mid color and End color
    
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    CGPoint startBg = CGPointMake(_gridWidth/2,_gridHeight/2); 
    CGFloat endRadius=MAX(_gridWidth*0.7, _gridHeight*0.7);
    CGFloat startRadius=MAX(_gridWidth/7, _gridHeight/7);
    
    
    CGContextDrawRadialGradient(ctx, bgRadialGradient, startBg, startRadius, startBg, endRadius, kCGGradientDrawsBeforeStartLocation);
    CGContextClip(ctx);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    CGContextRestoreGState(ctx);
    
    
    
    

}


-(void)drawVerticalBgLines:(CGContextRef)ctx
{
    if(!_verticalLinesVisible)
        return;
    
    
    
    float widthOfLine;
    MIMColorClass *colorOfLine;
    
    //Check if width and color of line can be accessed by delegate methods
    if([delegate respondsToSelector:@selector(widthOfVerticalLines:)])
    {
        widthOfLine=[delegate widthOfVerticalLines:self];
        if(widthOfLine==0)
            NSLog(@"WARNING: Line width of vertical line is 0.");
        
    }
    else
    {
        widthOfLine=0.1;
        
    }
    
    if([delegate respondsToSelector:@selector(colorOfVerticalLines:)])
    {
        colorOfLine=[delegate colorOfVerticalLines:self];    
        if(colorOfLine==nil)
            NSLog(@"WARNING:No color defined for vertical line.");
    }
    else
    {
        colorOfLine=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
        
    }
    
    colorOfGraphBgLine=colorOfLine;
    
    
    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:colorOfLine.red green:colorOfLine.green blue:colorOfLine.blue alpha:colorOfLine.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    
    int numVertLines=_gridWidth/_tileWidth;
    
    if(xIsString)
    {
        numVertLines=[_xElements count];
        
        for (int i=0; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i * _scalingX,0);
            CGContextAddLineToPoint(ctx, i * _scalingX,_gridHeight);
        }
        
    }
    else
    {
        for (int i=0; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i*_tileWidth,0);
            CGContextAddLineToPoint(ctx, i*_tileWidth,_gridHeight);
        }
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    
    
    
}

-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    if(!_horizontalLinesVisible)
        return;
    
    
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
    
    colorOfGraphBgLine=colorOfLine;
    
    
    if (xTitleStyle==0)
        xTitleStyle=X_TITLES_STYLE1;
    
    [self _displayXAxisWithStyle:xTitleStyle WithColorRed:colorOfGraphBgLine.red Blue:colorOfGraphBgLine.blue Green:colorOfGraphBgLine.green Alpha:colorOfGraphBgLine.alpha];
    
    
    
    
}



-(void)drawWallEdge:(CGContextRef)ctx WithColors:(MIMColorClass *)dColor
{

    float dred=dColor.red;
    float dgreen=dColor.green;
    float dblue=dColor.blue;
    float dAlpha=dColor.alpha;

    
    
    CGContextSetLineWidth(ctx, widthOfWallBorder);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:dred green:dgreen blue:dblue alpha:dAlpha].CGColor);
    if(isShadow)
        CGContextSetShadowWithColor(ctx, CGSizeMake(1.0,1.0), 3.0, [UIColor blackColor].CGColor);
    
    if(xIsString)
    {
        
        CGContextMoveToPoint(ctx, 0, [[_yElements objectAtIndex:0] floatValue]*_scalingY);
        int k=1;
        for (int i=1; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,k*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
            k++;
        }
        
   
        
        
        
    }
    else
    {
        CGContextMoveToPoint(ctx, [[_xElements objectAtIndex:0] intValue]*_scalingX, [[_yElements objectAtIndex:0] floatValue]*_scalingY);
        
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        }
        
    
        
    }
    
    
    
    CGContextStrokePath(ctx);

}


-(void)drawThePattern:(CGContextRef)ctx
{
    
    CGContextSaveGState(ctx);
    
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx,0,0);
    
    
    
    
    if(xIsString)
    {
        
        
        for (int i=0; i<[_xElements count]; i++)
            CGContextAddLineToPoint(ctx,i*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,([_xElements count]-1)*_scalingX , 0);
        
        
    }
    else
    {
        for (int i=0; i<[_xElements count]; i++)
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
    }
    
    CGContextClosePath(ctx);
    

    
    
    CGContextClip(ctx);
    

    
    
    
    switch (patternStyle) 
    {
        case WALL_PATTERN_STYLE1:
        default:
        {
            CGContextBeginPath(ctx);
            CGContextSetFillColorWithColor(ctx,[UIColor colorWithPatternImage:[UIImage imageNamed:@"lines1.png"]].CGColor);
            CGContextMoveToPoint(ctx, 0, 0);
            CGContextSetAlpha(ctx, 0.2);
            
            
            if(xIsString)
            {
                int k=0;
                for (int i=0; i<[_xElements count]; i++) {
                    
                    CGContextAddLineToPoint(ctx,k*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
                    k++;
                }
                
                //Add the last point at the bottom of y axis.
                CGContextAddLineToPoint(ctx,(k-1)*_scalingX , 0);
                
                
            }
            else
            {
                for (int i=0; i<[_xElements count]; i++) {
                    
                    CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
                }
                
                //Add the last point at the bottom of y axis.
                CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
            }
            
            
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFill);
        }
            break;
        case WALL_PATTERN_STYLE2:
        {

            
            
            
            CGContextSetLineWidth(ctx, 0.1);
            CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0].CGColor);

            int l=(_gridWidth+_gridHeight)/5;
            float x=_gridWidth+_gridHeight;
            for (int i=0; i< l; i++) {
                
                CGContextMoveToPoint(ctx,x, 0);
                CGContextAddLineToPoint(ctx, 0, x);
                CGContextStrokePath(ctx);

                x-=5;
            }
            
           
            
            

        }
            break;   
        case WALL_PATTERN_STYLE3:
        {
            
        }
            break; 
        case WALL_PATTERN_STYLE4:
        {
            
        }
            break; 
        case WALL_PATTERN_STYLE5:
        {
            
        }
            break;             
            
    }
    
    CGContextRestoreGState(ctx);

    
}

#pragma mark - Anchor Points


-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
    //Find if the AnchorInfo at that tag is already displaying
    for (id view in self.subviews) {
        if([view isKindOfClass:[AnchorInfo class]])
            if([(AnchorInfo *)view displaying] &&([(AnchorInfo *)view tagID]==tagID)){
                [view removeFromSuperview];
                return;
            }
        
    }
    
    
    float anchorY=[[_yElements objectAtIndex:tagID] floatValue];
    
    AnchorInfo *aInfo=[[AnchorInfo alloc]initWithFrame:CGRectMake(point.x-10, point.y-30, 320, 20)];
    [aInfo setTagID:tagID];
    
    if(xIsString)
        [aInfo setInfoString:[NSString stringWithFormat:@"(%@,%.0f)",[_xElements objectAtIndex:tagID],anchorY]];
    else
        [aInfo setInfoString:[NSString stringWithFormat:@"(%.0f,%.0f)",[[_xElements objectAtIndex:tagID] floatValue],anchorY]];
    
    
    
    
    [self addSubview:aInfo];
    [aInfo setNeedsDisplay];
}

-(void)drawAnchorPoints
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    if(xIsString)
    {
        
        for (int i=0; i<[_xElements count]; i++) 
        {
            
            float newX=i*_scalingX;
            float newY=_gridHeight-[[_yElements objectAtIndex:i] intValue]*_scalingY;
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);

            _anchor.type=anchorType;
            _anchor.enabled=YES;
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
            
            
            
            
            _anchor.color=_color;
            _anchor.isShadow=isShadow;
            _anchor.idTag=i;
            _anchor.delegate=self;
            [self addSubview:_anchor];
        }
        
    }
    else
    {
        
        
        for (int i=0; i<[_xElements count]; i++) {
            
            float newX=[[_xElements objectAtIndex:i] intValue]*_scalingX;
            float newY=_gridHeight-[[_yElements objectAtIndex:i] intValue]*_scalingY;
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);

            _anchor.type=anchorType;
            _anchor.enabled=YES;
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
            
            
            
            
            _anchor.color=_color;
            _anchor.isShadow=isShadow;
            _anchor.idTag=i;
            _anchor.delegate=self;
            [self addSubview:_anchor];
        }
    }
    
    
    
}

-(void)setNewYForAnchor
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    float movedY=[userDefault floatForKey:@"pointy"];
    NSInteger tagID=[userDefault integerForKey:@"id"];
    movedY=_gridHeight-movedY;    
    [_yElements replaceObjectAtIndex:tagID withObject:[NSString stringWithFormat:@"%f",movedY/_scalingY]];
    [self setNeedsDisplay];
}

#pragma mark - XY Label



-(void)_displayXAxisWithStyle:(int)xstyle WithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha
{
    
    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    _xBand.xElements=[[NSArray alloc]initWithArray:_xTitles];
    _xBand.style=xstyle;
    _xBand.xIsString=xIsString;
    _xBand.lineChart=YES;
    _xBand.scalingFactor=_scalingX;
    
    
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




-(void)displayYAxis
{
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame))];
    [_yBand setScaleForYTile:pixelsPerTile withNumOfLines:numOfHLines];
    [self addSubview:_yBand];
    
    
}



- (void)dealloc
{
    ////[super dealloc];
}

@end
