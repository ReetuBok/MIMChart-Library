//
//  OthersPieChart.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OthersPieChart.h"

@implementation OthersPieChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    //
    //    CGFloat BGLocations3[2] = { 0.0, 1.0 };
    //    CGFloat BgComponents3[12] = {0.290,0.07,0.552 , 1.0,  // Start color
    //        0.696,0.554,0.8 , 1.0}; // End color
    //    CGGradientRef gradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents3, BGLocations3, 2);
    //    
    //    
    //    
    //    float radius=100.0;
    //    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, TRUE);
    CGContextSetShouldAntialias(context, TRUE);
    
    
    
    int totalSections=[pieChart.valueArray_ count];
    
    
    
    //Draw the background with the gray Gradient
    pieChart.angleArrays_=[[NSMutableArray alloc]initWithCapacity:totalSections];
    
    
    
    float k=0.8;
    CGRect a=self.frame;
    a.origin.x=0;
    a.origin.y=0;
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
    CGContextAddRect(context, a);
    CGContextFillPath(context);
    
    
    
    
    
    NSArray *tempArray=[NSArray arrayWithArray:pieChart.valueArray_];
    
    
    
    
    float pi=3.1415/2.0; 
    float arcOffset=0.0;
    float newCenterX=pieChart.centerX_;
    
    
    
    for(int j=0;j<[tempArray count];j++)
    {
        float newCenterY=pieChart.centerY_ - (powf(-1, j+1) * 10.0);
        float sum=[pieChart returnSum:[tempArray objectAtIndex:j]];
        
        
        for(int i=0;i<[[tempArray objectAtIndex:j] count];i++)
        {
            int tempI=i;
            
            if(j%2==1)
                i=([[tempArray objectAtIndex:j] count]-1)-i;
            
            float myAngle=[[[tempArray objectAtIndex:j] objectAtIndex:i] floatValue]/sum; // in radians
            myAngle=myAngle*2.0*pi;
            
            [pieChart.angleArrays_ addObject:[NSNumber numberWithFloat:myAngle]];
            
            
            
            
            
            /*************/
            //SECTION COLORS/ GRADIENTS
            /*************/
            /*
             if(gradientActive)
             {
             
             //fill color and shadow
             
             CGContextSaveGState(context);
             CGContextMoveToPoint(context, newCenterX, newCenterY);
             CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_-2,arcOffset-(myAngle/2)+0.01,arcOffset+(myAngle/2)-0.01, 0);
             CGContextClosePath(context); 
             
             CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 10.0, [UIColor blackColor].CGColor);
             CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
             CGContextFillPath(context);
             CGContextRestoreGState(context);
             
             
             
             //gradient clipping
             CGContextSaveGState(context);
             CGContextMoveToPoint(context, newCenterX, newCenterY);
             CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_,arcOffset-(myAngle/2),arcOffset+(myAngle/2), 0);
             CGContextClosePath(context); 
             CGContextClip(context); 
             
             CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 10.0, [UIColor blackColor].CGColor);
             //User may give single as well as multiple gradients.
             if([pieChart.gradientArray_ count]==1)
             {
             //Apply that same single gradient to all the sections
             CGPoint endRadius;
             CGPoint startshine;
             
             if(arcOffset>3.14)
             {
             endRadius  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
             startshine =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2)); ;
             }
             else {
             startshine  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
             endRadius =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2));
             }
             
             
             CGGradientRef myGradient=(CGGradientRef)[pieChart.gradientArray_ objectAtIndex:0];
             CGContextDrawLinearGradient(context,myGradient , startshine, endRadius, kCGGradientDrawsAfterEndLocation);
             
             
             
             
             }
             else
             {
             
             CGPoint endRadius;
             CGPoint startshine;
             
             if(arcOffset>3.14)
             {
             endRadius  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
             startshine =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2));
             }
             else {
             startshine  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
             endRadius =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2));
             }
             
             
             CGGradientRef myGradient=(CGGradientRef)[pieChart.gradientArray_ objectAtIndex:i];
             CGContextDrawLinearGradient(context, myGradient, startshine, endRadius, kCGGradientDrawsAfterEndLocation);
             
             }
             
             
             
             
             CGContextRestoreGState(context);
             
             
             
             
             
             }
             else
             */
            {
                
                
                
                
                CGContextMoveToPoint(context, newCenterX, newCenterY);
                CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_,arcOffset,arcOffset+myAngle, 0);
                
                
                UIColor *color;
                if(tint==BEIGETINT)
                {
                    int totalColors=[MIMColor sizeOfColorArray];
                    NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+30)%totalColors];    //i+17 brown tint//30 dark colors(like beige)// // total 43
                    float red=[[colorDic valueForKey:@"red"] floatValue];
                    float green=[[colorDic valueForKey:@"green"] floatValue];
                    float blue=[[colorDic valueForKey:@"blue"] floatValue];
                    
                    color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
                }
                else if(tint ==REDTINT)
                {
                    int totalColors=[MIMColor sizeOfColorArray];
                    NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+17)%totalColors];
                    float red=[[colorDic valueForKey:@"red"] floatValue];
                    float green=[[colorDic valueForKey:@"green"] floatValue];
                    float blue=[[colorDic valueForKey:@"blue"] floatValue];
                    
                    color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
                }
                else if(tint==GREENTINT)
                {
                    int totalColors=[MIMColor sizeOfColorArray];
                    NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i)%totalColors];
                    float red=[[colorDic valueForKey:@"red"] floatValue];
                    float green=[[colorDic valueForKey:@"green"] floatValue];
                    float blue=[[colorDic valueForKey:@"blue"] floatValue];
                    
                    color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
                }
                else 
                {
                    MIMColorClass *mcolor=[pieChart.colorArray_ objectAtIndex:i];
                    color=[[UIColor alloc]initWithRed:mcolor.red green:mcolor.green blue:mcolor.blue alpha:mcolor.alpha];
                }
                
                
                
                CGContextSetFillColorWithColor(context, color.CGColor);    
                CGContextSetShadowWithColor(context, CGSizeMake(-0.0, 0.0), 3, [UIColor blackColor].CGColor);
                
                CGContextClosePath(context); 
                CGContextFillPath(context);
                
                
                
            }
            
            /*************/
            //BORDERS
            /*************/
            //Works ok now dealing with very high width of border
            //it gives rounded edge for very thin sections too.
            
            /*
             
             float borderWidth=0.0;
             
             if(drawBorders)
             borderWidth=0.2;
             
             if(gradientActive)
             borderWidth=0.2;
             
             
             
             if(borderWidth > 0.0)
             {
             UIColor *borderColor_=[UIColor blackColor];//[UIColor colorWithRed:borderColor.red green:borderColor.green blue:borderColor.blue alpha:borderColor.alpha];
             
             
             UIBezierPath *myPath;
             myPath=[[UIBezierPath alloc]init];
             myPath.lineWidth=borderWidth;
             myPath.lineCapStyle=kCGLineCapRound;
             
             
             [myPath moveToPoint:CGPointMake(newCenterX, newCenterY)];
             [myPath addArcWithCenter:CGPointMake(newCenterX, newCenterY) radius:pieChart.radius_ startAngle:arcOffset-(myAngle/2) endAngle:arcOffset+(myAngle/2) clockwise:1];
             [myPath addLineToPoint:CGPointMake(newCenterX, newCenterY)];
             
             [borderColor_ setStroke];
             [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
             }
             */
            
            
            arcOffset+=myAngle;
            i=tempI;
            
            
            
        }
    }
    
    
    
    UIGraphicsPopContext();
    //[self addSubview:reflectionLayer];
    
    

    
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


/************************************************************************************************************************************************/
//
//  This methods inits all the basic variables required to create a piechart
//  It fetches most of the values from delegate methods defined in implementation class (BasicPieChartTestClass.m)
//
//
/************************************************************************************************************************************************/

-(void)initAndWarnings
{
    
    
    pieChart=[[MIMPieChart alloc]init];
    
    
    
    
    //SET RADIUS
    
    pieChart.radius_=[delegate radiusForPie:self];
    
    NSAssert((pieChart.radius_!=0),@"WARNING::Radius is 0. Please set some value to radius.");
    
    
    
    
    
    //SET BACKGROUND COLOR
    [self setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
    
    
    
    
    //SET PIE CHART VALUES
    pieChart.valueArray_=[NSMutableArray arrayWithArray:[delegate valuesForPie:self]];
    
    
    
    //SET COLOR VALUES
    if([delegate respondsToSelector:@selector(colorsForPie:)])
    {
        pieChart.colorArray_=[NSMutableArray arrayWithArray:[delegate colorsForPie:self]];   
        
        if([delegate colorsForPie:self]!=nil)
        {
            NSAssert(([[pieChart.valueArray_ objectAtIndex:0] count]==[pieChart.colorArray_ count]),@"ERROR::Counts of colors  != Count of values ");
            self.tint=USERDEFINED;
            
            //IF USER ended up giving colors as well as gradient.
            //show this warning that
            //            if(gradientActive)
            //            {
            //                NSLog(@"WARNING ! : You provided colors as well with gradient colors, Gradient colors get priority.");
            //            }
            
            
            return;
        }
        
        
        
        
    }
    else
        self.tint=USERDEFINED;
    
    
}


-(void)drawPieChart
{
    
    [self initAndWarnings];
    [self findCenter];
    [self setNeedsDisplay];
    
}
@end
