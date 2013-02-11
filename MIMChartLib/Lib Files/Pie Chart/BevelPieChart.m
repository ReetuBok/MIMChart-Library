//
//  BevelPieChart.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BevelPieChart.h"



@interface BevelPieChart()
-(void)initAndWarnings;
-(void)findCenter;
@end


@implementation BevelPieChart
@synthesize delegate;
@synthesize dropShadowOnRoad;
@synthesize tint;
@synthesize drawBorders;
@synthesize userTouchAllowed;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if([MIMColor sizeOfColorArray]==0)
            [MIMColor InitColors];
    }
    return self;
}
/*
-(void)readFromCSV:(NSString*)path  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dcolumn
{
    
    
    
    valueArray_=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [valueArray_ addObject:[columnArray objectAtIndex:dcolumn]];
            k++;
            
        }
    
    
    titleArray_=[[NSMutableArray alloc]init];
    
    
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [titleArray_ addObject:[columnArray objectAtIndex:tcolumn]];
            k++;
            
        }
    
    
}


-(void)readFromArray:(NSArray*)valuearray  Title:(NSArray *)titlesArray  Color:(NSArray *)colorsArray
{
    
    
    
    valueArray_=[[NSMutableArray alloc]initWithArray:valuearray];
    titleArray_=[[NSMutableArray alloc]initWithArray:titlesArray];
}
 */

-(void)initAndWarnings
{
    selectedPie=-99;
    
    
    pieChart=[[MIMPieChart alloc]init];
    
    
    
    
    //SET RADIUS
    
    pieChart.radius_=[delegate radiusForPie:self];
    
    NSAssert((pieChart.radius_!=0),@"WARNING::Radius is 0. Please set some value to radius.");
    
    
    
    
    
    //SET BACKGROUND COLOR
    
    
    

    
    if([delegate respondsToSelector:@selector(colorForBackground:)])
    {
        bgColor=[delegate colorForBackground:self];
        
        if(bgColor==nil)
            bgColor=[MIMColorClass colorWithRed:0.9 Green:0.9 Blue:0.9 Alpha:1.0];
        
    }
    else
    {
        //SET BACKGROUND COLOR
        bgColor=[MIMColorClass colorWithRed:0.9 Green:0.9 Blue:0.9 Alpha:1.0];
        
    }
    

    
    
    
    
    
    //SET PIE CHART VALUES
    
    pieChart.valueArray_=[NSMutableArray arrayWithArray:[delegate valuesForPie:self]];
    
    
    
    
    //SET GRADIENT 
    if([delegate respondsToSelector:@selector(gradientsForPie:)])
    {
        
        pieChart.gradientArray_=[delegate gradientsForPie:self];
        
        if(pieChart.gradientArray_!=nil)
        {
            gradientActive=TRUE;
        }
        else
            gradientActive=FALSE;
        
    }
    
    
    
    
    //SET COLOR VALUES
    if([delegate respondsToSelector:@selector(colorsForPie:)])
    {
        pieChart.colorArray_=[NSMutableArray arrayWithArray:[delegate colorsForPie:self]];   
        
        if([delegate colorsForPie:self]!=nil)
        {
            NSAssert(([pieChart.valueArray_ count]==[pieChart.colorArray_ count]),@"ERROR::Counts of colors  != Count of values ");
            self.tint=USERDEFINED;
            
            //IF USER ended up giving colors as well as gradient.
            //show this warning that
            if(gradientActive)
            {
                NSLog(@"WARNING ! : You provided colors as well with gradient colors, Gradient colors get priority.");
            }
            
            
            return;
        }
        
        
        
        
    }
    else
        self.tint=USERDEFINED;
    
    

    
}

-(void)drawPieChart
{
    selectedPie=-99;
    [self initAndWarnings];
    [self findCenter];
    [self setNeedsDisplay];  
    
}
/*

-(void)drawBottomTitlesText
{
    float sum=0;
    for(int i=0;i<[valueArray_ count];i++)
    {
        
        sum+=[[valueArray_ objectAtIndex:i] floatValue];
    }
    
    
    //Only  text
    for(int i=0;i<[titleArray_ count];i++)
    {
        
        float percent=([[valueArray_ objectAtIndex:i] floatValue]/sum)*100;
        
        UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(2*radius_ + 60,i*30+ 25,130,30)];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setTextAlignment:UITextAlignmentLeft];
        [title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [title setTextColor:[UIColor blackColor]];
        [title setText:[NSString stringWithFormat:@"  %@  (%.0f %@)",[titleArray_ objectAtIndex:i],percent,@"%"]];
        title.tag=1000+i;
        [self addSubview:title];
    }
    
}

-(void)highlightTheTitle
{
    //First remove all the highlights
    for (id view in self.subviews)
        if([view isKindOfClass:[UILabel class]]){
            
            UILabel *viewLabel=(UILabel *)view;
            
            [viewLabel.layer setBorderWidth:0.0];
            [viewLabel.layer setShadowOpacity:0];
        }
    
    
    
    UILabel *view=(UILabel *)[self viewWithTag:1000+selectedPie];
    [view.layer setBorderColor:[UIColor grayColor].CGColor];
    [view.layer setBorderWidth:1.0];        
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:5.0];
    [view.layer setShadowRadius:2.0];
    [view.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [view.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    [view.layer setShadowOpacity:0.8];
    
}




-(void)drawBottomTitles:(CGContextRef)context
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    int tintOffset;
    if(tint==REDTINT)
        tintOffset=17;
    if(tint==GREENTINT)
        tintOffset=0;
    if(tint==BEIGETINT)
        tintOffset=30;
    
    
    //Draw the squares ONly
    
    for(int i=0;i<[titleArray_ count];i++)
    {
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
        
        
        //Simple Colored Rect
        CGRect rectangle = CGRectMake(2*radius_ + 30,i*30+ 30,15,15);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rectangle);
        //    
    }
}

*/

- (void)drawRect:(CGRect)rect
{
    
    int totalSections=[pieChart.valueArray_ count];
    
    
    
    //Draw the background with the gray Gradient
    pieChart.angleArrays_=[[NSMutableArray alloc]initWithCapacity:totalSections];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    


    CGRect a=self.frame;
    a.origin.x=0;
    a.origin.y=0;
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:bgColor.red green:bgColor.green blue:bgColor.blue alpha:bgColor.alpha].CGColor);    
    CGContextAddRect(context, a);
    CGContextFillPath(context);
    
    
    
    
    
    float sum=[pieChart returnSum:pieChart.valueArray_];
    
    
    
    
    
    float pi=3.1415;
    
    float constantTheta=[[pieChart.valueArray_ objectAtIndex:0] floatValue]/sum;  
    constantTheta=constantTheta*2.0*pi;
    constantTheta/=2;
    
    
    
    float arcOffset=0.0;
    float z=0;
    
    
    //Find the base point
    float newCenterX=(pieChart.centerX_);
    
    float newCenterY=pieChart.centerY_;
    
    
    for(int i=0;i<totalSections;i++)
    {
        
        float myAngle=[[pieChart.valueArray_ objectAtIndex:i] floatValue]/sum; // in radians
        myAngle=myAngle*2.0*pi;
        
        
        float nextAngle=[[pieChart.valueArray_ objectAtIndex:(i+1)%totalSections] floatValue]/sum; // in radians
        nextAngle=nextAngle*2.0*pi;
        
        
        [pieChart.angleArrays_ addObject:[NSNumber numberWithFloat:myAngle]];
        
        
        
        
        if(i>0)
        {
            z+=myAngle;
            
            
        }
        
        
        /*************/
        //SECTION COLORS/ GRADIENTS
        /*************/
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
                
                
                CGGradientRef myGradient=(__bridge CGGradientRef)[pieChart.gradientArray_ objectAtIndex:0];
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
                
                
                CGGradientRef myGradient=(__bridge CGGradientRef)[pieChart.gradientArray_ objectAtIndex:i];
                CGContextDrawLinearGradient(context, myGradient, startshine, endRadius, kCGGradientDrawsAfterEndLocation);
                
            }
            
            
            
            
            CGContextRestoreGState(context);
            
            
            
            
            
        }
        else
        {
            
            
            
            
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_,arcOffset-(myAngle/2),arcOffset+(myAngle/2), 0);
            
            
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
            CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 10.0, [UIColor blackColor].CGColor);
            
            CGContextClosePath(context); 
            CGContextFillPath(context);
            
            
            
        }
    
        /*************/
        //BORDERS
        /*************/
        //Works ok now dealing with very high width of border
        //it gives rounded edge for very thin sections too.
        
        
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

        
        if(i==0)
            arcOffset=constantTheta+nextAngle/2;
        else 
            arcOffset=constantTheta+z+nextAngle/2;
        
        
        
    }
    
    
    
    UIGraphicsPopContext();
    //[self addSubview:reflectionLayer];
    
    
    

    
    
}

-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    float viewHeight=self.frame.size.height;
    
    
    pieChart.centerX_=pieChart.radius_ + 20;
    pieChart.centerY_=viewHeight/2;
    
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    
//    
//    UITouch *touch = [touches anyObject];
//    CGPoint touchPoint=[touch locationInView:self];
//    
//    float angle=atanf((touchPoint.y -centerY_)/(touchPoint.x-centerX_));
//    int quadrant=[self findQuadrant:touchPoint];
//    
//    if(quadrant !=0)
//    {
//        
//        float radian;
//        
//        switch (quadrant) {
//            case 1:
//            {
//                radian=(2*3.14)+angle;
//            }
//                break;
//                
//            case 2:
//            {
//                radian=3.14+angle;
//            }
//                break;
//                
//            case 3:
//            {
//                angle=1.57+angle;
//                radian=1.57+angle;
//                
//            }
//                break;
//                
//            case 4:
//            {
//                radian=angle;
//                
//            }
//                break;
//        }
//        
//        //Find which pie has to be highlighted.
//        int pieToBeSelected=0;
//        float offset=0;
//        
//        
//        for(int i=0;i<[valueArray_ count];i++)
//        {
//            
//            float myAngle=[[angleArrays_ objectAtIndex:i] floatValue];
//            
//            if((radian>=offset)&&(radian<offset+myAngle)){
//                pieToBeSelected=i;
//                break;
//            }
//            
//            offset+=myAngle;
//        }
//        
//        if(selectedPie==pieToBeSelected)
//        {
//            
//            //Selected Pie is touched Again to return it back to original Location
//            returnBackToOriginalLocation=YES;
//            
//            
//        }else{
//            
//            selectedPie=pieToBeSelected;
//            returnBackToOriginalLocation=NO;
//            
//        }
//        [self highlightTheTitle];
//        [self setNeedsDisplay];
//        
//    }
//    
//    
//}
//
//-(int)findQuadrant:(CGPoint)touchPoint
//{
//    //top right
//    CGRect rect=CGRectMake(centerX_, 0, radius_,centerY_ );
//    BOOL contains = CGRectContainsPoint(rect, touchPoint);
//    if(contains)
//        return 1;
//    
//    
//    //top left
//    rect=CGRectMake(0, 0, radius_+20, centerY_);
//    contains = CGRectContainsPoint(rect, touchPoint);
//    if(contains)
//        return 2;
//    
//    //bottom left
//    rect=CGRectMake(0, centerY_, radius_ + 20, centerY_);
//    contains = CGRectContainsPoint(rect, touchPoint);
//    if(contains)
//        return 3;
//    
//    
//    //bottom right
//    rect=CGRectMake(centerX_, centerY_, radius_, centerY_);
//    contains = CGRectContainsPoint(rect, touchPoint);
//    if(contains)
//        return 4;
//    
//    
//    
//    
//    return 0;
//}


- (void)dealloc
{
    ////[super dealloc];
}

@end
