//
//  MIMWallGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMWallGraph.h"

@interface MIMWallGraph ()
{
    
    NSMutableArray *myPathArray;
    NSMutableArray *myLinePathArray;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    NSMutableArray *_wallColorArray;
    NSMutableArray *_wallGradientArray;
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
    float maximumOnY;
    NSMutableArray *maxValuesArray;
    BOOL anchorDefined;
    
    NSMutableArray *wProperties;
    NSMutableArray *aPropertiesArray;
    
    NSMutableDictionary *hlProperties;
    NSMutableDictionary *vlProperties;
    NSMutableDictionary *xLProperties;
    NSMutableDictionary *yLProperties;
    
    
    LineScrollView *lineGScrollView;
    NSMutableArray *orderArray;//Saves the order of z-axis
    NSMutableArray *_edgeColorArray;
    
    MIMMeter *meterLine;
    float METERLINEHEIGHT;
    int currentAnchorIndex;
}

-(void)initVars;
-(void)CalculateGridDimensions;
-(void)FindTileWidthAndHeight;
-(void)ScalingFactor;
-(void)_findScaleForYTile;
-(void)_findScaleForXTile;
-(BOOL)initAndWarnings;
@end

@implementation MIMWallGraph
@synthesize fitsToScreenWidth,isGradient,displayMeterline;
@synthesize xTitleStyle,mbackgroundColor;
@synthesize delegate;
@synthesize anchorTypeArray,wallColorArray,wallGradientArray;
@synthesize minimumLabelOnYIsZero;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self initVars];
    }
    return self;
}

-(void)drawMIMWallGraph
{

    if(displayMeterline) METERLINEHEIGHT =30;
    else METERLINEHEIGHT =0;

    BOOL multipleLines=[self initAndWarnings];


    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;

    
    
    
    
    
    myPathArray=[[NSMutableArray alloc]init];
    myLinePathArray=[[NSMutableArray alloc]init];
    orderArray=[[NSMutableArray alloc]init];


    //Now Save the Path
    //In form of BezierPath
    int outerLoop=1;
    if(multipleLines)
    {
        outerLoop=[_yValElements count];
        
        
        NSMutableArray *averageArray=[[NSMutableArray alloc]init];
        
        for (int k=0; k<outerLoop; k++) 
        {
            
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=1.0;
            //       myPath.flatness=2.0;
            //        myPath.miterLimit=5.0;
            myPath.lineJoinStyle=kCGLineJoinRound;
            
            
            
            UIBezierPath *myLinePath=[[UIBezierPath alloc]init];
            
            myLinePath.lineWidth=1.0;
            //       myPath.flatness=2.0;
            //        myPath.miterLimit=5.0;
            myLinePath.lineJoinStyle=kCGLineJoinRound;
            
            
            NSArray *yArray_;
            
            yArray_=[_yValElements objectAtIndex:k];
            
            
            float averageY=0;
            for (int l=0; l<[yArray_ count]; l++) 
            {   
                
                float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                float valueX;
                if(xIsString)
                    valueX=(float)l;
                else
                    valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                
                if(l==0)
                    [myPath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY + METERLINEHEIGHT)];
                else
                    [myPath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
                
                
                
                if(l==0)
                    [myLinePath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
                else
                    [myLinePath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
                
                
                
                if(l==[yArray_ count]-1)
                {
                    [myPath addLineToPoint:CGPointMake(valueX*_scalingX , 0)];
                    [myPath addLineToPoint:CGPointMake(0 , 0)];
                }
                
                averageY+=valueY;
                
            }
            averageY=averageY/[yArray_ count];
            
            
            
            [averageArray addObject:[NSNumber numberWithFloat:averageY]];
            
            //Find where the newPath should be inserted 
            //depending on average value of Y
            int min=0;
            for (int l=0; l<[averageArray count]; l++) 
            {
                if(averageY < [[averageArray objectAtIndex:l] floatValue])
                    min++;
                
            }
            
            
            [myPathArray insertObject:myPath atIndex:min];
            [myLinePathArray  insertObject:myLinePath atIndex:min];
            [orderArray insertObject:[NSNumber numberWithInt:k] atIndex:min];
        }
        
        

    }
    else
    {
        
        UIBezierPath *myPath=[[UIBezierPath alloc]init];
        myPath.lineWidth=1.0;
        myPath.lineJoinStyle=kCGLineJoinRound;
        
        
        
        UIBezierPath *myLinePath=[[UIBezierPath alloc]init];
        myLinePath.lineWidth=1.0;
        myLinePath.lineJoinStyle=kCGLineJoinRound;
        

        

        for (int i=0; i<[_yValElements count]; i++)
        {
            float valueY=[[_yValElements objectAtIndex:i] floatValue]-minimumOnY;
            float valueX=i;
            if(!xIsString) valueX=[[_xValElements objectAtIndex:i] intValue];

            
            
            
            if(i==0)
                [myPath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
            else
                [myPath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
            
            
            
            if(i==0)
                [myLinePath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
            else
                [myLinePath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY+ METERLINEHEIGHT)];
            
            
            
            if(i==[_yValElements count]-1)
            {
                [myPath addLineToPoint:CGPointMake(valueX*_scalingX , 0)];
                [myPath addLineToPoint:CGPointMake(0 , 0)];
            }

            
            
            
        }
        
      
        
        
        [myPathArray addObject:myPath ];
        [myLinePathArray  addObject:myLinePath];
        [orderArray insertObject:[NSNumber numberWithInt:0] atIndex:0];
        
    }


    [self createWallColorArray];//Get colors for the line
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
    if(displayMeterline)[self createMeterline];
}






#pragma mark - INIT AND CALCULATIONS

-(void)initVars
{
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=X_TITLES_STYLE1;
    currentAnchorIndex=-1;
    
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


    _gridHeight=_gridHeight-METERLINEHEIGHT;

    
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
    
    maxValuesArray=[[NSMutableArray alloc]init];
    
    float maxOfY;
    float minOfY;
    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
        minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
        
        [maxValuesArray addObject:[NSNumber numberWithFloat:maxOfY]];
        
    }
    else
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:[_yValElements objectAtIndex:0]];
        [maxValuesArray addObject:[NSNumber numberWithFloat:maxOfY]];

        for (int i=1; i<[_yValElements count]; i++) 
        {
            float maxOfY1=[MIM_MathClass getMaxFloatValue:[_yValElements objectAtIndex:i]];
            [maxValuesArray addObject:[NSNumber numberWithFloat:maxOfY1]];
            
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
    
    
    
    

    
    maximumOnY=(maxOfY-minOfY);
    
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
    
    if(isGradient)[MIMColor nonAdjacentGradient];
    else [MIMColor InitColors];
        
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    
    
    
    
    
    
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
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
    
    
    if([delegate respondsToSelector:@selector(WallProperties:)])
        if([delegate WallProperties:self]!=nil)
        {
            wProperties=[[NSMutableArray alloc]initWithArray:[delegate WallProperties:self]];
        }
    
    
    [self CalculateGridDimensions];
    [self createLongLineGraphScrollView];
    [self FindTileWidthAndHeight];
    [self ScalingFactor];
    
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


-(void)createWallColorArray
{
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    
    BOOL pickDefaultColor=TRUE;
    _wallColorArray=[[NSMutableArray alloc]init];
    
    
    NSDictionary *wDict;
    for (int i=0; i<[wProperties count]; i++) 
    {
        wDict=[wProperties objectAtIndex:i];
        if([[wDict allKeys] count]>0)
        {
            if([wDict valueForKey:@"wallcolor"])
            {
                pickDefaultColor=FALSE; 
                [_wallColorArray addObject:[MIMColorClass colorWithComponent:[wDict valueForKey:@"wallcolor"]]];
            }
            if([wDict valueForKey:@"edgecolor"])
            {
                pickDefaultColor=FALSE; 
                [_edgeColorArray addObject:[MIMColorClass colorWithComponent:[wDict valueForKey:@"edgecolor"]]];
            }
            else
            {
                MIMColorClass *c=[MIMColorClass colorWithComponent:[wDict valueForKey:@"wallcolor"]];
                [_edgeColorArray addObject:[MIMColorClass colorWithRed:c.red Green:c.green Blue:c.blue Alpha:1.0]];
            }
        } 
    }
    
    if(wallColorArray)_wallColorArray=[NSMutableArray arrayWithArray:wallColorArray];
    if(!_edgeColorArray)
    {
        _edgeColorArray=[[NSMutableArray alloc]init];
        for (MIMColorClass *c in _wallColorArray) 
            [_edgeColorArray addObject:[MIMColorClass colorWithRed:c.red Green:c.green Blue:c.blue Alpha:1.0]];
        
    }
    
    //Gradient is On and gradients are given by user.
    if(isGradient && wallGradientArray)
        return;
    
    if(pickDefaultColor && isGradient)
    {
        _wallGradientArray=[[NSMutableArray alloc]init];
        for (int i=0; i<[myPathArray count]; i++) 
        {
            int r=rand()%(totalColors-1);
            if(r%2==1)r=r-1;
            
            MIMColorClass *d=[MIMColor GetMIMColorAtIndex:r%totalColors];
            MIMColorClass *l=[MIMColor GetMIMColorAtIndex:r+1%totalColors];
            
            CGGradientRef gradient;
            CGColorSpaceRef colorspace;
            size_t num_locations = 2;
            CGFloat locations[2] = { 0.0, 1.0 };
            CGFloat components[8] = { d.red, d.green, d.blue, 1.0,  // Start color
                l.red, l.green, l.blue, 0.4}; // End color
            
            colorspace = CGColorSpaceCreateDeviceRGB();
            gradient = CGGradientCreateWithColorComponents (colorspace, components, locations, num_locations);
            
            [_wallGradientArray addObject:(__bridge id)gradient];
            [_edgeColorArray addObject:[MIMColorClass colorWithRed:d.red Green:d.green Blue:d.blue Alpha:1.0]];
            [_wallColorArray addObject:[MIMColorClass colorWithRed:d.red Green:d.green Blue:d.blue Alpha:1.0]];
        }
       
        
        wallGradientArray=[NSArray arrayWithArray:_wallGradientArray];
    
        return;
    }
    
    
    if(pickDefaultColor)
    {
        
        for (int i=0; i<[myPathArray count]; i++) 
        {
            
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:rand()%totalColors];
            float red= [[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            
            [_wallColorArray addObject:[MIMColorClass colorWithRed:red Green:green Blue:blue Alpha:0.4]];
            [_edgeColorArray addObject:[MIMColorClass colorWithRed:red Green:green Blue:blue Alpha:1.0]];
            
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
    
    
    //Clear the color of background
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddRect(ctx, r);      
    CGContextFillPath(ctx);
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);

    
    [self drawBgPattern:ctx];
    [self drawHorizontalBgLines:ctx];
    
    
    
    
    if(_gridWidth > self.frame.size.width)
    {
        MultiWallLongGraph *graph=[[MultiWallLongGraph alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, self.frame.size.height)];
        graph.gridHeight=_gridHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.isGradient=isGradient;
        graph.wallBezierPath=[[NSArray alloc]initWithArray:myPathArray];
        graph.wallEdgeBezierPath=[[NSArray alloc]initWithArray:myLinePathArray];
        graph.wallColorArray=_wallColorArray;        
        graph.edgeColorArray=_edgeColorArray;
        graph.wallGradientArray=wallGradientArray;
        graph.maxValuesArray=maxValuesArray;
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
        graph.METERLINEHEIGHT=METERLINEHEIGHT;
        
        [lineGScrollView addSubview:graph];
        
        
        return;
        
    }
    
    
    [self drawVerticalBgLines:ctx];
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    

    
    
    
    
    for (int i=0; i<[myPathArray count]; i++) 
    {
        MIMColorClass *c=[_wallColorArray objectAtIndex:i];
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha]; 
        [_color setFill];
        
        UIBezierPath *myP=[myPathArray objectAtIndex:i];
       
        if(isGradient)
        {
            int oIndex=[[orderArray objectAtIndex:i] intValue];
            float maxOfY=[[maxValuesArray objectAtIndex:oIndex] floatValue];

            
            CGContextSaveGState(ctx);

            [myP closePath];

            [myP addClip];


            CGGradientRef g=(__bridge CGGradientRef )[wallGradientArray objectAtIndex:i];

            CGContextDrawLinearGradient (ctx, g, CGPointMake(0, METERLINEHEIGHT), CGPointMake(0, maxOfY * _scalingY), 0);
            CGContextRestoreGState(ctx);
        }
        else
        {
            [myP fillWithBlendMode:kCGBlendModeNormal alpha:1.0];   
        }
        
        [self _drawWallEdge:ctx AtIndex:i]; 
    }
    
    
    
    
    
    [self _drawAnchorPoints];
    
    
    
    CGContextFlush(ctx);
    
    
    
    
    
}
-(void)_drawWallEdge:(CGContextRef)ctx AtIndex:(int)index
{
    MIMColorClass *c=[_edgeColorArray objectAtIndex:index];
    UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    [_color setStroke];
    
    UIBezierPath *myP=[myLinePathArray objectAtIndex:index];
    [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    
}


-(void)drawBgPattern:(CGContextRef)ctx
{
    
    
    //Check if User has given any color for Background
    if(self.mbackgroundColor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:mbackgroundColor.red green:mbackgroundColor.green blue:mbackgroundColor.blue alpha:mbackgroundColor.alpha].CGColor);
        CGContextFillRect(ctx, CGRectMake(0, METERLINEHEIGHT, _gridWidth, _gridHeight));
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
    
    CGContextDrawLinearGradient(ctx, bgRadialGradient, CGPointMake(0, METERLINEHEIGHT), CGPointMake(0, _gridHeight), 0 );
    if(!CGContextIsPathEmpty(ctx))CGContextClip(ctx);
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
            CGContextMoveToPoint(ctx, i * _scalingX,METERLINEHEIGHT);
            CGContextAddLineToPoint(ctx, i * _scalingX,_gridHeight);
        }
        
    }
    else
    {
        for (int i=0; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i*_tileWidth,METERLINEHEIGHT);
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
        CGContextMoveToPoint(ctx, 0,i*_tileHeight + METERLINEHEIGHT);
        CGContextAddLineToPoint(ctx,_gridWidth , i*_tileHeight+ METERLINEHEIGHT);
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
        int wIndex=[[orderArray objectAtIndex:index] intValue];
        
        NSMutableDictionary *aProperties;
        if ([aPropertiesArray count]>index)
            aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
        else aProperties=[[NSMutableDictionary alloc] init];
        
        
        
        if([aProperties valueForKey:@"hide"])
            if([[aProperties valueForKey:@"hide"] boolValue])
                return;
        
        
        
        
        
        MIMColorClass *c=[_wallColorArray objectAtIndex:wIndex];
        float red=c.red;
        float green=c.green;
        float blue=c.blue;
        float alpha=c.alpha;
        
        
        
        if(![aProperties valueForKey:@"fillColor"])
            [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
        
        
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
    
    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,_gridHeight, _gridWidth, 100)];
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
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, _gridHeight+10)];
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}


#pragma mark - METER 
-(void)createMeterline
{
    NSLog(@"_tileWidth=%f",_tileWidth);
    meterLine=[[MIMMeter alloc]initWithFrame:CGRectMake(80, 0, 40, CGRectGetHeight(self.frame))];
    meterLine.maxPointX=CGRectGetWidth(self.frame)-20;
    meterLine.minPointX=0;
    meterLine.delegate=self;
    if(xIsString)meterLine.tileWidth=_scalingX;
    [self addSubview:meterLine];
}

-(void)meterCrossingAnchorPoint:(int)index
{
    if(currentAnchorIndex ==index)return;
    
    currentAnchorIndex=index;
    
    
    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        
        
        for (UIView *view in self.subviews) 
        if([view isKindOfClass:[Anchor class]])
        {
            if([(Anchor*)view anchorTag]==index)
            {
                //Pop bounce Animation
                [(Anchor*)view createBounceAnimation];
                break;
            }
            
        }

    }
    else
    {
        /*
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
         */
        
    }
    
    
}



@end
