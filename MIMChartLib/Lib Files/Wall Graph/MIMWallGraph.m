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
    
    
    float _contentWidth;
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
    int itemCountOnXAxis;
    BOOL _tileWidthDefinedByUser;
    
    
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
    
    Anchor *longGraphAnchor;
    
    //When we draw graph as long graph, the graph needs to be shifted to right a little bit
    //so that the first x-axis label doesnt get hidden by the scrollview's x-origin line.
    float offsetXLabelOnLongGraph;
    
    
    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
    
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
@synthesize margin;





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

    //Get the margins
    rightMargin=margin.rightMargin;
    topMargin=margin.topMargin;
    leftMargin=margin.leftMargin;
    bottomMargin=margin.bottomMargin;
    
    
    offsetXLabelOnLongGraph=0;
    
    if(displayMeterline) METERLINEHEIGHT =0;
    else METERLINEHEIGHT =0;

    BOOL multipleLines=[self initAndWarnings];


    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;

    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin+xAxisHeight;

    
    if(_isLongGraph)
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
                
                
                if(xIsString) valueX=(float)l;
                else valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                
                
                
                float mX=valueX*_scalingX +_leftMargin;
                float mY=valueY*_scalingY+ _bottomMargin;
                
                if (_isLongGraph) {
                    
                    mX+=offsetXLabelOnLongGraph;
                    mY+=xAxisHeight;
                }
                
            
                
                if(l==0)
                {
                    [myPath moveToPoint:CGPointMake(mX , mY)];
                    [myLinePath moveToPoint:CGPointMake(mX, mY)];
                }
                else
                {
                    [myPath addLineToPoint:CGPointMake(mX, mY)];
                    [myLinePath addLineToPoint:CGPointMake(mX, mY)];
                }
                
             
                
                
                
                if(l==[yArray_ count]-1)
                {
                    mX=valueX*_scalingX+_leftMargin;
                    
                    if (_isLongGraph) {
                        
                        mX+=offsetXLabelOnLongGraph;
                        mY=xAxisHeight;
                    }
                    else
                        mY=_bottomMargin;
                    

                    
                    [myPath addLineToPoint:CGPointMake(mX, mY)];
                    [myPath addLineToPoint:CGPointMake(_leftMargin , mY)];
                    
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

         
            
            
            
            float mX=valueX*_scalingX +_leftMargin;
            float mY=valueY*_scalingY+ _bottomMargin;
            
            if (_isLongGraph) {
                
                mX+=offsetXLabelOnLongGraph;
                mY+=xAxisHeight;
                
                //NSLog(@"mX=%f",mX);
                //NSLog(@"line y=%f",mY);

            }
            
            
            
            if(i==0)
            {
                [myPath moveToPoint:CGPointMake(mX , mY)];
                [myLinePath moveToPoint:CGPointMake(mX, mY)];
            }
            else
            {
                [myPath addLineToPoint:CGPointMake(mX, mY)];
                [myLinePath addLineToPoint:CGPointMake(mX, mY)];
            }
  
            
            if(i==[_yValElements count]-1)
            {
                mX=valueX*_scalingX+_leftMargin;
                
                if (_isLongGraph) {
                
                    mY=xAxisHeight;
                    mX+=offsetXLabelOnLongGraph;

                }
                else
                    mY=_bottomMargin;
                
                [myPath addLineToPoint:CGPointMake(mX, mY)];
                [myPath addLineToPoint:CGPointMake(_leftMargin, mY)];
                
                //NSLog(@"mX=%f",mX);
                //NSLog(@"line y=%f",mY);
                
            }

            
            
            
        }
        
      
        
        
        [myPathArray addObject:myPath ];
        [myLinePathArray  addObject:myLinePath];
        [orderArray insertObject:[NSNumber numberWithInt:0] atIndex:0];
        
    }


    [self createWallColorArray];//Get colors for the line
    
    //titleLabel.frame=CGRectMake(leftMargin, topMargin+_gridHeight+xAxisHeight+5, CGRectGetWidth(self.frame)-leftMargin-rightMargin, 20);
    
    
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
    if(displayMeterline)[self createMeterline];
}






#pragma mark - INIT AND CALCULATIONS

-(void)initVars
{
    offsetXLabelOnLongGraph=0;
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=XTitleStyle1;
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
    
    titleLabel.text=@"Wall Chart Title";

}


-(BOOL)initAndWarnings
{
    //reMove everythng which is there
    for (UIView *view in self.subviews)
    if(![view isEqual:titleLabel]){
        [view removeFromSuperview];
    }
    
    
    srand(time(NULL));
    
    if(isGradient)[MIMColor nonAdjacentGradient];
    else [MIMColor InitColors];
        
    
    
    
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        NSAssert(([valueArray_ count] !=0),@"WARNING::No values available for x-Axis Labels.");
        
        
        if([valueArray_ count]>0)
        {
            _xValElements=[[NSMutableArray alloc]initWithArray:valueArray_];
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
            _yValElements=[[NSMutableArray alloc]initWithArray:valueArray_];
        
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
    
    
    _tileWidthDefinedByUser=FALSE;
    if([[vlProperties allKeys] containsObject:@"gap"])
        _tileWidthDefinedByUser=TRUE;
    
    
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
    
    
    
    
    _gridWidth=self.frame.size.width;
    _gridWidth=[MIMProperties CalculateGridWidth:_gridWidth leftMargin:leftMargin rightMargin:rightMargin yAxisSpace:yAxisWidth];
    
    _gridHeight=self.frame.size.height;
    _gridHeight=[MIMProperties CalculateGridHeight:_gridHeight bottomMargin:bottomMargin topMargin:topMargin xAxisSpace:xAxisHeight];
    
    itemCountOnXAxis=[MIMProperties countXValuesInArray:_xValElements];
    
    
    
    //[self FindTileWidthAndHeight];
    _tileHeight=[MIMProperties FindTileHeight:hlProperties GridHeight:_gridHeight];
    _tileWidth=[MIMProperties FindTileWidth:vlProperties GridWidth:_gridWidth xItemsCount:itemCountOnXAxis];
    
    
    //WE need to figure out if tileHeight*numOfHLines + 10 >=_gridHeight
    //If not, then try reducing numOfHLines
    numOfHLines=_gridHeight/_tileHeight;
    
    if(numOfHLines < 3)
        _tileHeight=[MIMProperties fixTileHeight:_gridHeight];
    
    
    _isLongGraph=[MIMProperties findIfItIsALongGraph:_tileWidth TotalItemsOnXAxis:itemCountOnXAxis GridWidth:_gridWidth];
    
    //[self ScalingFactor];
    
    
    float minOfY=0;//[MIMProperties findGlobalMinimum:_yValElements];
    float maxOfY=[MIMProperties findGlobalMaximum:_yValElements];
    
    //minimumOnY=[MIMProperties findMinimumOnY:minOfY];
    
    if(!minimumLabelOnYIsZero)
        minOfY=[MIMProperties findGlobalMinimum:_yValElements];
    
    minimumOnY=minOfY;
    
    //Rounding it off.
    if(!minimumLabelOnYIsZero)
        minimumOnY=[MIMProperties findMinimumOnY:minOfY];
    
    
    
    _scalingY=[MIMProperties findScaleForYTile:_yValElements gridHeight:_gridHeight tileHeight:_tileHeight :numOfHLines Min:minOfY Max:maxOfY];
    pixelsPerTile=_tileHeight/_scalingY;
    
    
    
    _scalingX=[MIMProperties findScaleForXTile:_xValElements XValuesAreString:xIsString LongGraph:_isLongGraph TileWidth:_tileWidth TileWidthDefinedByUser:_tileWidthDefinedByUser];
    _contentWidth=[MIMProperties returnLongGraphContentWidth:_scalingX TotalItemsOnXAxis:itemCountOnXAxis];
    if(_contentWidth < _gridWidth)
    {
        _isLongGraph=NO;
        _scalingX=[MIMProperties findScaleForXTile:_xValElements XValuesAreString:xIsString LongGraph:_isLongGraph TileWidth:_tileWidth TileWidthDefinedByUser:_tileWidthDefinedByUser];
        
    }

    
    if (_isLongGraph) {
        
        offsetXLabelOnLongGraph=_scalingX/4;
        if(offsetXLabelOnLongGraph<20)offsetXLabelOnLongGraph=20;
    }

    
//    [self CalculateGridDimensions];
//    [self FindTileWidthAndHeight];
//    [self ScalingFactor];
    
    [self createLongLineGraphScrollView];
    
    return multipleLines;
    
    
}

-(void)createLongLineGraphScrollView
{
    [self createMaxVaueArray];
    if(_isLongGraph)
    {
        float contentHeight=self.frame.size.height-bottomMargin-topMargin;
        
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, topMargin, _gridWidth -5, contentHeight)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.contentSize=CGSizeMake(_contentWidth, contentHeight);
        [lineGScrollView setShowsHorizontalScrollIndicator:NO];
        [lineGScrollView setShowsVerticalScrollIndicator:NO];

        [self addSubview:lineGScrollView];
        
    }
    
}


-(void)createMaxVaueArray
{
    maxValuesArray=[[NSMutableArray alloc]init];

    
    
    if([[_yValElements objectAtIndex:0]isKindOfClass:[NSString class]])
    {
        float maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
        [maxValuesArray addObject:[NSNumber numberWithFloat:maxOfY]];
        

    }
    else
    {
        
        for (int i=0; i<[_yValElements count]; i++)
        {
            float maxOfY1=[MIM_MathClass getMaxFloatValue:[_yValElements objectAtIndex:i]];
            [maxValuesArray addObject:[NSNumber numberWithFloat:maxOfY1]];
            
        }
    }
    
    
    
    
}

-(void)createWallColorArray
{
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    
    BOOL pickDefaultColor=TRUE;
    _wallColorArray=[[NSMutableArray alloc]init];
    _edgeColorArray=[[NSMutableArray alloc]init];
    
    NSDictionary *wDict;
    for (int i=0; i<[wProperties count]; i++) 
    {
        wDict=[wProperties objectAtIndex:i];
        if([[wDict allKeys] count]>0)
        {
            if([wDict objectForKey:@"wallcolor"])
            {
                pickDefaultColor=FALSE; 
                [_wallColorArray addObject:[MIMColorClass colorWithComponent:[wDict valueForKey:@"wallcolor"]]];
            }
            else
            {
                MIMColorClass *c=[MIMColorClass colorWithComponent:[wDict valueForKey:@"edgecolor"]];
                [_wallColorArray addObject:[MIMColorClass colorWithRed:c.red Green:c.green Blue:c.blue Alpha:0.4]];
            }
            if([wDict objectForKey:@"edgecolor"])
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
    
    if(wallColorArray)
        _wallColorArray=[NSMutableArray arrayWithArray:wallColorArray];
    
    if([_edgeColorArray count]==0)
    {

        for (MIMColorClass *c in _wallColorArray)
            [_edgeColorArray addObject:[MIMColorClass colorWithRed:c.red Green:c.green Blue:c.blue Alpha:1.0]];
        
    }
    
    //Gradient is On and gradients are given by user.
    if(isGradient && !pickDefaultColor)
    {
        _wallGradientArray=[[NSMutableArray alloc]init];
        for (int i=0; i<[myPathArray count]; i++)
        {
        
            MIMColorClass *d=[_wallColorArray objectAtIndex:i];
            MIMColorClass *l=[_wallColorArray objectAtIndex:i];
            
            CGGradientRef gradient;
            CGColorSpaceRef colorspace;
            size_t num_locations = 2;
            CGFloat locations[2] = { 0.0, 1.0 };
            CGFloat components[8] = { l.red, l.green, l.blue, 0.5,  // Start color
                d.red, d.green, d.blue, 1.0}; // End color
            
            colorspace = CGColorSpaceCreateDeviceRGB();
            gradient = CGGradientCreateWithColorComponents (colorspace, components, locations, num_locations);
            
            [_wallGradientArray addObject:(__bridge id)gradient];
        }
        
        
        wallGradientArray=[NSArray arrayWithArray:_wallGradientArray];

        
        return;
    }
        
    
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


    
    
    if(_isLongGraph)
    {
        
        for (UIView *view in lineGScrollView.subviews)
        if([view isKindOfClass:[MultiWallLongGraph class]])
        {
            [view removeFromSuperview];
        }
        
        
        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        
        
        MultiWallLongGraph *graph=[[MultiWallLongGraph alloc]initWithFrame:CGRectMake(0, 0, _contentWidth, self.frame.size.height-topMargin-bottomMargin)];
        graph.gridHeight=_gridHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.isGradient=isGradient;
        graph.xOffset=offsetXLabelOnLongGraph;
        graph.minimumOnY=minimumOnY;
        graph.orderArray=orderArray;
        
        graph.wallBezierPath=[[NSArray alloc]initWithArray:myPathArray];
        graph.wallEdgeBezierPath=[[NSArray alloc]initWithArray:myLinePathArray];
        
        graph.wallColorArray=_wallColorArray;        
        graph.edgeColorArray=_edgeColorArray;
        graph.wallGradientArray=wallGradientArray;
        graph.aPropertiesArray=aPropertiesArray;
        graph.anchorTypeArray=anchorTypeArray;//contains just type.
        graph.maxValuesArray=maxValuesArray;
        
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
        graph.METERLINEHEIGHT=METERLINEHEIGHT;
        
        graph.leftMargin=leftMargin;
        graph.bottomMargin=bottomMargin+xAxisHeight;
        graph.rightMargin=rightMargin;
        graph.topMargin=topMargin;
        
        [lineGScrollView addSubview:graph];
        
        
        [lineGScrollView bringSubviewToFront:meterLine];
        
        return;
        
    }
    else{
        
        
        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        
    }
    
//    [MIMProperties drawVerticalBgLines:ctx withProperties:vlProperties gridHeight:_gridHeight tileWidth:_tileWidth gridWidth:_gridWidth scalingX:_scalingX xIsString:xIsString bottomMargin:bottomMargin leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
//    
//    
    [MIMProperties drawVerticalBgLines:ctx withProperties:vlProperties gridHeight:_gridHeight tileWidth:_tileWidth gridWidth:_gridWidth scalingX:_scalingX xIsString:xIsString bottomMargin:bottomMargin leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    

    
    float _bottomMargin=bottomMargin+xAxisHeight;
    
    
    if(_isLongGraph)
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

            //topMargin+_gridHeight - (maxOfY*_scalingY)//topMargin+_gridHeight
            NSLog(@"%f,%f,%f,%f",topMargin+_gridHeight - (maxOfY*_scalingY),topMargin+_gridHeight,_scalingY,maxOfY);
            CGContextDrawLinearGradient (ctx, g,CGPointMake(0, topMargin+_gridHeight - (maxOfY*_scalingY)-2) ,CGPointMake(0, topMargin+_gridHeight+2) , 0);
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
        
        
        
        
        
        MIMColorClass *c=[_edgeColorArray objectAtIndex:wIndex];
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
    

    
    if(![xLProperties valueForKey:@"style"])
        [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    
    
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"linechart"];
    [xLProperties setValue:[NSNumber numberWithFloat:_scalingX] forKey:@"xscaling"];
    [xLProperties setValue:[NSNumber numberWithFloat:offsetXLabelOnLongGraph] forKey:@"xoffset"];    
    [xLProperties setValue:[NSNumber numberWithFloat:xAxisHeight] forKey:@"xheight"];
    
    XAxisBand *_xBand;
//    if(_isLongGraph)
//        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,_gridHeight, _contentWidth, xAxisHeight)];
//    else 
//        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth,_gridHeight+topMargin, _gridWidth, xAxisHeight)];
//    
//    
    if(_isLongGraph)
        _xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,_gridHeight, _contentWidth+offsetXLabelOnLongGraph,xAxisHeight)];//
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
    

    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(leftMargin,topMargin-10, yAxisWidth, _gridHeight+20)];
    _yBand.properties=yLProperties;
    [self addSubview:_yBand];
    
    
}


#pragma mark - METER 
-(void)createMeterline
{
    if(_gridWidth>CGRectGetWidth(self.frame))
    {
        meterLine=[[MIMMeter alloc]initWithFrame:CGRectMake(_scalingX, topMargin, 40,_gridHeight+meterLineYOffset)];
        meterLine.maxPointX=_gridWidth;
        meterLine.minPointX=0;
        meterLine.delegate=self;
        if(xIsString)meterLine.tileWidth=_scalingX;
        [lineGScrollView addSubview:meterLine];
    }
    else 
    {
        meterLine=[[MIMMeter alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, topMargin, 40,_gridHeight+meterLineYOffset)];
        meterLine.maxPointX=leftMargin+yAxisWidth+_gridWidth;
        meterLine.minPointX=leftMargin+yAxisWidth;
        meterLine.delegate=self;
        if(xIsString)meterLine.tileWidth=_scalingX;
        [self addSubview:meterLine];
    }
    
    
}

-(void)meterCrossingAnchorPoint:(int)index
{

    if(currentAnchorIndex ==index)return;
    
    currentAnchorIndex=index;
    
    
    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        //Long Wall
        if(_gridWidth>CGRectGetWidth(self.frame))
        {
            
            
            NSMutableDictionary *aProperties;
            if ([aPropertiesArray count]>0)
                aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:0]];
            else aProperties=[[NSMutableDictionary alloc] init];
            
            MIMColorClass *c=[_wallColorArray objectAtIndex:0];
            float red=c.red;
            float green=c.green;
            float blue=c.blue;
            float alpha=c.alpha;
            
            
            
            if(![aProperties valueForKey:@"fillColor"])
                [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
            
            
            if ([anchorTypeArray count]>index)
                [aProperties setValue:[anchorTypeArray objectAtIndex:index] forKey:@"style"];

            
            
            if(!longGraphAnchor)
                longGraphAnchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            
            if(index <[_yValElements count])
            for (int l=index; l<index+1; l++) 
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
                mY+=topMargin;
                

                longGraphAnchor.center=CGPointMake(mX,mY);
                longGraphAnchor.properties=aProperties;
                longGraphAnchor.anchorTag=l;
                longGraphAnchor.delegate=self;
                [lineGScrollView addSubview:longGraphAnchor];
                [longGraphAnchor drawAnchor];
                
            }
            
            [self displayFloatingView:longGraphAnchor];
            
        }
        else 
        {
            for (UIView *view in self.subviews) 
                if([view isKindOfClass:[Anchor class]])
                {
                    if([(Anchor*)view anchorTag]==index)
                    {
                        //Pop bounce Animation
                        [(Anchor*)view createBounceAnimation];
                        [self displayFloatingView:view];
                        break;
                    }
                    
                }
        }
        

    }
    else
    {
        //Multiple Walls.
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

-(void)displayFloatingView:(id)view
{
    Anchor *bView=(Anchor *)view;
    int tagVal=bView.anchorTag;
    
    
    if(!floatingView)
    {
        floatingView=[[MIMFloatingView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        
    }
  
    
    MIMColorClass *l=[_wallColorArray objectAtIndex:0];
    floatingView.barColor=[UIColor colorWithRed:l.red green:l.green blue:l.blue alpha:1.0];

    
    
        if([_xTitles count]>0)
            [floatingView setLabelsOnView:[_yValElements objectAtIndex:tagVal] subtitle:[_xTitles objectAtIndex:tagVal]];
        else
            [floatingView setLabelsOnView:[_yValElements objectAtIndex:tagVal] subtitle:[_xValElements objectAtIndex:tagVal]];
    
    
    if(_gridWidth>CGRectGetWidth(self.frame))[lineGScrollView addSubview:floatingView];
    else 
        [self addSubview:floatingView];
    
    //Create border of floatingview layer
    CALayer *layer=floatingView.layer;
    layer.borderWidth=1;
    layer.borderColor=[UIColor darkGrayColor].CGColor;
    layer.cornerRadius=3;
    
    
    if(_gridWidth>CGRectGetWidth(self.frame))
    {
        CGRect a=floatingView.frame;
        if(CGRectGetMaxX(bView.frame) > _gridWidth-120) a.origin.x=CGRectGetMaxX(bView.frame)-120;
        else a.origin.x=CGRectGetMaxX(bView.frame);
        a.origin.y=CGRectGetMinY(bView.frame)-40;
        floatingView.frame=a;  
    }
    else
    {
        CGRect a=floatingView.frame;
        a.origin.x=CGRectGetMaxX(bView.frame)-10;
        a.origin.y=CGRectGetMinY(bView.frame)-40;
        floatingView.frame=a;
    }
    
    
    
}

@end
