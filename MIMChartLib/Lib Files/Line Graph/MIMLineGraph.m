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
    
    
    float _contentWidth;
    float _gridWidth;
    float _gridHeight;///==float _contentHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    float _tileHeight;
    BOOL _tileWidthDefinedByUser;
    
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
    
    float offsetXLabelOnLongGraph;
    
    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
}
-(BOOL)initAndWarnings;
-(void)_drawAnchorPoints;
-(void)_displayXAxisLabels;
-(void)_displayYAxisLabels;
-(void)_findScaleForYTile;
-(void)_findScaleForXTile;




@end


@implementation MIMLineGraph


@synthesize mbackgroundColor;
@synthesize xTitleStyle;
@synthesize delegate;
@synthesize anchorTypeArray;
@synthesize lineColorArray;
@synthesize minimumLabelOnYIsZero;
@synthesize titleLabel;


#pragma mark -
#pragma mark - INIT

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

-(void)removeAllExistingSubViews
{
    


}


-(void)drawMIMLineGraph
{
    //Get the margins
    rightMargin=margin.rightMargin;
    topMargin=margin.topMargin;
    leftMargin=margin.leftMargin;
    bottomMargin=margin.bottomMargin;
    
    
    
    offsetXLabelOnLongGraph=0;
    BOOL multipleLines=[self initAndWarnings];
    
    
    BOOL addRandomAnchorType=TRUE;
    if ([self.anchorTypeArray count]!=0)
        addRandomAnchorType=FALSE;
    
    
    
    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin+xAxisHeight;
    
    if(_isLongGraph)
    {
        _leftMargin=0;
        _bottomMargin=0;
    }
    
    
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
                
                
                float mX=valueX*_scalingX +_leftMargin;
                float mY=valueY*_scalingY+ _bottomMargin;
                
                if (_isLongGraph) {
                    
                    mX+=offsetXLabelOnLongGraph;
                    mY+=xAxisHeight;
                }
                
                

                
                if(l==0)
                    [myPath moveToPoint:CGPointMake(mX,mY)];
                else
                    [myPath addLineToPoint:CGPointMake(mX,mY)];
                
                
            }
            
            [myPathArray addObject:myPath];
            
            if (addRandomAnchorType)
                [anchorTypeArray addObject:[NSNumber numberWithInt:CIRCLEFILLED]];
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
            
            float mX=valueX*_scalingX +_leftMargin;
            float mY=valueY*_scalingY+ _bottomMargin;
            
            if (_isLongGraph) {
                
                mX+=offsetXLabelOnLongGraph;
                mY+=xAxisHeight;
                
                NSLog(@"line y=%f",mY);

            }
            
            
            if(l==0)
                [lineBezierPath moveToPoint:CGPointMake(mX,mY)];
            else
                [lineBezierPath addLineToPoint:CGPointMake(mX,mY)];
            
        }
        
        
        [myPathArray addObject:lineBezierPath];
        
        if (addRandomAnchorType)
            [anchorTypeArray addObject:[NSNumber numberWithInt:CIRCLEFILLED]];
        
    }
    
    
   
    //titleLabel.frame=CGRectMake(leftMargin, topMargin+_gridHeight+xAxisHeight+5, CGRectGetWidth(self.frame)-leftMargin-rightMargin, 20);
    
    [self createLineColorArray];//Get colors for the line
    [self setNeedsDisplay];
    [self _displayXAxisLabels];
    [self _displayYAxisLabels];
}





#pragma mark - INIT AND CALCULATIONS

-(void)initVars
{
    offsetXLabelOnLongGraph=0;
    
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=XTitleStyle3;
    mbackgroundColor=nil;
    _isLongGraph=FALSE;
    
    
    rightMargin=0;
    topMargin=0;
    leftMargin=0;
    bottomMargin=0;
    
    
    yAxisWidth=50;
    xAxisHeight=70;
    
    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _gridWidth, 20)];
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
    for (UIView *view in self.subviews)
    if(![view isEqual:titleLabel]){
        
        [view removeFromSuperview];
    }
    
    
    srand(time(NULL));
    
    
    
    [MIMColor InitFragmentedBarColors];
    
    
    
    
    
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
    //NSLog(@"on line graph _gridHeight=%f",_gridHeight);
    
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
    
    
    

    float minOfY=0;
    float maxOfY=[MIMProperties findGlobalMaximum:_yValElements];
    
    if(!minimumLabelOnYIsZero)
        minOfY=[MIMProperties findGlobalMinimum:_yValElements];

    minimumOnY=minOfY;
    
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

    
    
    [self createLongLineGraphScrollView];
    //[self addSetterButton];
    
    NSLog(@" for line graph _scalingY=%f",_scalingY);
    
    return multipleLines;
    
}

-(void)createLongLineGraphScrollView
{
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

-(void)createLineColorArray
{
    if(lineColorArray)
    {
        lineColorA=[[NSMutableArray alloc] initWithArray:lineColorArray];
        return;
    }
    
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
    
    if(_yValElements==nil)return;

    if([_yValElements count]==0)return;
    
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
        if([view isKindOfClass:[MultiLineLongGraph class]])
        {
            [view removeFromSuperview];
        }
        
        
        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        
        float contentHeight=self.frame.size.height-bottomMargin-topMargin;
        
        MultiLineLongGraph *graph=[[MultiLineLongGraph alloc]initWithFrame:CGRectMake(0, 0, _contentWidth, contentHeight)];
        graph.gridHeight=_gridHeight;
        graph.scalingX=_scalingX;
        graph.scalingY=_scalingY;
        graph.xIsString=xIsString;
        graph.xOffset=offsetXLabelOnLongGraph;
        graph.lineColorArray=lineColorA;
        graph.lineBezierPath=myPathArray;
        graph.aPropertiesArray=aPropertiesArray;
        graph.xValElements=[[NSMutableArray alloc]initWithArray:_xValElements];
        graph.yValElements=[[NSMutableArray alloc]initWithArray:_yValElements];
        graph.anchorTypeArray=anchorTypeArray;//contains just type.
        graph.minimumOnY=minimumOnY;
        graph.leftMargin=leftMargin;
        graph.bottomMargin=bottomMargin;
        graph.xAxisHeight=xAxisHeight;
        [lineGScrollView addSubview:graph];
        
      
        
        return;
        
    }
    else{
    

        [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:_gridWidth gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
        [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:_gridWidth leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    }
    
    

    [MIMProperties drawVerticalBgLines:ctx withProperties:vlProperties gridHeight:_gridHeight tileWidth:_tileWidth gridWidth:_gridWidth scalingX:_scalingX xIsString:xIsString bottomMargin:bottomMargin leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);

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
    
    UIGraphicsPopContext();

    
    [self _drawAnchorPoints];
    
    
    

    
    
    
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
    
    
    
    if([anchorTypeArray count] !=[myPathArray count])
    {
        NSLog(@"%i,%i",[anchorTypeArray count],[myPathArray count]);
        NSLog(@"WARNING:Not enough values in anchorTypeArray");
    }
    
    for (int index=0; index<[myPathArray count]; index++)
    {
        NSMutableDictionary *aProperties;
        
        if ([aPropertiesArray count]>index)
            aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
        else
            aProperties=[[NSMutableDictionary alloc] init];
        
        
        
        if([aProperties valueForKey:@"hide"])
            if([[aProperties valueForKey:@"hide"] boolValue])
                return;
        
        
        //If fill color is not defined by user, it is same as line color
        if(![aProperties valueForKey:@"fillColor"])
        {
            MIMColorClass *c=[lineColorA objectAtIndex:index];
            float red=c.red;
            float green=c.green;
            float blue=c.blue;
            float alpha=c.alpha;
            
            [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
        }
        

        
        
        if ([anchorTypeArray count]>index)
            [aProperties setValue:[anchorTypeArray objectAtIndex:index] forKey:@"style"];
        
        
        if([[_yValElements objectAtIndex:index] isKindOfClass:[NSString class]]||[[_yValElements objectAtIndex:index] isKindOfClass:[NSNumber class]])
        {
            for (int l=0; l<[_yValElements count]; l++) 
            {   
                float valueY=[[_yValElements objectAtIndex:l] floatValue]-minimumOnY;
                float valueX;
                if(xIsString)
                    valueX=(float)l;
                else
                    valueX=[[_xValElements objectAtIndex:l] floatValue];
                
                //NSLog(@"_scalingX=%f,%f",_scalingX,_scalingY);
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
    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]]||[[_xValElements objectAtIndex:0] isKindOfClass:[NSNumber class]])
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



@end
