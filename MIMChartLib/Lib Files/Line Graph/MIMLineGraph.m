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
    BOOL _isLongGraph;
    BOOL fitsToScreenWidth;
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

    float yAxisWidth;
    float xAxisHeight;
    
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


-(void)drawMIMLineGraph
{
    BOOL multipleLines=[self initAndWarnings];
    
    
    BOOL addRandomAnchorType=TRUE;
    if (self.anchorTypeArray) addRandomAnchorType=FALSE;
    
    
    
    float _leftMargin=leftMargin+yAxisWidth;
    float _bottomMargin=bottomMargin+xAxisHeight;
    
    if(_isLongGraph)
    {
        _leftMargin=0;
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
                
                
                if(l==0) [myPath moveToPoint:CGPointMake(valueX*_scalingX +_leftMargin , valueY*_scalingY + _bottomMargin)];
                else [myPath addLineToPoint:CGPointMake(valueX*_scalingX +_leftMargin , valueY*_scalingY+ _bottomMargin)];
                
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
            
            float mX=valueX*_scalingX +_leftMargin;
            float mY=valueY*_scalingY+ _bottomMargin;
            if(l==0)
                [lineBezierPath moveToPoint:CGPointMake(mX,mY)];
            else
                [lineBezierPath addLineToPoint:CGPointMake(mX,mY)];
            
        }
        
        
        [myPathArray addObject:lineBezierPath];
        if (addRandomAnchorType) [anchorTypeArray addObject:[NSNumber numberWithInt:rand()%7+1]];
        
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
    anchorTypeArray=[[NSMutableArray alloc]init];
    xTitleStyle=X_TITLES_STYLE1;
    mbackgroundColor=nil;
    
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
    
    
    if(_tileHeight+10 > _gridHeight)
    {
        NSLog(@"ERROR: frame too small to draw.!!");
        
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
    if(HorLines-1 ==0) pixelPerTile=(maxOfY-minOfY)/(HorLines);
    
    
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
    
    
    if([yLProperties valueForKey:@"width"])
        yAxisWidth=[[yLProperties valueForKey:@"width"] floatValue];
    
    if([xLProperties valueForKey:@"height"])
        xAxisHeight=[[xLProperties valueForKey:@"height"] floatValue];

    
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
    if(_isLongGraph)
    {

        
        lineGScrollView=[[LineScrollView alloc]initWithFrame:CGRectMake(leftMargin+yAxisWidth, 0, CGRectGetWidth(self.frame)-leftMargin-rightMargin-yAxisWidth -10, self.frame.size.height)];
        [lineGScrollView setBackgroundColor:[UIColor clearColor]];
        lineGScrollView.contentSize=CGSizeMake(_gridWidth, self.frame.size.height);
        
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
    
    
    
    
    
    
    [MIMProperties drawBgPattern:ctx color:mbackgroundColor gridWidth:(CGRectGetWidth(self.frame)-yAxisWidth-leftMargin-rightMargin) gridHeight:_gridHeight leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    
    [MIMProperties drawHorizontalBgLines:ctx withProperties:hlProperties gridHeight:_gridHeight tileHeight:_tileHeight gridWidth:(CGRectGetWidth(self.frame)-yAxisWidth-leftMargin-rightMargin) leftMargin:leftMargin+yAxisWidth topMargin:topMargin];
    
    

    
    if(_isLongGraph)
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
        graph.leftMargin=leftMargin;
        graph.bottomMargin=bottomMargin;
        
        [lineGScrollView addSubview:graph];
        
        return;
        
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
    
    if(![xLProperties valueForKey:@"style"]) [xLProperties setValue:[NSNumber numberWithInt:xTitleStyle] forKey:@"style"];
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



@end
