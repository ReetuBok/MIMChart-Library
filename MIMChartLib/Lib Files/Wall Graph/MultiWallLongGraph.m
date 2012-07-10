//
//  MultiWallLongGraphMultiWallLongGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiWallLongGraph.h"

@implementation MultiWallLongGraph


@synthesize gridHeight;  
@synthesize scalingX;
@synthesize scalingY;
@synthesize xIsString;
@synthesize isGradient;

@synthesize wallBezierPath;
@synthesize wallEdgeBezierPath;


@synthesize xValElements;
@synthesize yValElements;

@synthesize wallColorArray;
@synthesize edgeColorArray;
@synthesize orderArray;
@synthesize wallGradientArray;
@synthesize maxValuesArray;
@synthesize METERLINEHEIGHT;


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

    
    if([xValElements count]==0)
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
    

    
    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
  
    
    

    for (int i=0; i<[wallBezierPath count]; i++) 
    {
        
        //Fill the wall
        MIMColorClass *c=[wallColorArray objectAtIndex:i];
        
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:0.3]; 
        [_color setFill];  
        
        
        UIBezierPath *myP=[wallBezierPath objectAtIndex:i];

        if(isGradient)
        {
            int oIndex=[[orderArray objectAtIndex:i] intValue];
            float maxOfY=[[maxValuesArray objectAtIndex:oIndex] floatValue];
            
            
            CGContextSaveGState(context);
            [myP closePath];
            [myP addClip];
            CGGradientRef g=(__bridge CGGradientRef )[wallGradientArray objectAtIndex:i];
            CGContextDrawLinearGradient (context, g, CGPointMake(0, METERLINEHEIGHT), CGPointMake(0, maxOfY * scalingY + METERLINEHEIGHT), 0);
            CGContextRestoreGState(context);
        }
        else
        {
            [myP fillWithBlendMode:kCGBlendModeNormal alpha:1.0];   
        }
        
        

        
        MIMColorClass *e=[edgeColorArray objectAtIndex:i];

        
        //Stroke the edges
        _color=[[UIColor alloc]initWithRed:e.red green:e.green blue:e.blue alpha:e.alpha]; 
        [_color setStroke];  
        
        myP=[wallEdgeBezierPath objectAtIndex:i];
        [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        
        
        
        
        
        //[self _drawAnchorPointsWithColorRed:r Blue:b Green:g Alpha:a AtIndex:i];
        
        
    }
    [self _drawAnchorPoints];
    
    
}



-(void)_drawAnchorPoints
{
    
    
}

-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
    
    
}



@end
