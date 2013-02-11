//
//  MIMLongRangeChart.m
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import "MIMLongRangeGraph.h"

@implementation MIMLongRangeGraph

@synthesize gridHeight;
@synthesize scalingX;
@synthesize scalingY;
@synthesize xIsString;
@synthesize rangeLineThickness;

@synthesize lineColorArray;
@synthesize lineBezierPath;
@synthesize aPropertiesArray;
@synthesize xValElements;
@synthesize yValElements;
@synthesize bottomMargin,leftMargin,xAxisHeight;

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
        
        

        MIMColorClass *c=[lineColorArray objectAtIndex:0];
        if([lineColorArray count]==[lineBezierPath count])
        {
            c=[lineColorArray objectAtIndex:i];
        }
        
        
        UIColor *_color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
        [_color setStroke];
        UIBezierPath *myP=[lineBezierPath objectAtIndex:i];
        [myP setLineWidth:rangeLineThickness];
        [myP strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        

        
        
    }
    
    
    
}

@end
