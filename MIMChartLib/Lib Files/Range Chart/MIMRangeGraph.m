//
//  MIMRangeChart.m
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import "MIMRangeGraph.h"

@interface  MIMRangeGraph()
{
    
    NSMutableArray *myPathArray;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    NSArray *_xTitles;
    NSArray *_xNumericValues;
    
    float _contentWidth;
    float _gridWidth;
    float _gridHeight;///==float _contentHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    
    float _tileHeight;
    BOOL _tileWidthDefinedByUser;
    float offsetXLabelOnLongGraph;
    
    BOOL xIsString;
    BOOL _isLongGraph;
    BOOL fitsToScreenWidth;
    float pixelsPerTile;
    int numOfHLines;
    float minimumOnY;
    NSMutableArray *lineColorA;
    int itemCountOnXAxis;
    
    NSMutableArray *aPropertiesArray;
    NSMutableDictionary *hlProperties;
    NSMutableDictionary *vlProperties;
    NSMutableDictionary *xLProperties;
    NSMutableDictionary *yLProperties;
    
    
    LineScrollView *lineGScrollView;
    
    float yAxisWidth;
    float xAxisHeight;
    
}
-(BOOL)initAndWarnings;
//(void)_drawAnchorPoints;
-(void)_displayXAxisLabels;
-(void)_displayYAxisLabels;







@end


@implementation MIMRangeGraph


@synthesize mbackgroundColor;
@synthesize xTitleStyle;
@synthesize delegate;
@synthesize anchorTypeArray;
@synthesize rangeColorArray;
@synthesize minimumLabelOnYIsZero;
@synthesize titleLabel;
@synthesize rightMargin,topMargin,leftMargin,bottomMargin;
@synthesize rangeLineThickness;





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



-(void)drawMIMRangeGraph
{
    offsetXLabelOnLongGraph=0;
    BOOL multipleLines=[self initAndWarnings];
    
    
    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;
    
    
    
    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin+xAxisHeight;
    
    if(_isLongGraph)
    {
        _leftMargin=0;
        //_bottomMargin=0;
    }
    
    
    //Now Save the Path
    //In form of BezierPath
    myPathArray=[[NSMutableArray alloc]init];

    for (int l=0; l<[_xValElements count]; l+=2)
    {
        
        //Create the Bezier Path
        UIBezierPath *lineBezierPath=[[UIBezierPath alloc]init];
        lineBezierPath.lineWidth=1.0;
        lineBezierPath.lineJoinStyle=kCGLineJoinRound;
        
        float valueX;
        
        if(xIsString)
            valueX=(float)l;
        else
            valueX=[[_xValElements objectAtIndex:l] floatValue];
        
        float mX;
        float mX2;
        //Currently it supports only date version
        {
            //Find valueX
            
            NSString *startDateString=[_xValElements objectAtIndex:l];
            NSString *endDateString=[_xValElements objectAtIndex:l+1];
            
            NSArray *dateComp=[startDateString componentsSeparatedByString:@"."];
            int day=[[dateComp objectAtIndex:1] intValue];
            int month=[[dateComp objectAtIndex:0] intValue];
            int year=[[dateComp objectAtIndex:2] intValue];
            
            //Find BEGIN DATE month and year matches with which in _xNumeric
            for(int i=0;i<[_xNumericValues count];i++)
            {
                NSString *xNumString=[_xNumericValues objectAtIndex:i];
                NSArray *xNumComp=[xNumString componentsSeparatedByString:@"."];
                if ([xNumComp count]<2) continue;
                int xmonth=[[xNumComp objectAtIndex:0] intValue];
                int xyear=[[xNumComp objectAtIndex:1] intValue];
                
                if((month==xmonth)&&(year==xyear))
                {
                    
                    mX=i*_tileWidth;
                    
                    //Add the amount for date component.
                    mX+=(_tileWidth*day/30);
                    
                    break;
                }
                
            }
            
            
            
            dateComp=[endDateString componentsSeparatedByString:@"."];
            day=[[dateComp objectAtIndex:1] intValue];
            month=[[dateComp objectAtIndex:0] intValue];
            year=[[dateComp objectAtIndex:2] intValue];
            
            //Find END DATE month and year matches with which in _xNumeric
            for(int i=0;i<[_xNumericValues count];i++)
            {
                NSString *xNumString=[_xNumericValues objectAtIndex:i];
                NSArray *xNumComp=[xNumString componentsSeparatedByString:@"."];
                if ([xNumComp count]<2) continue;
                int xmonth=[[xNumComp objectAtIndex:0] intValue];
                int xyear=[[xNumComp objectAtIndex:1] intValue];
                
                if((month==xmonth)&&(year==xyear))
                {
                    
                    mX2=i*_tileWidth;
                    
                    //Add the amount for date component.
                    mX2+=(_tileWidth*day/30);
                    
                    break;
                }
                
            }
            
        
        }
        
        //float mX=valueX*_scalingX +_leftMargin;
        float mY=((l/2)*_scalingY) + _bottomMargin + _scalingY;
        mX+=_leftMargin;
        mX2+=_leftMargin;
        
        if (_isLongGraph) {
            
            mY+=topMargin;
        }
        
        [lineBezierPath moveToPoint:CGPointMake(mX+offsetXLabelOnLongGraph,mY)];
        [lineBezierPath addLineToPoint:CGPointMake(mX2+offsetXLabelOnLongGraph,mY)];
        [myPathArray addObject:lineBezierPath];
        //if (addRandomAnchorType) [anchorTypeArray addObject:[NSNumber numberWithInt:rand()%7+1]];
        
    }
    

    
    titleLabel.frame=CGRectMake(leftMargin, topMargin+_gridHeight+xAxisHeight+5, CGRectGetWidth(self.frame)-leftMargin-rightMargin, 20);
    
    [self createLineColorArray];//Get colors for the line
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
}





#pragma mark - INIT AND CALCULATIONS

-(void)initVars
{
    offsetXLabelOnLongGraph=0;
    rangeLineThickness=1;
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=XTitleStyle2;
    mbackgroundColor=nil;
    _isLongGraph=FALSE;
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
    
    titleLabel.text=@"Line Chart Title";
    
}



-(BOOL)initAndWarnings
{
    //reMove everythng which is there
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    
    srand(time(NULL));
    
    
    
    [MIMColor InitFragmentedBarColors];
    
    _yValElements=[[NSMutableArray alloc]init];

    

    xIsString=TRUE;
    if([delegate respondsToSelector:@selector(valuesForXAxis:)])
    {
        NSArray *valueArray_=[delegate valuesForXAxis:self];
        if(valueArray_)
        {
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
            if([[valueArray_ objectAtIndex:0] isKindOfClass:[NSString class]]||[[valueArray_ objectAtIndex:0] isKindOfClass:[NSNumber class]]) {}
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
    //-(NSArray *)numericValuesForXAxis:(id)graph;
    
    if([delegate respondsToSelector:@selector(numericValuesForXAxis:)])
    {
        _xNumericValues=[[NSArray alloc]initWithArray:[delegate numericValuesForXAxis:self]];
        if([_xNumericValues count]==0)
        {
            NSLog(@"ERROR :Give values in titlesForXAxis: to give display values on X-Axis.");
        }
        
    }
    else
    {
        NSLog(@"ERROR : You need to provide the numeric values in numericValuesForXAxis:.");
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
    
    
    //[self drawLineInfoBox];
    //[self CalculateGridDimensions];
    _gridWidth=self.frame.size.width;
    _gridWidth=[MIMProperties CalculateGridWidth:_gridWidth leftMargin:leftMargin rightMargin:rightMargin yAxisSpace:yAxisWidth];
    
    _gridHeight=self.frame.size.height;
    _gridHeight=[MIMProperties CalculateGridHeight:_gridHeight bottomMargin:bottomMargin topMargin:topMargin xAxisSpace:xAxisHeight];
    
    itemCountOnXAxis=[MIMProperties countXValuesInArray:[NSMutableArray arrayWithArray:_xNumericValues]];

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
    
    
    
    float minOfY=[MIMProperties findGlobalMinimum:_yValElements];
    //float maxOfY=[MIMProperties findGlobalMaximum:_yValElements];
    
    
    minimumOnY=[MIMProperties findMinimumOnY:minOfY];
    _scalingY=[MIMProperties findScaleForYTile:_yValElements gridHeight:_gridHeight tileHeight:_tileHeight :numOfHLines Min:0 Max:0];
    _scalingX=[MIMProperties findScaleForXTile:_xValElements XValuesAreString:xIsString LongGraph:_isLongGraph TileWidth:_tileWidth TileWidthDefinedByUser:_tileWidthDefinedByUser];
    pixelsPerTile=_tileHeight/_scalingY;
    
    
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

    
    
    [self createLongLineGraphScrollView];
    //[self addSetterButton];
    
    return multipleLines;
    
}



-(void)createLineColorArray
{
    //Colors defined by user
    //Now it can be a single color or multiple color
    if(rangeColorArray)
    {
        lineColorA=[[NSMutableArray alloc] initWithArray:rangeColorArray];
        return;
    }
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    //------
    BOOL pickDefaultColorForLineChart;
    
    
    if([delegate respondsToSelector:@selector(ColorsForRangeChart:)])
    {
        lineColorA=[[NSMutableArray alloc]initWithArray:[delegate ColorsForRangeChart:self]];
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
    
    //By Default, pick same colors for all ranges
    //If not satisfied, user can call ColorsForRangeChart or rangeColorArray
    if(pickDefaultColorForLineChart)
    {
        lineColorA=[[NSMutableArray alloc]init];
        NSDictionary *_colorDic=[MIMColor GetColorAtIndex:rand()%totalColors];
        float red= [[_colorDic valueForKey:@"red"] floatValue];
        float green=[[_colorDic valueForKey:@"green"] floatValue];
        float blue=[[_colorDic valueForKey:@"blue"] floatValue];
        
        MIMColorClass *color=[MIMColorClass colorWithRed:red Green:green Blue:blue Alpha:1.0];
        [lineColorA addObject:color];
    }
    
}

-(void)createLongLineGraphScrollView
{
    if(_isLongGraph)
    {
        _contentWidth=[MIMProperties returnLongGraphContentWidth:_scalingX TotalItemsOnXAxis:itemCountOnXAxis];
        float contentHeight=self.frame.size.height-bottomMargin-topMargin;
        
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, topMargin, _gridWidth -5, contentHeight)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.contentSize=CGSizeMake(_contentWidth, contentHeight);
        
        [lineGScrollView setShowsHorizontalScrollIndicator:NO];
        [lineGScrollView setShowsVerticalScrollIndicator:NO];
        
        
        [self addSubview:lineGScrollView];
    }
}


#pragma mark - DRAW
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
    
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddRect(ctx, r);
    CGContextFillPath(ctx);
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);
    
    
    
    
    
    
    
    if(_isLongGraph)
    {
        
        for (UIView *view in lineGScrollView.subviews)
            if([view isKindOfClass:[MIMLongRangeGraph class]])
            {
                [view removeFromSuperview];
            }
        
        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_scalingY gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        
        
        MIMLongRangeGraph *graph=[[MIMLongRangeGraph alloc]initWithFrame:CGRectMake(0, 0, _contentWidth, self.frame.size.height)];
        graph.gridHeight=_gridHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.rangeLineThickness=rangeLineThickness;
        graph.lineColorArray=lineColorA;
        graph.lineBezierPath=myPathArray;
        graph.aPropertiesArray=[NSMutableArray arrayWithArray:aPropertiesArray];
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
        graph.leftMargin=leftMargin;
        graph.bottomMargin=bottomMargin;
        graph.xAxisHeight=xAxisHeight;
        [lineGScrollView addSubview:graph];
       
        
        return;
        
    }
    else{
        
        
        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_scalingY gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        
    }
    
    
    
    [MIMProperties drawVerticalBgLines:ctx withProperties:vlProperties gridHeight:_gridHeight tileWidth:_tileWidth gridWidth:_gridWidth scalingX:_scalingX xIsString:xIsString bottomMargin:bottomMargin leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    for (int i=0; i<[myPathArray count]; i++)
    {
        MIMColorClass *c=[lineColorA objectAtIndex:0];
        if([lineColorA count]==[myPathArray count])
        {
            c=[lineColorA objectAtIndex:i];
        }
        
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
        [_color setStroke];
        UIBezierPath *myP=[myPathArray objectAtIndex:i];
        [myP setLineWidth:rangeLineThickness];
        [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];

    }
    
   // [self _drawAnchorPoints];
    
    
    
    
    
    
    
}


-(void)_displayXAxisLabels
{
    
    
    
    if([[xLProperties allKeys] count]==0)
        xLProperties=[[NSMutableDictionary alloc] init];
    
    if(![xLProperties valueForKey:@"style"]) [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
    [xLProperties setValue:[NSNumber numberWithBool:xIsString] forKey:@"xisstring"];
    [xLProperties setValue:[NSNumber numberWithBool:YES] forKey:@"linechart"];
    [xLProperties setValue:[NSNumber numberWithFloat:_scalingX] forKey:@"xscaling"];
    [xLProperties setValue:[NSNumber numberWithFloat:offsetXLabelOnLongGraph] forKey:@"xoffset"];

    
    
    
    XAxisBand *_xBand;
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
    [yLProperties setValue:[NSNumber numberWithFloat:_scalingY] forKey:@"tileHeight"];
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(leftMargin,topMargin-10, yAxisWidth, _gridHeight+20)];
    _yBand.properties=yLProperties;
    _yBand.yTitles=_yValElements;
    //Add one more element at index 0.
    [self addSubview:_yBand];
    
    
}

@end
