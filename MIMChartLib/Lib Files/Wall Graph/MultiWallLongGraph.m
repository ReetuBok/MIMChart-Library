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
@synthesize xOffset;
@synthesize minimumOnY;

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

@synthesize aPropertiesArray;
@synthesize anchorTypeArray;

@synthesize rightMargin,topMargin,leftMargin,bottomMargin;
@synthesize barOffset;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        barOffset=0;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    NSLog(@"rect=%@",NSStringFromCGRect(rect));
    NSLog(@"rect=%f",rect.origin.x);
    NSLog(@"rect=%f",rect.origin.y);
    
    
    if([xValElements count]==0)
        return;
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);

    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
//
    
    
    //Clear the background
    //Set Background Clear.    
    CGContextSaveGState(context);
    CGRect aR=CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor);
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
            CGGradientRef g=(CGGradientRef )[wallGradientArray objectAtIndex:i];
            CGContextDrawLinearGradient (context, g, CGPointMake(0, maxOfY * scalingY), CGPointMake(0, 0), 1);
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
        
        
        
        
        

        
        
    }
  
    [self _drawAnchorPoints];
 
}



-(void)_drawAnchorPoints
{
    //Remove Any if there from previous draw
    for (UIView *view in self.subviews)
    if([view isKindOfClass:[Anchor class]])
    {
        [view removeFromSuperview];
    }
    
    float offsetXLabelOnLongGraph=xOffset;
    
    
    for (int index=0; index<[wallBezierPath count]; index++)
    {
        NSMutableDictionary *aProperties;
        if ([aPropertiesArray count]>index)
            aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
        else aProperties=[[NSMutableDictionary alloc] init];
        
        
        
        if([aProperties valueForKey:@"hide"])
            if([[aProperties valueForKey:@"hide"] boolValue])
                return;
        
        
        int wIndex=[[orderArray objectAtIndex:index] intValue];
        
        
        MIMColorClass *c=[edgeColorArray objectAtIndex:wIndex];
        float red=c.red;
        float green=c.green;
        float blue=c.blue;
        float alpha=c.alpha;
        
        
        
        if(![aProperties valueForKey:@"fillColor"])
            [aProperties setValue:[NSString stringWithFormat:@"%f,%f,%f,%f",red,green,blue,alpha] forKey:@"fillColor"];
        
        if([anchorTypeArray count] !=[yValElements count])
            NSLog(@"WARNING:Not enough values in anchorTypeArray");
        
        if ([anchorTypeArray count]>index)
            [aProperties setValue:[anchorTypeArray objectAtIndex:index] forKey:@"style"];
        
        if([[yValElements objectAtIndex:index] isKindOfClass:[NSString class]]||[[yValElements objectAtIndex:index] isKindOfClass:[NSNumber class]])
        {
            for (int l=0; l<[yValElements count]; l++)
            {
                float valueY=[[yValElements objectAtIndex:l] floatValue]-minimumOnY;
                float valueX;
                if(xIsString)
                    valueX=(float)l;
                else
                    valueX=[[yValElements objectAtIndex:l] floatValue];
                
                //NSLog(@"_scalingX=%f,%f",_scalingX,_scalingY);
                
                float mX=valueX*scalingX;//+ leftMargin+yAxisWidth;
                if(barOffset!=0)
                {
                    mX+=barOffset*(l+1);
                    mX+=(scalingX/2);
                }
                float mY=valueY*scalingY;
                mY=gridHeight-mY;
                
                
                mX+=offsetXLabelOnLongGraph;
                
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
                NSArray *yArray_=[yValElements objectAtIndex:k];
                for (int l=0; l<[yArray_ count]; l++)
                {
                    float valueY=[[yArray_ objectAtIndex:l] floatValue]-minimumOnY;
                    float valueX;
                    if(xIsString)
                        valueX=(float)l;
                    else
                        valueX=[[yValElements objectAtIndex:l] floatValue];
                    
                    
                    
                    
                    float mX=valueX*scalingX;//+ leftMargin+yAxisWidth;
                    if(barOffset!=0)
                    {
                        mX+=barOffset*(l+1);
                        mX+=(scalingX/2);
                    }
                    
                    float mY=valueY*scalingY;
                    mY=gridHeight-mY;
                    
                    
                    mX+=offsetXLabelOnLongGraph;
                    
                    
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

-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
    
    
}



@end
