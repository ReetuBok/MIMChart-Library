//
//  BiTransPieChart.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BiTransPieChart.h"



@interface BiTransPieChart()
-(void)initAndWarnings;
-(void)findCenter;
@end

@implementation BiTransPieChart

@synthesize innerRadius;
@synthesize outerRadius;
@synthesize borderWidth;
@synthesize mcolor;
@synthesize glossEffect;
@synthesize centerIcon;
@synthesize percentValue;
@synthesize delegate;
@synthesize userTouchAllowed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Draw the Transparent part
    UIColor *color=[UIColor colorWithRed:mcolor.red green:mcolor.green blue:mcolor.blue alpha:0.5];
    float mypercentValue=(6.28*percentValue)/100;
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, pieChart.centerX_, pieChart.centerY_);
    CGContextAddArc(context, pieChart.centerX_, pieChart.centerY_, outerRadius-1,4.71,4.71+mypercentValue , 0);
    CGContextClosePath(context); 
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    
    
    // Draw center circle
    color=[UIColor colorWithRed:mcolor.red green:mcolor.green blue:mcolor.blue alpha:mcolor.alpha];
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, pieChart.centerX_, pieChart.centerY_);
    CGContextAddArc(context, pieChart.centerX_, pieChart.centerY_, innerRadius,0,6.28, 0);
    CGContextClosePath(context); 
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    //Outer circle    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    if(!borderWidth)
        borderWidth=outerRadius/18.0;
    CGContextSetLineWidth(context, borderWidth);
    CGContextAddEllipseInRect(context, CGRectMake(pieChart.centerX_-outerRadius, pieChart.centerY_-outerRadius, 2*outerRadius, 2*outerRadius));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    

    
    //Set Image
    if(centerIcon)
    {
        UIImageView *iView=[[UIImageView alloc]initWithImage:centerIcon];
        [iView setCenter:CGPointMake(pieChart.centerX_, pieChart.centerY_)];
        [self addSubview:iView];
    }
    
}

-(void)drawPieChart
{
    [self initAndWarnings];
    [self findCenter];
    [self setNeedsDisplay];
}

/****************************************************************************/
//
//  This methods inits all the basic variables required to create a piechart
//  It fetches most of the values from delegate methods defined in 
//  implementation class (BiTransPieChartTestClass.m)
//
//
/*****************************************************************************/



-(void)initAndWarnings
{
    
    pieChart=[[MIMPieChart alloc]init];
    
        
    
    if([delegate respondsToSelector:@selector(colorForBackground:)])
    {
        bgColor=[delegate colorForBackground:self];
        
        //SET BACKGROUND COLOR
        if(bgColor==nil)
            [self setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0]];
        else
            [self setBackgroundColor:[UIColor colorWithRed:bgColor.red green:bgColor.green blue:bgColor.blue alpha:bgColor.alpha]];

    }
    else
    {
        //SET BACKGROUND COLOR
        [self setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0]];

    }
    
 
}


-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    float viewHeight=self.frame.size.height;
    float viewWidth=self.frame.size.width;
    
    pieChart.centerX_=viewWidth/2;
    pieChart.centerY_=viewHeight/2;
    
}


@end
