//
//  MultiLineLongGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiLineLongGraph.h"
@interface MultiLineLongGraph()
-(void)_drawAnchorPointsAtIndex:(int)index;
@end

@implementation MultiLineLongGraph


@synthesize gridHeight;  
@synthesize scalingX;
@synthesize scalingY;
@synthesize xIsString;

@synthesize lineColorArray;
@synthesize lineBezierPath;
@synthesize aPropertiesArray;
@synthesize xValElements;
@synthesize yValElements;
@synthesize bottomMargin,leftMargin;

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
    

    for (int i=0; i<[lineBezierPath count]; i++) 
    {
        
        
        MIMColorClass *c=[lineColorArray objectAtIndex:i];
        
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha]; 
        [_color setStroke];  
        UIBezierPath *myP=[lineBezierPath objectAtIndex:i];
        [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        
        [self _drawAnchorPointsAtIndex:i];
        
        
    }
    
    
    
}


-(void)_drawAnchorPointsAtIndex:(int)index
{
    return;
    
    
    if ([aPropertiesArray count]==0)return ;
    
    
    NSMutableDictionary *aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
    
    
    //There will be only 1 anchor, which user can move around
    //because long graph doesnt have enough space to accomodate most of the time, hence by default it will be hidden
    //cursorAnchor
    
    if([aProperties valueForKey:@"hide"])
        if([[aProperties valueForKey:@"hide"] boolValue])
            return;
    
    
    MIMColorClass *c=[lineColorArray objectAtIndex:index];
    float red=c.red;
    float green=c.green;
    float blue=c.blue;
    float alpha=c.alpha;
    
    
    
    //Remove Any if there
    for (UIView *view in self.subviews) 
    if([view isKindOfClass:[Anchor class]])
    {
        [view removeFromSuperview];
    }
    
    if(![aProperties valueForKey:@"fillColor"])
        [aProperties setValue:[NSString stringWithFormat:@"%.0f,%.0f,%.0f,%.0f",red,green,blue,alpha] forKey:@"fillColor"];
    
    for (int l=0; l<[yValElements count]; l++) 
    {   
        float valueY=[[yValElements objectAtIndex:l] floatValue];
        float valueX;
        if(xIsString)
            valueX=(float)l;
        else
            valueX=[[xValElements objectAtIndex:l] floatValue];
        
        float mX=valueX*scalingX;
        float mY=valueY*scalingY;
        mY=gridHeight-mY;
        
        Anchor *anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        anchor.center=CGPointMake(mX,mY);
        anchor.properties=aProperties;
        anchor.anchorTag=l;
        //anchor.delegate=self;
        [self addSubview:anchor];
        [anchor drawAnchor];
        
    }
    
}


#pragma mark - Anchor Delegate Method
-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
}


@end
