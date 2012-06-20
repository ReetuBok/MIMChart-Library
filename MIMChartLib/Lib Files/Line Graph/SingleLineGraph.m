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
//  LineGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "SingleLineGraph.h"
@interface SingleLineGraph()
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

@end


@implementation SingleLineGraph
@synthesize fitsToScreenWidth;
@synthesize nonInteractiveAnchorPoints;
@synthesize xTitleStyle,anchorType,style;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

#pragma mark - PUBLIC METHODS

-(void)drawLineGraph
{
    
    [self initAndWarnings];
    
    //Create the Bezier Path
    lineBezierPath=[[UIBezierPath alloc]init];
    lineBezierPath.lineWidth=1.0;
    //lineBezierPath.flatness=1.0;
    //lineBezierPath.miterLimit=5.0;
    lineBezierPath.lineJoinStyle=kCGLineJoinRound;
    
    
    for (int l=0; l<[_yValElements count]; l++) 
    {   
        float valueY=[[_yValElements objectAtIndex:l] floatValue];
        float valueX;
        if(xIsString)
            valueX=(float)l;
        else
            valueX=[[_xValElements objectAtIndex:l] floatValue];
        
        float mX=valueX*_scalingX;
        float mY=valueY*_scalingY;
        if(l==0)
            [lineBezierPath moveToPoint:CGPointMake(mX,mY)];
        else
            [lineBezierPath addLineToPoint:CGPointMake(mX,mY)];
        
    }
    
    //Draw the Bezier Path
    [self setNeedsDisplay];
    
    [self _addSetterButtonLabel];
}




-(void)styleButtonClicked
{
    _userTestingColors=YES;
    style++;

    int totalColors=[MIMColor sizeOfColorArray];
    NSDictionary *_colorDic=[MIMColor GetColorAtIndex:style%totalColors];
    NSString *colorS=[NSString stringWithFormat:@"RGB(%@,%@,%@)",[_colorDic valueForKey:@"red"],[_colorDic valueForKey:@"green"],[_colorDic valueForKey:@"blue"]];

    [styleLabel setText:colorS];
    
    [self setNeedsDisplay];
    
}







#pragma mark - INIT AND CALCULATIONS

-(void)CalculateGridDimensions
{
    
    if(fitsToScreenWidth)
        _gridWidth=self.frame.size.width;
    else
    {
        int perPixel=self.frame.size.width/[_xValElements count];
        if(perPixel < 5)
        {
            //Increase the gridwidth
            _gridWidth=5*[_xValElements count];
        }
        else
          _gridWidth=self.frame.size.width;  
    }
        
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
    
    float maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
    float minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
    
    
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

        _scalingX=_gridWidth/[_xValElements count];
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




-(void)initAndWarnings
{
    
    
    srand(time(NULL));
    
    style=0;
    
    if([MIMColor sizeOfColorArray]==0)
        [MIMColor InitFragmentedBarColors];
    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    
    
    
    
    
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
    
    
    
    
    
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available for x-Axis Labels.");
        
        
        if([valueArray_ count]>0)
        {
            _xValElements=[NSMutableArray arrayWithArray:valueArray_];
        }
        xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[_xValElements objectAtIndex:0]];
        
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
        return;
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

    
    
    //[self drawLineInfoBox];
    [self CalculateGridDimensions];
    [self FindTileWidthAndHeight];
    [self ScalingFactor];
    //    [self addSetterButton];
    
    
}



#pragma  mark - DRAW

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float r,g,b,a;

    if(_xValElements==nil)
        return;
    
    if(_gridWidth > self.frame.size.width)
    {
        SingleLineLongGraph *graph=[[SingleLineLongGraph alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, self.frame.size.height)];
        graph.gridWidth=_gridWidth;
        graph.gridHeight=_gridHeight;
        graph.tileWidth=_tileWidth;
        graph.tileHeight=_tileHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
 
        
        
        //------
        BOOL pickDefaultColorForLineChart;
        MIMColorClass *colorLineChart;
        
        
        if([delegate respondsToSelector:@selector(ColorForLineChart:)])
        {
            colorLineChart=[delegate ColorForLineChart:self];
            if(colorLineChart==nil)
            {
                pickDefaultColorForLineChart=TRUE;
                NSLog(@"WARNING:Color of Line Chart not defined,hence picking up random color.");
            }
            else
            {
                graph.colorLineChart=[MIMColorClass colorWithRed:colorLineChart.red Green:colorLineChart.green Blue:colorLineChart.blue Alpha:colorLineChart.alpha];
            }
            
            
            
        }
        else
        {
            pickDefaultColorForLineChart=TRUE;
            
        }
        
        
        if(pickDefaultColorForLineChart)
        {
            graph.colorLineChart=[MIMColorClass colorWithComponent:@"0,169,249"];
        }
        //-----
        graph.lineBezierPath=lineBezierPath;
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
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
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
        
         [self _displayYAxisWithColorRed:graph.colorOfLine.red Blue:graph.colorOfLine.blue Green:graph.colorOfLine.green Alpha:graph.colorOfLine.alpha];
        
        return;
        
    }
    
    colorOfGraphBgLine=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];

    
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
    
    int totalColors=[MIMColor sizeOfColorArray];
    if(_userTestingColors)
    {
        
        NSDictionary *_colorDic=[MIMColor GetColorAtIndex:style%totalColors];
        float red= [[_colorDic valueForKey:@"red"] floatValue];
        float green=[[_colorDic valueForKey:@"green"] floatValue];
        float blue=[[_colorDic valueForKey:@"blue"] floatValue];
        
        r=red;
        g=green;
        b=blue;
        a=1.0;
        
        
        UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
        [_color setStroke];
        [lineBezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];


    }
    else
    {
        BOOL pickDefaultColorForLineChart;
        MIMColorClass *colorLineChart;
       
        
        if([delegate respondsToSelector:@selector(ColorForLineChart:)])
        {
            colorLineChart=[delegate ColorForLineChart:self];
            if(colorLineChart==nil)
            {
                pickDefaultColorForLineChart=TRUE;
                NSLog(@"WARNING:Color of Line Chart not defined,hence picking up random color.");
                
               
            }
            else
            {
                
                UIColor *_color=[[UIColor alloc]initWithRed:colorLineChart.red green:colorLineChart.green blue:colorLineChart.blue alpha:colorLineChart.alpha]; 
                r=colorLineChart.red;
                g=colorLineChart.green;
                b=colorLineChart.blue;
                a=colorLineChart.alpha;
                [_color setStroke];  
            }

                
            
        }
        else
        {
            pickDefaultColorForLineChart=TRUE;
            
        }
        
        
        if(pickDefaultColorForLineChart)
        {
        
            MIMColorClass *mColor=[MIMColorClass colorWithComponent:@"0,169,249"];
            r=mColor.red;
            g=mColor.green;
            b=mColor.blue;
            a=mColor.alpha;
            UIColor *_color=[[UIColor alloc]initWithRed:mColor.red green:mColor.green blue:mColor.blue alpha:1.0]; 
            [_color setStroke];

        }
        
        [lineBezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];

        
        
    }
    
    [self _drawAnchorPointsWithColorRed:r Blue:b Green:g Alpha:a];

 
    //Write Y-Axis Elements;
    [self _displayYAxisWithColorRed:colorOfGraphBgLine.red Blue:colorOfGraphBgLine.blue Green:colorOfGraphBgLine.green Alpha:colorOfGraphBgLine.alpha];
    
}


-(void)drawBgPattern:(CGContextRef)ctx
{
    
    //Check if User has given any color for Background
    MIMColorClass *colorBg;
    if([delegate respondsToSelector:@selector(backgroundColorForLineChart:)])
    {
        colorBg=[delegate backgroundColorForLineChart:self];    
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
        numVertLines=[_xValElements count];
        
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



#pragma mark - draw Anchors



-(void)_drawAnchorPointsWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha
{
    //Remove Any if there
    for (UIView *view in self.subviews) 
    if([view isKindOfClass:[Anchor class]])
    {
        [view removeFromSuperview];
    }
    
    
    for (int l=0; l<[_yValElements count]; l++) 
    {   
        float valueY=[[_yValElements objectAtIndex:l] floatValue];
        float valueX;
        if(xIsString)
            valueX=(float)l;
        else
            valueX=[[_xValElements objectAtIndex:l] floatValue];
        
        float mX=valueX*_scalingX;
        float mY=valueY*_scalingY;
        mY=_gridHeight-mY;
        
        
        Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _anchor.center=CGPointMake(mX,mY);
        _anchor.type=anchorType;
        
        
        if(!nonInteractiveAnchorPoints)
            _anchor.enabled=YES;
        _anchor.color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:alpha];
        _anchor.idTag=l;
        _anchor.delegate=self;
        [self addSubview:_anchor];
        [_anchor drawAnchor];
        
    }
    
    
    
}

#pragma mark - draw Anchors Delegate

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
    
    
    float anchorY=[[_yValElements objectAtIndex:tagID] floatValue];
    
    AnchorInfo *aInfo=[[AnchorInfo alloc]initWithFrame:CGRectMake(point.x-10, point.y-30, 320, 20)];
    [aInfo setTagID:tagID];
    if(xIsString)
        [aInfo setInfoString:[NSString stringWithFormat:@"(%@,%.0f)",[_xValElements objectAtIndex:tagID],anchorY]];
    else
        [aInfo setInfoString:[NSString stringWithFormat:@"(%.0f,%.0f)",[[_xValElements objectAtIndex:tagID] floatValue],anchorY]];
    
    
    
    
    [self addSubview:aInfo];
    [aInfo setNeedsDisplay];
}


#pragma mark - X and Y Axis stuff




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

#pragma mark - USER USE METHOD


-(void)_addSetterButtonLabel
{

    styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 10, 200, 30)];
    [styleLabel setBackgroundColor:[UIColor clearColor]];
    [styleLabel setTextColor:[UIColor blackColor]];
    [styleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [self addSubview:styleLabel];
    
}




- (void)dealloc
{
    ////[super dealloc];
}

@end
