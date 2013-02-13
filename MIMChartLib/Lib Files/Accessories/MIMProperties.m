//
//  MIMProperties.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMProperties.h"
#import "MIM_MathClass.h"

#define DEFAULT_TILEWIDTH 40
#define DEFAULT_TILEHEIGHT 40

@implementation MIMProperties




+(void)drawHorizontalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)hlProperties gridHeight:(float)gridHeight tileHeight:(float)tileHeight gridWidth:(float)gridWidth leftMargin:(float)leftMargin topMargin:(float)topMargin;

{
    
    float _tileHeight=tileHeight;
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    
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
    
    //Find if it needs to be dotted line
    NSString *dotted=@"";
    if([hlProperties valueForKey:@"dotted"]) 
        dotted=[hlProperties valueForKey:@"dotted"];
    
    
    
    CGContextSaveGState(ctx);
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    int numHorzLines=_gridHeight/_tileHeight;
    //NSLog(@"_tileHeight=%f",_tileHeight);
    
    for (int i=1; i<=numHorzLines; i++) 
    {    
        CGContextMoveToPoint(ctx, leftMargin,gridHeight+topMargin- i*_tileHeight );
        CGContextAddLineToPoint(ctx,_gridWidth+leftMargin ,gridHeight+topMargin- i*_tileHeight);
    }
    
    if([dotted isEqualToString:@""])
    {    
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    else 
    {
        NSArray *c=[dotted componentsSeparatedByString:@","];
        
        NSEnumerator *enumerator;
        float * floatArray;
        id floatObject;
        int index=0;
        
        floatArray = (float *) malloc(sizeof(float) * [c count]);
        enumerator = [c objectEnumerator];
        while(floatObject = [enumerator nextObject])
        {
            floatArray[index] = [floatObject floatValue];
            index++;
        }
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineDash(ctx,0,floatArray,[c count]);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);
    
    
}



+(void)drawVerticalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)vlProperties gridHeight:(float)gridHeight tileWidth:(float)tileWidth gridWidth:(float)gridWidth scalingX:(float)scalingX  xIsString:(BOOL)xIsString bottomMargin:(float)bottomMargin leftMargin:(float)leftMargin topMargin:(float)topMargin
{
    
    float _tileWidth=tileWidth;
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    float _scalingX=scalingX;
    
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
    
    //Find if it needs to be dotted line
    NSString *dotted=@"";
    if([vlProperties valueForKey:@"dotted"]) 
        dotted=[vlProperties valueForKey:@"dotted"];
    

    
    
    CGContextSaveGState(ctx);

    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    
    int numVertLines=_gridWidth/_scalingX;
    
    if(xIsString)
    {
//        if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]]) numVertLines=[_xValElements count];
//        else numVertLines=[[_xValElements objectAtIndex:0] count];
//        
        
        for (int i=1; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i * _scalingX + leftMargin,topMargin);
            CGContextAddLineToPoint(ctx, i * _scalingX + leftMargin,_gridHeight+topMargin);
        }
        
    }
    else
    {
        for (int i=1; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i*_tileWidth + leftMargin,topMargin);
            CGContextAddLineToPoint(ctx, i*_tileWidth + leftMargin,_gridHeight+topMargin);
        }
    }
    

    if([dotted isEqualToString:@""])
    {    
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    else 
    {

        NSArray *c=[dotted componentsSeparatedByString:@","];
        
        NSEnumerator *enumerator;
        float * floatArray;
        id floatObject;
        int index=0;
        
        floatArray = (float *) malloc(sizeof(float) * [c count]);
        enumerator = [c objectEnumerator];
        while(floatObject = [enumerator nextObject])
        {
            floatArray[index] = [floatObject floatValue];
            index++;
        }
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineDash(ctx,0,floatArray,[c count]);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);

    
}


+(void)drawBgPattern:(CGContextRef)ctx color:(MIMColorClass *)mbackgroundColor gridWidth:(float)gridWidth gridHeight:(float)gridHeight leftMargin:(float)leftMargin topMargin:(float)topMargin
{
    
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    
    //Check if User has given any color for Background
    if(mbackgroundColor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:mbackgroundColor.red green:mbackgroundColor.green blue:mbackgroundColor.blue alpha:mbackgroundColor.alpha].CGColor);
        CGContextFillRect(ctx, CGRectMake(leftMargin, topMargin, _gridWidth, _gridHeight));
        CGContextRestoreGState(ctx);
        return;
        
        
    }
    
//    if([delegate respondsToSelector:@selector(backgroundViewForLineChart:)])
//    {
//        
//        
//        return;
//    }
//    
//    
    
    //Else Draw the background with the gray Gradient
    CGContextSaveGState(ctx);
    CGFloat BGLocations[3] = { 0.0,0.5 ,1.0 };
    CGFloat BgComponents[12] = { 0.96, 0.96, 0.96 , 1.0,  // Start color
        0.99, 0.99, 0.99 , 1.0,  // Start color
        1.0, 1.0, 1.0 , 1.0 }; // Mid color and End color
    
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    CGContextAddRect(ctx, CGRectMake(leftMargin, topMargin, _gridWidth, _gridHeight+topMargin));
    if(!CGContextIsPathEmpty(ctx))
        CGContextClip(ctx);
    
    CGContextDrawLinearGradient(ctx, bgRadialGradient, CGPointMake(0, topMargin), CGPointMake(0, _gridHeight+topMargin), 0 );
    
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    CGContextRestoreGState(ctx);
    
}

+(void)createGloss:(CGContextRef)context  OnRect:(CGRect)rect withStyle:(int)glossStyle
{
    float red,green,blue,alpha,Dred,Dgreen,Dblue,DAlpha;

    
    if(glossStyle!=6)
    {
        Dred=1.0;
        Dgreen=1.0;
        Dblue=1.0;
        DAlpha=0.5;
        
        
        red=1.0;
        green=1.0;
        blue=1.0;
        alpha=0.05;
        
        switch (glossStyle) 
        {
            case 1:
            default:
            {
                CGContextSaveGState(context);
                
                
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(rect));
                CGPathAddCurveToPoint(path, NULL, 0, CGRectGetHeight(rect),CGRectGetWidth(rect)/2 ,CGRectGetHeight(rect)/5, CGRectGetWidth(rect),  CGRectGetHeight(rect)/10);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
                
            case 2:
            {
                CGContextSaveGState(context);
                
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(rect)*0.6);
                
                CGPathAddQuadCurveToPoint(path, NULL, CGRectGetWidth(rect)*0.5, CGRectGetHeight(rect)*0.55, CGRectGetWidth(rect), CGRectGetHeight(rect)*0.4);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
        }
        
        
        
        //DRaw the gloss gradient
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { red, green, blue, alpha,  // Start color
            Dred, Dgreen, Dblue, DAlpha }; // Mid color and End color
        
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        CGPoint start = CGPointMake(CGRectGetWidth(rect),CGRectGetHeight(rect)*0.7); 
        CGPoint end = CGPointMake(CGRectGetWidth(rect), -5);
        CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
        
        
        CGContextRestoreGState(context);
        
        
    }
    
}

+(BOOL)findIfItIsALongGraph:(int)tileWidth TotalItemsOnXAxis:(int)totalItemsOnX GridWidth:(float)gridWidth
{
    //if tileWidth*totalItems on xAxis exceed gridWidth
    BOOL _isLongGraph=FALSE;
    if(tileWidth*totalItemsOnX + 20 > gridWidth)_isLongGraph=TRUE;
    return _isLongGraph;
    

}

+(float)returnLongGraphContentWidth:(int)tileWidth TotalItemsOnXAxis:(int)totalItemsOnX
{
    return tileWidth*totalItemsOnX + 20.0;
}


+(int)countXValuesInArray:(NSMutableArray *)xValElements
{

    int count=0;
    if([[xValElements objectAtIndex:0] isKindOfClass:[NSString class]]||[[xValElements objectAtIndex:0] isKindOfClass:[NSNumber class]])
    {
        count=[xValElements count];
    }
    else
    {
        count=[[xValElements objectAtIndex:0]count];
    }
    
    //if(count<=3) count=3;
    
    return count;

}
//CALCULATIONS FOR GRIDWIDTH/HEIGHT , TILEWIDTH/HEIGHT
+(float)CalculateGridWidth:(float)gwidth leftMargin:(float)lMargin rightMargin:(float)rMargin yAxisSpace:(float)ySpace
{

    float _gridWidth=gwidth;
    _gridWidth-=lMargin;
    _gridWidth-=rMargin;
    _gridWidth-=ySpace;
    return _gridWidth;

}


+(float)CalculateGridHeight:(float)gheight bottomMargin:(float)bMargin topMargin:(float)tMargin xAxisSpace:(float)xSpace
{
  
    float _gridHeight=gheight;

    _gridHeight-=bMargin;
    _gridHeight-=tMargin;
    _gridHeight-=xSpace;
    return _gridHeight;
    
}


+(float)FindTileWidth:(NSMutableDictionary *)vlProperties GridWidth:(float)gridWidth xItemsCount:(int)xCount
{

    
    float _tileWidth=0;
    
    //Check if Tilewidth is defined by user
    if([vlProperties objectForKey:@"gap"])
    {
        _tileWidth=[[vlProperties valueForKey:@"gap"] floatValue];
        
        if(_tileWidth <20)
            NSLog(@"WARNING: Minimum gap between vertical lines is 20. Otherwise X-Axis labels may appear overlapping.");
    }
    
    if(_tileWidth==0)
    {
        _tileWidth=gridWidth/xCount;
        
        if (_tileWidth<DEFAULT_TILEWIDTH)
            _tileWidth=DEFAULT_TILEWIDTH;
        
    }

    return _tileWidth;
    
    
    
    
}

+(float)FindTileHeight:(NSMutableDictionary *)hlProperties GridHeight:(float)gridHeight
{
    
    //Check if Tilewidth is defined by user
    float _tileHeight=0;
    
    if([[hlProperties allKeys] containsObject:@"gap"])
    {
        _tileHeight=[[hlProperties valueForKey:@"gap"] floatValue];
        if(_tileHeight < 20)
        {
        
            NSLog(@"WARNING: Minimum gap between horizontal lines is 20.");
            NSLog(@"CHECK: \n-(NSDictionary*)horizontalLinesProperties:(id)graph{ \n return [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:25.0] forKey:@\"gap\"];\n} \n Note: 25.0 is the plotting gap quantity,it should be replaced by number of your choice.But it should be <=20.0 \n");
            
        }
    }
    
    if(_tileHeight==0)
    {
        _tileHeight=DEFAULT_TILEHEIGHT;
       
    }

    
    //WARNING
//    if(_tileHeight+5 >= gridHeight)
//    {
//        NSLog(@"ERROR:Frame too small to draw. Increase your graph's frame height.");
//    }
    
    
    return _tileHeight;
    
    
    
}


+(float)fixTileHeight:(float)gridHeight
{
    
    float _gridHeight=gridHeight;
    
    float newTileHeight=_gridHeight/3;
    //Because screen should have atleast 3 horizontal lines parallel to x axis
    
    if(newTileHeight<20)
    {
        NSLog(@"WARNING:Increase your graph's frame height.Your Y-Axis Labels may appear overlapping each other.");
    }
    
    return newTileHeight;

}

+(float)findScaleForYTile:(NSMutableArray *)yValElements gridHeight:(float)gridHeight tileHeight:(float)tileHeight :(int)countHLines Min:(float)minOfY Max:(float)maxOfY
{
    // This piece of code is for range graph where y values are strings
    float _scalingY;
    if(minOfY==0 && maxOfY==0)
    {
        //Find how many elements are there in yValElement
        //Find count*tileHeight should be < gridHeight, otherwise _scalingY=gridHeight/count.
        //If _scalingY < 20, WARNING: Increase gridHeight
        int countY=[yValElements count]+1;
        if(countY * tileHeight > gridHeight)
            _scalingY=gridHeight/countY;
        else
            _scalingY=tileHeight;
        
        return _scalingY;
    }
    
    //NSLog(@"_yValElements=%@",_yValElements);
    float _gridHeight=gridHeight;

    float _tileHeight=tileHeight;
    int numOfHLines=countHLines;
    
    
    int HorLines=_gridHeight/_tileHeight;
    numOfHLines=HorLines;
    

    float ppt;//pixel per tile.
    int divider=HorLines;
    
    //We need to have min 3 Hor Lines on y-Axis
    if(HorLines<=3)divider=3;
    else divider=HorLines-1;
    
    int countDigits=[[NSString stringWithFormat:@"%.0f",minOfY] length];
    
    BOOL minIsNegative=FALSE;
    if(minOfY<0){
     
        minIsNegative=TRUE;
        countDigits=countDigits-1;
    }
    
    //Normalize minOfY
    
    if(countDigits==1)countDigits=2;
    
    //New Pixel per tile swould be
    minOfY=minOfY/pow(10, countDigits-1);
    minOfY=floorf(minOfY);
    minOfY=minOfY*pow(10, countDigits-1);
    
    
    
    
    if(maxOfY==minOfY) ppt=(maxOfY)/divider;
    else ppt=(maxOfY-minOfY)/divider;
    
    
    //NSLog(@"pixelPerTile=%f,maxOfY=%f",maxOfY,pixelPerTile);
    
    countDigits=[[NSString stringWithFormat:@"%.0f",ppt] length];
    
    //New Pixel per tile swould be
    ppt=ppt/pow(10, countDigits-1);
    ppt=ceilf(ppt);
    ppt=ppt*pow(10, countDigits-1);
    
   // pixelsPerTile=ppt;
    
    _scalingY=_tileHeight/ppt;
    
    return _scalingY;
    
    
    
    
}



+(float)findGlobalMinimum:(NSMutableArray *)yValElements
{
    NSMutableArray *_yValElements=[NSMutableArray arrayWithArray:yValElements];

    
    float minOfY;
    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        
        minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
        
        
    }
    else if([[_yValElements objectAtIndex:0] isKindOfClass:[NSNumber class]])
    {
        
        minOfY=[MIM_MathClass getMinFloatValue:_yValElements];
        
        
    }
    else
    {
        
        minOfY=[MIM_MathClass getMinFloatValue:[_yValElements objectAtIndex:0]];
        for (int i=1; i<[_yValElements count]; i++)
        {
            float minOfY1=[MIM_MathClass getMinFloatValue:[_yValElements objectAtIndex:i]];
            if(minOfY1<minOfY)
                minOfY=minOfY1;
        }
        
    }
    
    return minOfY;
    
    
    
    
}
+(float)findGlobalMaximum:(NSMutableArray *)yValElements
{
    NSMutableArray *_yValElements=[NSMutableArray arrayWithArray:yValElements];

    
    float maxOfY;

    if([[_yValElements objectAtIndex:0] isKindOfClass:[NSString class]])
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];

    }
    else if([[_yValElements objectAtIndex:0] isKindOfClass:[NSNumber class]])
    {
        maxOfY=[MIM_MathClass getMaxFloatValue:_yValElements];
        
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
        
    }
    
    return maxOfY;
    
}



+(float)findMinimumOnY:(float)minOfY
{
    int countDigits=[[NSString stringWithFormat:@"%.0f",fabs(minOfY)] length];
    if(countDigits==1)countDigits=2;
    
  
    
    
    float minimumOnY=minOfY/pow(10, countDigits-1);
    minimumOnY=floorf(minimumOnY);
    minimumOnY=minimumOnY*pow(10, countDigits-1);

    
    return minimumOnY; //This is the number with which labelling on y -Axis starts
}



+(float)findMinimumOnYForHandlingNegative:(float)minOfY withPPT:(float)ppt
{
    //scalingy * i < minof y< scalingy * i+1
    int i=(int)(-minOfY/ppt);
    i+=1;
    i=-i;
    
    float minimumLabelOnY=ppt*i;
    return minimumLabelOnY;
        
}

//Scaling on X axis exists only for string values. Right now you can give numbers on x-axis, if numbers then give in form on string.
//No scaling will happen on numeric value
+(float)findScaleForXTile:(NSMutableArray *)xValElements XValuesAreString:(BOOL)xIsString LongGraph:(BOOL)isLongGraph TileWidth:(float)tileWidth TileWidthDefinedByUser:(BOOL)tileWidthDefinedByUser
{
    
    

    float _scalingX;
    
    
    if(xIsString)
    {
        
        _scalingX=tileWidth;
        
        //If tileWidth is not defined by user
        if(isLongGraph)
            if(!tileWidthDefinedByUser)
            {
                NSLog(@"Since graph is too long,plotting gap auto resizes itself to default size px.");
                NSLog(@"WARNING: Plotting gap on x-axis is auto-calculated. If items are plotted very close/distant to each other in graph,USE: \n-(NSDictionary*)verticalLinesProperties:(id)graph{ \n return [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:25.0] forKey:@\"gap\"];\n} \nNote: 25.0 is the plotting gap quantity,it should be replaced by number of your choice.\n");
                _scalingX=DEFAULT_TILEWIDTH;
            }
        

    }
    
    
    
//    NSMutableArray *_xValElements=[NSMutableArray arrayWithArray:xValElements];
//
//    
//    int count=0;
//    if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]])
//    {
//        count=[_xValElements count];
//        
//    }
//    else
//    {
//        count=[[_xValElements objectAtIndex:0] count];
//    }
//    
//    
//
//    
//    int VerLines=_gridWidth/_tileWidth;
//    float maxX=[MIM_MathClass getMaxFloatValue:_xValElements];
//    float minX=[MIM_MathClass getMinFloatValue:_xValElements];
//    
//    float pixelPerTile=(maxX-minX)/(VerLines-1);
//    
//    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
//    
//    //New Pixel per tile swould be
//    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
//    pixelPerTile=ceilf(pixelPerTile);
//    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
//    
//    
//    _scalingX=_tileWidth/pixelPerTile;
//    
//    
    return _scalingX;
    
}



@end
