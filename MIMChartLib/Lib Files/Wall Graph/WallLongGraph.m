//
//  WallLongGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WallLongGraph.h"
@interface WallLongGraph()


-(void)_drawAnchorPointsWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha;
-(void)_displayXAxisWithStyle:(int)xstyle WithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha;
-(void)drawVerticalBgLines:(CGContextRef)ctx;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;
-(void)drawWallEdge:(CGContextRef)ctx WithColors:(MIMColorClass *)dColor;

@end

@implementation WallLongGraph

@synthesize gridWidth;
@synthesize gridHeight;  
@synthesize tileWidth;
@synthesize tileHeight;
@synthesize scalingX;
@synthesize scalingY;
@synthesize xIsString;
@synthesize isShadow;
@synthesize patternStyle;


@synthesize colorWallChart;
@synthesize widthOfWall;
@synthesize xElements,yElements;
@synthesize verticalLinesVisible;
@synthesize horizontalLinesVisible;
@synthesize widthOfLine;
@synthesize colorOfLine;



@synthesize xTitleStyle;
@synthesize nonInteractiveAnchorPoints;
@synthesize anchorType;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    float r,g,b,a;
    
    if([xElements count]==0)
        return;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    
    
    //Clear the background
    //Set Background Clear.    
    CGContextSaveGState(context);
    float k=1.0;
    CGRect aR=self.frame;
    aR.origin.x=0;
    aR.origin.y=0;
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
    CGContextAddRect(context, aR);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    
    
    
    [self drawVerticalBgLines:context];
    [self drawHorizontalBgLines:context];
    
    

    
    
    //Draw the entire wall now.
    
    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    
    
    UIColor *_color=[[UIColor alloc]initWithRed:colorWallChart.red green:colorWallChart.green blue:colorWallChart.blue alpha:0.6];     
    
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context,0,0);
    

    
    
    if(xIsString)
    {
        
        
        for (int i=0; i<[xElements count]; i++)
            CGContextAddLineToPoint(context,i*scalingX , [[yElements objectAtIndex:i] floatValue]*scalingY);
        
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(context,([xElements count]-1)*scalingX , 0);
        
        
    }
    else
    {
        for (int i=0; i<[xElements count]; i++)
            CGContextAddLineToPoint(context,[[xElements objectAtIndex:i] intValue]*scalingX , [[yElements objectAtIndex:i] floatValue]*scalingY);
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(context,[[xElements objectAtIndex:([xElements count]-1)] intValue]*scalingX , 0);
    }
    
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, _color.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    [self drawWallEdge:context WithColors:colorWallChart];

    
    
    r=colorWallChart.red;
    g=colorWallChart.green;
    b=colorWallChart.blue;
    a=colorWallChart.alpha;
    
    //[self _drawAnchorPointsWithColorRed:r Blue:b Green:g Alpha:a];
    
}


-(void)drawWallEdge:(CGContextRef)ctx WithColors:(MIMColorClass *)dColor
{
    
    float dred=dColor.red;
    float dgreen=dColor.green;
    float dblue=dColor.blue;
    float dAlpha=dColor.alpha;
    
    
    
    CGContextSetLineWidth(ctx, widthOfWall);
    
    if(isShadow)
        CGContextSetShadowWithColor(ctx, CGSizeMake(1.0,1.0), 3.0, [UIColor blackColor].CGColor);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:dred green:dgreen blue:dblue alpha:dAlpha].CGColor);
    
    if(xIsString)
    {
        
        CGContextMoveToPoint(ctx, 0, [[yElements objectAtIndex:0] floatValue]*scalingY);
        int k=1;
        for (int i=1; i<[xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,k*scalingX , [[yElements objectAtIndex:i] floatValue]*scalingY);
            k++;
        }
     
        
        
        
    }
    else
    {
        CGContextMoveToPoint(ctx, [[xElements objectAtIndex:0] intValue]*scalingX, [[yElements objectAtIndex:0] floatValue]*scalingY);
        
        for (int i=0; i<[xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,[[xElements objectAtIndex:i] intValue]*scalingX , [[yElements objectAtIndex:i] floatValue]*scalingY);
        }
      
        
    }
    
    
    
    CGContextStrokePath(ctx);
}


-(void)drawVerticalBgLines:(CGContextRef)ctx
{
    if(!verticalLinesVisible)
        return;
    
    
    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:colorOfLine.red green:colorOfLine.green blue:colorOfLine.blue alpha:colorOfLine.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    
    int numVertLines=gridWidth/tileWidth;
    
    if(xIsString)
    {
        numVertLines=[xElements count];
        
        for (int i=0; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i * scalingX,0);
            CGContextAddLineToPoint(ctx, i * scalingX,gridHeight);
        }
        
    }
    else
    {
        for (int i=0; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i*tileWidth,0);
            CGContextAddLineToPoint(ctx, i*tileWidth,gridHeight);
        }
    }
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    
}

-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    if(!horizontalLinesVisible)
        return;
    
    
    
    
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:colorOfLine.red green:colorOfLine.green blue:colorOfLine.blue alpha:colorOfLine.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    int numHorzLines=gridHeight/tileHeight;
    for (int i=0; i<=numHorzLines; i++) {
        
        CGContextMoveToPoint(ctx, 0,i*tileHeight);
        CGContextAddLineToPoint(ctx,gridWidth , i*tileHeight);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    //    if (xTitleStyle==0)
    //        xTitleStyle=X_TITLES_STYLE1;
    //    
    //    [self _displayXAxisWithStyle:xTitleStyle WithColorRed:colorOfLine.red Blue:colorOfLine.blue Green:colorOfLine.green Alpha:colorOfLine.alpha];
    
}


-(void)_drawAnchorPointsWithColorRed:(float)red Blue:(float)blue Green:(float)green Alpha:(float)alpha
{
    //Remove Any if there
    for (UIView *view in self.subviews) 
        if([view isKindOfClass:[Anchor class]])
        {
            [view removeFromSuperview];
        }
    
    
    for (int l=0; l<[yElements count]; l++) 
    {   
        float valueY=[[yElements objectAtIndex:l] floatValue];
        float valueX;
        if(xIsString)
            valueX=(float)l;
        else
            valueX=[[xElements objectAtIndex:l] floatValue];
        
        float mX=valueX*scalingX;
        float mY=valueY*scalingY;
        mY=gridHeight-mY;
        
        
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


@end
