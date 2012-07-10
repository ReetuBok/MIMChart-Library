//
//  MIMLineGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMLineGraph.h"
@interface  MIMLineGraph()
{
    
    NSMutableArray *myPathArray;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    NSArray *_xTitles;
    
    
    
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    float _tileHeight;
    
    
    BOOL xIsString;
    
    float pixelsPerTile;
    int numOfHLines;
    float minimumOnY;
    NSMutableArray *lineColorA;
    
    
    NSMutableArray *aPropertiesArray;
    NSMutableDictionary *hlProperties;
    NSMutableDictionary *vlProperties;
    NSMutableDictionary *xLProperties;
    NSMutableDictionary *yLProperties;
    
    
    LineScrollView *lineGScrollView;
    
}
-(BOOL)initAndWarnings;
-(void)_drawAnchorPoints;
-(void)_displayXAxisLabels;
-(void)_displayYAxisLabels;
-(void)_findScaleForYTile;
-(void)_findScaleForXTile;
-(void)drawBgPattern:(CGContextRef)ctx;
-(void)drawVerticalBgLines:(CGContextRef)ctx;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;

@end


@implementation MIMLineGraph

@synthesize fitsToScreenWidth;
@synthesize backgroundColor;
@synthesize xTitleStyle;
@synthesize delegate;
@synthesize anchorTypeArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initVars];
    }
    return self;
}


-(void)drawMIMLineGraph
{
    BOOL multipleLines=[self initAndWarnings];
    
    
    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;
    
    //Now Save the Path
    //In form of BezierPath
    myPathArray=[[NSMutableArray alloc]init];
    int outerLoop=1;
    if(multipleLines)
    {
        outerLoop=[_yValElements count];
        
        for (int k=0; k<outerLoop; k++) 
        {
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=1.0;//       myPath.flatness=2.0;//        myPath.miterLimit=5.0;
            myPath.lineJoinStyle=kCGLineJoinRound;
            
            
            NSArray *yArray_=[_yValElements objectAtIndex:k];
            for (int l=0; l<[yArray_ count]; l++) 
            {   
                float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                float valueX;
                if(xIsString) valueX=(float)l;
                else valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                
                if(l==0) [myPath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY)];
                else [myPath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY)];
                
            }
            
            [myPathArray addObject:myPath];
            if (addRandomAnchorType) [anchorTypeArray addObject:[NSNumber numberWithInt:rand()%7+1]];
        }
    }
    else
    {
        //Create the Bezier Path
        UIBezierPath *lineBezierPath=[[UIBezierPath alloc]init];
        lineBezierPath.lineWidth=1.0;
        lineBezierPath.lineJoinStyle=kCGLineJoinRound;
        
        
        for (int l=0; l<[_yValElements count]; l++) 
        {   
            float valueY=[[_yValElements objectAtIndex:l] floatValue]-minimumOnY;
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
        
        
        [myPathArray addObject:lineBezierPath];
        if (addRandomAnchorType) [anchorTypeArray addObject:[NSNumber numberWithInt:rand()%7+1]];
        
    }
    
    
   
    
    [self createLineColorArray];//Get colors for the line
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
}





#pragma mark - INIT AND CALCULATIONS

-(void)initVars
{
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=X_TITLES_STYLE1;
}


-(void)CalculateGridDimensions
{
    
    int count=0;
    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        count=[_xValElements count];
    }
    else
    {
        count=[[_xValElements objectAtIndex:0]count];
    }
    
    
    if(fitsToScreenWidth)
        _gridWidth=self.frame.size.width;
    else
    {
        int perPixel=self.frame.size.width/count;
        if(perPixel < 5)
        {
            //Increase the gridwidth
            _gridWidth=5*count;
        }
        else
            _gridWidth=self.frame.size.width;  
    }
    
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
    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
        minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
        
        
    }
    else
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
    
    
    
    
    
    
    
    
    float pixelPerTile=(maxOfY-minOfY)/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    pixelsPerTile=pixelPerTile;
    
    _scalingY=_tileHeight/pixelPerTile;
    
    
    countDigits=[[NSString stringWithFormat:@"%.0f",fabs(minOfY)] length];
    minimumOnY=minOfY/pow(10, countDigits-1);
    minimumOnY=floorf(minimumOnY);
    minimumOnY=minimumOnY*pow(10, countDigits-1);
    
    
    
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




-(BOOL)initAndWarnings
{
    
    
    srand(time(NULL));
    
    
    
    [MIMColor InitFragmentedBarColors];
    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    
    
    
    
    xIsString=TRUE;
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        if(valueArray_)
        {
            NSAssert(([valueArray_ count] !=0),@"WARNING::No values available for x-Axis Labels.");
            
            
            if([valueArray_ count]>0)
            {
                _xValElements=[NSMutableArray arrayWithArray:valueArray_];
            }
            
            if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]])
            {
                xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[_xValElements objectAtIndex:0]];
            }
            else
            {
                xIsString=[MIM_MathClass checkIfStringIsAlphaNumericOnly:[[_xValElements objectAtIndex:0]objectAtIndex:0]];
            }
            
        }
        
        
    }
    else
    {
        NSLog(@"Warning:No values available for x-Axis Labels.Use delegate Method valuesForXAxis: ");
    }
    
    
    BOOL multipleLines=FALSE;
    if([delegate respondsToSelector:@selector(valuesForGraph:)])
    {
        NSArray *valueArray_=[delegate valuesForGraph:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available to draw graph.");
        
        //See if the its an array or array or just one array
        if([valueArray_ count]>0)
        {
            if([[valueArray_ objectAtIndex:0] isKindOfClass:[NSString class]]) {}
            else multipleLines=TRUE;
            _yValElements=[NSMutableArray arrayWithArray:valueArray_];
        }
        
        
    }
    else
    {
        NSLog(@"Error: Use delegate Method valuesForGraph: to give values for graph.");
    }
    
    
    
    
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
    
    
    //X-AXis
    if([delegate respondsToSelector:@selector(xAxisProperties:)])
        xLProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate xAxisProperties:self]];
    else
        xLProperties=[[NSMutableDictionary alloc]init];
    
    //Y-Axis
    if([delegate respondsToSelector:@selector(yAxisProperties:)])
        yLProperties=[[NSMutableDictionary alloc]initWithDictionary:[delegate yAxisProperties:self]];
    else
        yLProperties=[[NSMutableDictionary alloc]init];
    
    
    
    
    //[self drawLineInfoBox];
    [self CalculateGridDimensions];
    [self createLongLineGraphScrollView];
    [self FindTileWidthAndHeight];
    [self ScalingFactor];
    //    [self addSetterButton];
    
    return multipleLines;
    
}

-(void)createLongLineGraphScrollView
{
    if(_gridWidth > self.frame.size.width)
    {
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.contentSize=CGSizeMake(_gridWidth, self.frame.size.height);
        [self addSubview:lineGScrollView];        
    }
}

-(void)createLineColorArray
{
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    //------
    BOOL pickDefaultColorForLineChart;
    
    
    if([delegate respondsToSelector:@selector(ColorsForLineChart:)])
    {
        lineColorA=[[NSMutableArray alloc]initWithArray:[delegate ColorsForLineChart:self]];
        if(lineColorA==nil)
        {
            pickDefaultColorForLineChart=TRUE;
            NSLog(@"WARNING:Color of Line Chart not defined,hence picking up random color.");
        }
    }
    else
    {
        pickDefaultColorForLineChart=TRUE;
        
    }
    
    
    if(pickDefaultColorForLineChart)
    {
        lineColorA=[[NSMutableArray alloc]init];
        for (int i=0; i<[myPathArray count]; i++) 
        {
            
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:rand()%totalColors];
            float red= [[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            
            MIMColorClass *color=[MIMColorClass colorWithRed:red Green:green Blue:blue Alpha:1.0];
            [lineColorA addObject:color];
            
            
        }
    }
    
}

#pragma  mark - DRAW

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    if([myPathArray count]==0)
        return;
    
    if(_xValElements==nil)
        return;
    
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(ctx, NO);
    CGContextSetShouldAntialias(ctx, NO);
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    [self drawBgPattern:ctx];
    [self drawHorizontalBgLines:ctx];
    
    
    
    if(_gridWidth > self.frame.size.width)
    {
        
        for (UIView *view in lineGScrollView.subviews) 
            if([view isKindOfClass:[MultiLineLongGraph class]])
            {
                [view removeFromSuperview];
            }
        
        
        
        MultiLineLongGraph *graph=[[MultiLineLongGraph alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, self.frame.size.height)];
        graph.gridHeight=_gridHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.lineColorArray=lineColorA;
        graph.lineBezierPath=myPathArray;
        graph.aPropertiesArray=[NSMutableArray arrayWithArray:aPropertiesArray];
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
        [lineGScrollView addSubview:graph];
        
        return;
        
    }
    
    
    
    
    [self drawVerticalBgLines:ctx];
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    for (int i=0; i<[myPathArray count]; i++) 
    {
        MIMColorClass *c=[lineColorA objectAtIndex:i];
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha]; 
        [_color setStroke];  
        UIBezierPath *myP=[myPathArray objectAtIndex:i];
        [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        
        
        
    }
    
    [self _drawAnchorPoints];
    
    
    
    
    
    
    
}


-(void)drawBgPattern:(CGContextRef)ctx
{
    
    //Check if User has given any color for Background
    if(self.backgroundColor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:backgroundColor.red green:backgroundColor.green blue:backgroundColor.blue alpha:backgroundColor.alpha].CGColor);
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


-(void)drawVerticalBgLines:(CGContextRef)ctx
{
    BOOL verticalLinesVisible=TRUE;
    if([vlProperties valueForKey:@"hide"]) 
        verticalLinesVisible=[[vlProperties valueForKey:@"hide"] boolValue];
    
    if(!verticalLinesVisible)
    {
        NSLog(@"Caution:Vertical Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawVerticalLines:");
        
        return;
    }
    
    
    //Width
    float widthOfLine=0.1;
    if([vlProperties valueForKey:@"width"]) 
        widthOfLine=[[vlProperties valueForKey:@"width"] floatValue];
    
    if(widthOfLine==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    //Color
    MIMColorClass *c=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
    if([vlProperties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[vlProperties valueForKey:@"color"]];
    
    
    
    
    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    
    int numVertLines=_gridWidth/_tileWidth;
    
    if(xIsString)
    {
        if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]]) numVertLines=[_xValElements count];
        else numVertLines=[[_xValElements objectAtIndex:0] count];
        
        
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



#pragma mark - draw Anchors



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
        NSMutableDictionary *aProperties;
        if ([aPropertiesArray count]>index)
            aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
        else aProperties=[[NSMutableDictionary alloc] init];
        
        
        
        if([aProperties valueForKey:@"hide"])
            if([[aProperties valueForKey:@"hide"] boolValue])
                return;
        
        
        
        
        
        MIMColorClass *c=[lineColorA objectAtIndex:index];
        float red=c.red;
        float green=c.green;
        float blue=c.blue;
        float alpha=c.alpha;
        
        
        
        if(![aProperties valueForKey:@"fillColor"])
            [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
        
        if([anchorTypeArray count] !=[_yValElements count])
            NSLog(@"WARNING:Not enough values in anchorTypeArray");
        
        if ([anchorTypeArray count]>index)
            [aProperties setValue:[anchorTypeArray objectAtIndex:index] forKey:@"style"];
        
        if([[_yValElements objectAtIndex:index] isKindOfClass:[NSString class]])
        {
            for (int l=0; l<[_yValElements count]; l++) 
            {   
                float valueY=[[_yValElements objectAtIndex:l] floatValue]-minimumOnY;
                float valueX;
                if(xIsString)
                    valueX=(float)l;
                else
                    valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                float mX=valueX*_scalingX;
                float mY=valueY*_scalingY;
                mY=_gridHeight-mY;
                
                
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
                NSArray *yArray_=[_yValElements objectAtIndex:k];
                for (int l=0; l<[yArray_ count]; l++) 
                {   
                    float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                    float valueX;
                    if(xIsString)
                        valueX=(float)l;
                    else
                        valueX=[[_xValElements objectAtIndex:l] floatValue];
                    
                    
                    
                    
                    float mX=valueX*_scalingX;
                    float mY=valueY*_scalingY;
                    mY=_gridHeight-mY;
                    
                    
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
    
    
    AnchorInfo *aInfo=[[AnchorInfo alloc]initWithFrame:CGRectMake(point.x-10, point.y-30, 320, 20)];
    [aInfo setTagID:tagID];
    
    
    //Find ta belongs to which line
    int index=0;
    for (int k=0; k<[myPathArray count]; k++) 
    {
        if((tagID >= 10000*k)&&(tagID < 10000*(k+1)))
        {
            index=k;
            break;
        }
    }
    
    tagID=tagID-10000*index;
    
    
    float anchorY=[[[_yValElements objectAtIndex:index] objectAtIndex:tagID] floatValue];
    NSString *xS;
    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        xS=[_xValElements objectAtIndex:tagID];
    }
    else
    {
        xS=[[_xValElements objectAtIndex:index] objectAtIndex:tagID];
    }
    
    
    if(xIsString)
        [aInfo setInfoString:[NSString stringWithFormat:@"(%@,%.0f)",xS,anchorY]];
    else
        [aInfo setInfoString:[NSString stringWithFormat:@"(%.0f,%.0f)",[xS floatValue],anchorY]];
    
    
    
    
    [self addSubview:aInfo];
    //[aInfo setNeedsDisplay];
}


#pragma mark - X and Y Axis stuff


-(void)_displayXAxisLabels
{
    BOOL xLabelsVisible=FALSE;
    if([xLProperties valueForKey:@"hide"]) 
        xLabelsVisible=[[xLProperties valueForKey:@"hide"] boolValue];
    
    if(xLabelsVisible)
        return;
    
    if([[xLProperties allKeys] count]==0)
        xLProperties=[[NSMutableDictionary alloc] init];
    
    [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"linechart"];
    [xLProperties setValue:[NSNumber numberWithFloat:_scalingX] forKey:@"xscaling"];
    
    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    _xBand.properties=xLProperties;
    _xBand.xElements=[[NSArray alloc]initWithArray:_xTitles];
    [self addSubview:_xBand];
    
}



-(void)_displayYAxisLabels
{
    BOOL yLabelsVisible=FALSE;
    if([yLProperties valueForKey:@"hide"]) 
        yLabelsVisible=[[yLProperties valueForKey:@"hide"] boolValue];
    
    if(yLabelsVisible)
        return;
    
    if([[yLProperties allKeys] count]==0)
        yLProperties=[[NSMutableDictionary alloc] init];
    
    [yLProperties setValue:[NSNumber numberWithFloat:pixelsPerTile] forKey:@"pxpertile"];
    [yLProperties setValue:[NSNumber numberWithInt:numOfHLines] forKey:@"num"];
    [yLProperties setValue:[NSNumber numberWithFloat:minimumOnY] forKey:@"minY"];
    [yLProperties setValue:[NSNumber numberWithFloat:_tileHeight] forKey:@"tileHeight"];
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame)+10)];
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}



@end
