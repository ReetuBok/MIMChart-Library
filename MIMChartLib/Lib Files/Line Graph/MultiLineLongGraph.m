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
@synthesize minimumOnY;
@synthesize barOffset;
@synthesize lineColorArray;
@synthesize lineBezierPath;
@synthesize aPropertiesArray;
@synthesize anchorTypeArray;
@synthesize xOffset;

@synthesize xValElements;
@synthesize yValElements;
@synthesize bottomMargin,leftMargin,xAxisHeight;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        barOffset=0;
        //barOffset has something to do with when bars are created with overlapping line graph like in predictive graph.
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
        
        //[self _drawAnchorPointsAtIndex:i];
        
        
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

    
    for (int index=0; index<[lineBezierPath count]; index++)
    {
        NSMutableDictionary *aProperties;
        if ([aPropertiesArray count]>index)
            aProperties=[[NSMutableDictionary alloc] initWithDictionary:[aPropertiesArray objectAtIndex:index]];
        else aProperties=[[NSMutableDictionary alloc] init];
        
        
        
        if([aProperties valueForKey:@"hide"])
            if([[aProperties valueForKey:@"hide"] boolValue])
                return;
        
        
        
        
        
        MIMColorClass *c=[lineColorArray objectAtIndex:index];
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


#pragma mark - Anchor Delegate Method
-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
}


@end
