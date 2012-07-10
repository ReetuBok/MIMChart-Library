//
//  GaugeGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GaugeGraph.h"
@interface GaugeGraph()
{
    float _gridWidth;
    float _gridHeight;
}
@end


@implementation GaugeGraph
@synthesize backgroundcolor;
@synthesize gaugeValueArray; // range (0-30) red , range(30-70) blue etc
@synthesize currentValue;
@synthesize properties;//display numbers of seperators, seperator color, main circle color.

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
-(void)CalculateGridDimensions
{
    
    _gridWidth=self.frame.size.width;
    _gridHeight=self.frame.size.height;  
    
}   


-(void)drawGaugeGraph
{
    [self CalculateGridDimensions];
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect
{
    srand(time(NULL));
    [MIMColor InitColors];
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    float outerRadius=_gridWidth/2 - 15;

    CGPoint center=CGPointMake(_gridWidth/2 , _gridHeight/2);

    for (int i=0; i<[gaugeValueArray count]; i++) 
    {
        NSDictionary *dict=[gaugeValueArray objectAtIndex:i];
        float startAngle;
        float endAngle;
        if([dict valueForKey:@"range"])
        {
            
            NSArray *c=[[dict valueForKey:@"range"] componentsSeparatedByString:@","];
            startAngle=(100-[[c objectAtIndex:0] floatValue]) * 3.14 /100; 
            endAngle=(100-[[c objectAtIndex:1] floatValue]) * 3.14 /100;
        }
       
        
        CGContextAddArc(context, center.x,center.y, outerRadius,startAngle,endAngle, 1);
     
        UIColor *color;
        
        if([dict valueForKey:@"color"])
        {
            MIMColorClass *c=[MIMColorClass colorWithComponent:[dict valueForKey:@"color"]];
            color=[[UIColor alloc]initWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];    
        }
        else
        {
            NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+rand())%totalColors];    
            float red=[[colorDic valueForKey:@"red"] floatValue];
            float green=[[colorDic valueForKey:@"green"] floatValue];
            float blue=[[colorDic valueForKey:@"blue"] floatValue];
            color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];  
        }
        
        
        CGContextSetStrokeColorWithColor(context, color.CGColor);    
        CGContextSetLineWidth(context, 10);
        CGContextStrokePath(context);
        

        

    }

    UIColor *fillColor;
    if([properties valueForKey:@"gaugecolor"])
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:[properties valueForKey:@"gaugecolor"]];
        fillColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    }
    else
        fillColor=[UIColor colorWithRed:0.16 green:0.227 blue:0.329 alpha:1.0];

    
    //Create the main Circle
    CGRect r=CGRectMake(35, 35, _gridWidth-70, _gridHeight-70);
    CGContextSetLineWidth(context, 15);
    CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
    CGContextAddEllipseInRect(context, r);  
    CGContextStrokePath(context);
    
    //pointer center
    r=CGRectMake(center.x-5, center.y-5, 10,10);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    CGContextAddEllipseInRect(context, r);  
    CGContextFillPath(context);
    
    
    UIColor *pointerColor;
    if([properties valueForKey:@"pointercolor"])
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:[properties valueForKey:@"gaugecolor"]];
        pointerColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    }
    else
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:@"158,33,27"];
        pointerColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    }
    
    
    
    int radius=_gridWidth/2 -15;
    //Create the pointer;
    float newX=radius* cosf(3.14 * (100-currentValue) /100);
    float newY=radius* sinf(3.14 *  (100-currentValue) /100);
    newX+=center.x;
    newY+=center.y;
    
    CGContextSetLineWidth(context, 3);
    CGContextSetStrokeColorWithColor(context, pointerColor.CGColor);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context,newX,newY);
    CGContextStrokePath(context);
    
    [self drawLinesOnGauge:context];
    
    
}


-(void)drawBgPattern:(CGContextRef)ctx
{
    
    //Check if User has given any color for Background
    if(self.backgroundcolor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:backgroundcolor.red green:backgroundcolor.green blue:backgroundcolor.blue alpha:backgroundcolor.alpha].CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, _gridWidth, _gridHeight));
        CGContextRestoreGState(ctx);
        return;
        
    }
}

-(void)drawLinesOnGauge:(CGContextRef)context
{
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    
    CGPoint center=CGPointMake(_gridWidth/2 , _gridHeight/2);
    UIColor *sColor=[UIColor blackColor];
    
    for (int i=0; i<11; i++) 
    {
        float angle =10*i;
        

        
        int Oradius=_gridWidth/2 -5;
        int Iradius=_gridWidth/2 -20;
        
        //Create the pointer;
        float sX=Oradius* cosf(3.14 * angle /100);
        float sY=Oradius* sinf(3.14 *  angle /100);
        sX+=center.x;
        sY+=center.y;
        
        
        float eX=Iradius* cosf(3.14 * angle/100);
        float eY=Iradius* sinf(3.14 *  angle/100);
        eX+=center.x;
        eY+=center.y;
        
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, sColor.CGColor);
        CGContextMoveToPoint(context, sX, sY);
        CGContextAddLineToPoint(context,eX,eY);
        CGContextStrokePath(context);
    }
    
    
    
    
    for (int i=0; i<10; i++) 
    {
        float angle =10*i + 5;
        
        
        
        int Oradius=_gridWidth/2 -8;
        int Iradius=_gridWidth/2 -20;
        
        //Create the pointer;
        float sX=Oradius* cosf(3.14 * angle /100);
        float sY=Oradius* sinf(3.14 *  angle /100);
        sX+=center.x;
        sY+=center.y;
        
        
        float eX=Iradius* cosf(3.14 * angle/100);
        float eY=Iradius* sinf(3.14 *  angle/100);
        eX+=center.x;
        eY+=center.y;
        
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, sColor.CGColor);
        CGContextMoveToPoint(context, sX, sY);
        CGContextAddLineToPoint(context,eX,eY);
        CGContextStrokePath(context);
    }

}

@end
