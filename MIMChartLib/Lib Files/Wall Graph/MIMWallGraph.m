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
    BOOL _isLongGraph;
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

    float yAxisWidth;
    float xAxisHeight;
    float contentSizeX;
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
@synthesize fitsToScreenWidth,isGradient,displayMeterline,meterLineYOffset;
@synthesize xTitleStyle,mbackgroundColor;
@synthesize delegate;
@synthesize anchorTypeArray,wallColorArray,wallGradientArray;
@synthesize minimumLabelOnYIsZero,titleLabel;
@synthesize rightMargin,topMargin,leftMargin,bottomMargin;





- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        [self initVars];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor clearColor];
        [self initVars];
    }
    return self;
}



-(void)drawMIMWallGraph
{

    if(displayMeterline) METERLINEHEIGHT =0;
    else METERLINEHEIGHT =0;

    BOOL multipleLines=[self initAndWarnings];


    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;

    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin+xAxisHeight;

    
    if(_gridWidth>CGRectGetWidth(self.frame))
    {
        _leftMargin=0;
        _bottomMargin=0;
        
    }
    
    
    
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
                    [myPath moveToPoint:CGPointMake(valueX*_scalingX +_leftMargin , valueY*_scalingY + _bottomMargin)];
                else
                    [myPath addLineToPoint:CGPointMake(valueX*_scalingX +_leftMargin, valueY*_scalingY+ _bottomMargin)];
                
                
                
                if(l==0)
                    [myLinePath moveToPoint:CGPointMake(valueX*_scalingX +_leftMargin, valueY*_scalingY+ _bottomMargin)];
                else
                    [myLinePath addLineToPoint:CGPointMake(valueX*_scalingX +_leftMargin, valueY*_scalingY+ _bottomMargin)];
                
                
                
                if(l==[yArray_ count]-1)
                {
                    [myPath addLineToPoint:CGPointMake(valueX*_scalingX +_leftMargin, _bottomMargin)];
                    [myPath addLineToPoint:CGPointMake(0 +_leftMargin , _bottomMargin)];
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
                [myPath moveToPoint:CGPointMake(valueX*_scalingX  +_leftMargin, valueY*_scalingY+ _bottomMargin)];
            else
                [myPath addLineToPoint:CGPointMake(valueX*_scalingX  +_leftMargin, valueY*_scalingY+ _bottomMargin)];
            
            
            
            if(i==0)
                [myLinePath moveToPoint:CGPointMake(valueX*_scalingX  +_leftMargin, valueY*_scalingY+ _bottomMargin)];
            else
                [myLinePath addLineToPoint:CGPointMake(valueX*_scalingX  +_leftMargin, valueY*_scalingY+ _bottomMargin)];
            
            
            
            if(i==[_yValElements count]-1)
            {
                [myPath addLineToPoint:CGPointMake(valueX*_scalingX  +_leftMargin, _bottomMargin)];
                [myPath addLineToPoint:CGPointMake(0  +_leftMargin, _bottomMargin)];
            }

            
            
            
        }
        
      
        
        
        [myPathArray addObject:myPath ];
        [myLinePathArray  addObject:myLinePath];
        [orderArray insertObject:[NSNumber numberWithInt:0] atIndex:0];
        
    }


    [self createWallColorArray];//Get colors for the line
    
    titleLabel.frame=CGRectMake(leftMargin, topMargin+_gridHeight+xAxisHeight+5, CGRectGetWidth(self.frame)-leftMargin-rightMargin, 20);
    titleLabel.text=@"Wall Chart Title";
    
    
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
    meterLineYOffset=70;
    
    
    rightMargin=0;
    topMargin=0;
    leftMargin=0;
    bottomMargin=0;
    
    yAxisWidth=50;
    xAxisHeight=70;
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [self addSubview:titleLabel];
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
    
    
    _gridWidth=self.frame.size.width;
    _gridWidth-=leftMargin;
    _gridWidth-=rightMargin;
    _gridWidth-=yAxisWidth;
    
    _tileWidth=_gridWidth/count;
    _tileHeight=_tileWidth;
    
    if(fitsToScreenWidth)
    {
    
    }
    else
    {
        int perPixel=_gridWidth/count;
        if(perPixel < 10)
        {
            //Increase the gridwidth
            _isLongGraph=TRUE;
            _gridWidth=5*count;
            _tileHeight=50;
        }
       
    }
    
    
    _gridHeight=self.frame.size.height;  
    _gridHeight-=bottomMargin;
    _gridHeight-=topMargin;
    _gridHeight-=xAxisHeight;

    
}   


-(void)FindTileWidthAndHeight
{
    
    //Check if Tilewidth is defined by user
    
    if([vlProperties valueForKey:@"gap"]) 
        _tileWidth=[[vlProperties valueForKey:@"gap"] floatValue];
    
    if(_tileWidth==0)
    {
        _tileWidth=10;
        NSLog(@"WARNING: Minimum gap between vertical lines is 10.");
    }
    
    //HEIGHT
    
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
        
        if(_isLongGraph)
        {
            NSLog(@"Since graph is too long, it auto resizes the tilewidth to 5.");
            _scalingX=5;
        }
        
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
    
    if([yLProperties valueForKey:@"width"])
        yAxisWidth=[[yLProperties valueForKey:@"width"] floatValue];
    
    if([xLProperties valueForKey:@"height"])
        xAxisHeight=[[xLProperties valueForKey:@"height"] floatValue];

    
    
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
        _isLongGraph=TRUE;
        
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, 0, CGRectGetWidth(self.frame)-leftMargin-rightMargin-yAxisWidth -10, self.frame.size.height)];
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
            CGFloat components[8] = { l.red, l.green, l.blue, 0.4,  // Start color
                d.red, d.green, d.blue, 1.0}; // End color
            
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
    
    
    
    
   
    
    //Clear the color of background
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddRect(ctx, r);      
    CGContextFillPath(ctx);
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);

    
    

    
    [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:(CGRectGetWidth(self.frame)-yAxisWidth-leftMargin-rightMargin) gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:(CGRectGetWidth(self.frame)-yAxisWidth-leftMargin-rightMargin) leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    if(_gridWidth > self.frame.size.width)
    {
        MultiWallLongGraph *graph=[[MultiWallLongGraph alloc]initWithFrame:CGRectMake(0, topMargin, _gridWidth, _gridHeight)];
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
        graph.leftMargin=leftMargin;
        graph.bottomMargin=bottomMargin+xAxisHeight;
        graph.rightMargin=rightMargin;
        graph.topMargin=topMargin;
        [lineGScrollView addSubview:graph];
        
        
        return;
        
    }
    
    
    [MIMProperties drawVerticalBgLines:ctx withProperties:vlProperties gridHeight:_gridHeight tileWidth:_tileWidth gridWidth:_gridWidth scalingX:_scalingX xIsString:xIsString bottomMargin:bottomMargin leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    

    
    float _bottomMargin=bottomMargin+xAxisHeight;
    
    
    if(_gridWidth>CGRectGetWidth(self.frame))
    {
        _bottomMargin=0;
        
    }
    
    
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

            
            
            
            
            CGContextDrawLinearGradient (ctx, g, CGPointMake(0, (maxOfY -minimumOnY) * _scalingY + _bottomMargin ),CGPointMake(0, bottomMargin) , 1);
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
                
                float mX=valueX*_scalingX + leftMargin+yAxisWidth;
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
                NSArray *yArray_=[_yValElements objectAtIndex:k];
                for (int l=0; l<[yArray_ count]; l++) 
                {   
                    float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                    float valueX;
                    if(xIsString)
                        valueX=(float)l;
                    else
                        valueX=[[_xValElements objectAtIndex:l] floatValue];
                    
                    
                    
                    
                    float mX=valueX*_scalingX + leftMargin+yAxisWidth;
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
   
    
    
    if([[xLProperties allKeys] count]==0)
        xLProperties=[[NSMutableDictionary alloc] init];
    
    [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"linechart"];
    [xLProperties setValue:[NSNumber numberWithFloat:_scalingX] forKey:@"xscaling"];
    
    
    XAxisBand *_xBand;
    if(_isLongGraph)
        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,_gridHeight+topMargin, _gridWidth, xAxisHeight)];
    else 
        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth,_gridHeight+topMargin, _gridWidth, xAxisHeight)];
    
    
    
    _xBand.properties=xLProperties;
    _xBand.xElements=[[NSArray alloc]initWithArray:_xTitles];
    
     
    if(_isLongGraph) [lineGScrollView addSubview:_xBand];
    else [self addSubview:_xBand];
    
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
    

    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(leftMargin,topMargin, yAxisWidth, _gridHeight+10)];
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}


#pragma mark - METER 
-(void)createMeterline
{

    meterLine=[[MIMMeter alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, topMargin, 40,_gridHeight+meterLineYOffset)];
    meterLine.maxPointX=leftMargin+yAxisWidth+_gridWidth;
    meterLine.minPointX=leftMargin+yAxisWidth;
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
