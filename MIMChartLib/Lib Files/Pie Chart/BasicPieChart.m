//
//  BasicPieChart.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BasicPieChart.h"
#import "MIMColorClass.h"


@interface BasicPieChart()
-(void)initAndWarnings;
-(void)findCenter;
-(float)offsetThetaForSection1:(float)maxP :(float)innerRadius :(int)totalSections;
-(float)offsetThetaBorderForSection1:(float)maxP :(float)innerRadius :(int)totalSections;
-(float)findMaxP:(float)sum :(int)totalSections :(float)innerRadius;
@end


@implementation BasicPieChart
@synthesize delegate;
@synthesize dropShadowOnRoad;
@synthesize borderWidth;
@synthesize borderColor;
@synthesize glossEffect;
@synthesize tint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        borderWidth=1.0; //SET THE DEFAULT VALUE FOR BORDER WIDTH TO 1.0
        borderColor=[MIMColorClass colorWithComponent:@"0,0,0"]; //SET THE DEFAULT BORDER COLOR = BLACK
        glossEffect=NO; 
        [MIMColor InitColors];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    

    
    
    int totalSections=[pieChart.valueArray_ count];
    

    
    //Draw the background with the gray Gradient
    pieChart.angleArrays_=[[NSMutableArray alloc]initWithCapacity:totalSections];
    
 
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
   
    
    //Draw the background with the gray Gradient
    float viewWidth=self.frame.size.width;
    float viewHeight=self.frame.size.height;
    
    
    
//    CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
//    CGFloat BgComponents[12] = { 0.4, 0.4, 0.4 , 1.0,  // Start color
//        0.75, 0.75, 0.75 , 1.0,  // Start color
//        0.9, 0.9, 0.9 , 1.0 }; // Mid color and End color
//    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
//    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
//    
//    
//    
//    CGPoint startBg = CGPointMake(pieChart.radius_ + 20,viewHeight/2); 
//    CGFloat endRadius=20+2*pieChart.radius_;//MAX(viewWidth/2, viewHeight/2);
//    
//    
//    CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
//    CGColorSpaceRelease(BgRGBColorspace);
//    CGGradientRelease(bgRadialGradient);
    
    float k=1.0;
    CGRect a=self.frame;
    a.origin.x=0;
    a.origin.y=0;
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
    CGContextAddRect(context, a);
    CGContextFillPath(context);


    
    
    
    float sum=[pieChart returnSum:pieChart.valueArray_];
    


    
    
    float pi=3.1415;
    float innerRadius=0.0;
    
    float constantTheta=[[pieChart.valueArray_ objectAtIndex:0] floatValue]/sum;  
    constantTheta=constantTheta*2.0*pi;
    constantTheta/=2;
    
    

    float arcOffset=0.0;
    float z=0;
    
    
    
   

    //FIND MAX P
    float maxP=[self findMaxP:sum :totalSections :innerRadius];
        
    //CALCULATE offsetTheta FOR SECTION AT index =0
    float offsetTheta=[self offsetThetaForSection1:maxP :innerRadius :totalSections];
    
    
    float PreviousL=0.0;
    
    float offsetThetaNew=0.0;
    
    
    
    float offsetThetaForB=[self offsetThetaBorderForSection1:maxP :innerRadius :totalSections];
    float offsetThetaNewForB=0.0;
    
    for(int i=0;i<totalSections;i++)
    {
        
        float myAngle=[[pieChart.valueArray_ objectAtIndex:i] floatValue]/sum; // in radians
        myAngle=myAngle*2.0*pi;
        
        
        float nextAngle=[[pieChart.valueArray_ objectAtIndex:(i+1)%totalSections] floatValue]/sum; // in radians
        nextAngle=nextAngle*2.0*pi;
        
      
        [pieChart.angleArrays_ addObject:[NSNumber numberWithFloat:myAngle]];

        
        
        
        float currentP=(myAngle+nextAngle)/2;
        currentP=currentP*180/pi; //convert current angle radian to degree
        currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
        
        float diffP=maxP-currentP;
        diffP=diffP/2;
        
        //Radians which need to be deducted from arc.
        offsetThetaNew=(360.0 * diffP)/(2*pi*pieChart.radius_); //In degree
        offsetThetaNew=offsetThetaNew*pi/180.0;//in radian

        if(i>0)
        {
            z+=myAngle;
           
            
        }
        
    
        if(i==(totalSections -1)||(i==0))
        {
            PreviousL=maxPForS1;
            
        }else {
            PreviousL=0.0;
        }
        


        //Find the base point
        float newCenterX=(innerRadius+diffP+PreviousL) * cosf(arcOffset) ; 
        newCenterX+=(pieChart.centerX_);
        
        float newCenterY=(innerRadius+diffP+PreviousL) * sinf(arcOffset);
        newCenterY+=pieChart.centerY_;
        
        /*************/
        //SECTION COLORS/ GRADIENTS
        /*************/
        if(gradientActive)
        {
        
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_-diffP-PreviousL,arcOffset-(myAngle/2)+offsetTheta,arcOffset+(myAngle/2)-offsetThetaNew, 0);
            CGContextClosePath(context); 
            CGContextClip(context); 

        
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
                
                
                CGGradientRef myGradient=[pieChart.gradientArray_ objectAtIndex:0];
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
                
                
                CGGradientRef myGradient=[pieChart.gradientArray_ objectAtIndex:i];
                CGContextDrawLinearGradient(context, myGradient, startshine, endRadius, kCGGradientDrawsAfterEndLocation);
                
            }
            
            
            
            
            CGContextRestoreGState(context);


            
            
        
        }
        else
        {
        
            
            
            
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_-diffP-PreviousL,arcOffset-(myAngle/2)+offsetTheta,arcOffset+(myAngle/2)-offsetThetaNew, 0);
            
            
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
            
            
            CGContextClosePath(context); 
            CGContextFillPath(context);
        
            
        
        }
        

        
        

        
        /*************/
        //BORDERS
        /*************/
        //Works ok now dealing with very high width of border
        //it gives rounded edge for very thin sections too.
        
        if(borderWidth > 0.0)
        {
            UIColor *borderColor_=[UIColor colorWithRed:borderColor.red green:borderColor.green blue:borderColor.blue alpha:borderColor.alpha];
            
            
            UIBezierPath *myPath;
            myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=borderWidth;
            myPath.lineCapStyle=kCGLineCapRound;
            
            
            [myPath moveToPoint:CGPointMake(newCenterX, newCenterY)];
            [myPath addArcWithCenter:CGPointMake(newCenterX, newCenterY) radius:pieChart.radius_-diffP-PreviousL startAngle:arcOffset-(myAngle/2)+offsetTheta endAngle:arcOffset+(myAngle/2)-offsetThetaNew clockwise:1];
            [myPath addLineToPoint:CGPointMake(newCenterX, newCenterY)];
            
            [borderColor_ setStroke];
            [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        }
        
        
        
        /*************/
        //GRADIENT
        /*************/
        
        if(glossEffect)
        {
        
            CGContextSaveGState(context);
            
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, pieChart.radius_-diffP-PreviousL-2,arcOffset-(myAngle/2-0.018)+offsetTheta,arcOffset+(myAngle/2-0.018)-offsetThetaNew, 0);
            CGContextClosePath(context); 
            CGContextClip(context); 
            
            
            
            
            
            
            CGFloat shineLocations[2] = { 0.0, 1.0 };
            CGFloat shineComponents[12] = { 1.0, 1.0, 1.0 , 0.0,  // Start color
                1.0, 1.0, 1.0 , 0.7 }; // Mid color and End color
            CGColorSpaceRef shineRGBColorspace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef shineLinearGradient = CGGradientCreateWithColorComponents(shineRGBColorspace, shineComponents, shineLocations, 2);
            
            CGPoint endRadius;CGPoint startshine;
            
            if(arcOffset<3.14)
            {
                if(gradientActive)
                {
                    endRadius  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/4),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/4));
                }
                else 
                {
                    endRadius  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset-myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset),newCenterY+(pieChart.radius_) * sinf(arcOffset));    
                }
                 
            }
            else 
            {
                if(gradientActive)
                {
                    startshine  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/4),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/4)); 
                    endRadius =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2));
                }
                else 
                {
                    startshine  = CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset),newCenterY+(pieChart.radius_) * sinf(arcOffset)); 
                    endRadius =CGPointMake(newCenterX+(pieChart.radius_) * cosf(arcOffset+myAngle/2),newCenterY+(pieChart.radius_) * sinf(arcOffset+myAngle/2));
                }
                
            }
            
            
            
            CGContextDrawLinearGradient(context, shineLinearGradient, startshine, endRadius, kCGGradientDrawsAfterEndLocation);
            CGColorSpaceRelease(shineRGBColorspace);
            CGGradientRelease(shineLinearGradient);
            
            
            CGContextRestoreGState(context);
            
        
        }
        
        
        
        offsetThetaForB=offsetThetaNewForB;
        offsetTheta=offsetThetaNew;
        PreviousL=diffP;
        
        
        
        if(i==0)
            arcOffset=constantTheta+nextAngle/2;
        else 
            arcOffset=constantTheta+z+nextAngle/2;
        
        
        
    }
    
    
    
    UIGraphicsPopContext();
    //[self addSubview:reflectionLayer];

}




-(void)drawPieChart
{

    [self initAndWarnings];
    [self findCenter];
    [self setNeedsDisplay];
    
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
    
    selectedPie=-99;
    
    
    pieChart=[[MIMPieChart alloc]init];
    
    
 
    
    //SET RADIUS
    
    pieChart.radius_=[delegate radiusForPie:self];

    NSAssert((pieChart.radius_!=0),@"WARNING::Radius is 0. Please set some value to radius.");

    
    
    

    //SET BACKGROUND COLOR
    
    

    [self setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];
    

    
    
    
    
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

-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    float viewHeight=self.frame.size.height;
    
    
    pieChart.centerX_=pieChart.radius_ + 20;
    pieChart.centerY_=viewHeight/2;
    
}

-(float)offsetThetaForSection1:(float)maxP :(float)innerRadius :(int)totalSections
{
    
    
    
    float sum=[pieChart returnSum:pieChart.valueArray_];
    float pi=3.1415;
    
    
    float myAngle=[[pieChart.valueArray_ objectAtIndex:0] floatValue]/sum; // in radians
    myAngle=myAngle*2.0*pi;
    
    
    float nextAngle=[[pieChart.valueArray_ objectAtIndex:totalSections-1] floatValue]/sum; // in radians
    nextAngle=nextAngle*2.0*pi;
    
    
    
    
    
    
    float currentP=(myAngle+nextAngle)/2;
    currentP=currentP*180/pi; //convert current angle radian to degree
    currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
    
    float diffP=maxP-currentP;
    diffP=diffP/2;
    
    
    maxPForS1=diffP;
    
    
    //Radians which need to be deducted from arc.
    float offsetThetaNew=(360.0 * diffP)/(2*pi*pieChart.radius_); //In degree
    offsetThetaNew=offsetThetaNew*pi/180.0;//in radian
    
    
    return offsetThetaNew;
}


-(float)offsetThetaBorderForSection1:(float)maxP :(float)innerRadius :(int)totalSections
{
    
    
    
    float sum=[pieChart returnSum:pieChart.valueArray_];
    float pi=3.1415;
    
    
    float myAngle=[[pieChart.valueArray_ objectAtIndex:0] floatValue]/sum; // in radians
    myAngle=myAngle*2.0*pi;
    
    
    float nextAngle=[[pieChart.valueArray_ objectAtIndex:totalSections-1] floatValue]/sum; // in radians
    nextAngle=nextAngle*2.0*pi;
    
    
    
    
    
    
    float currentP=(myAngle+nextAngle)/2;
    currentP=currentP*180/pi; //convert current angle radian to degree
    currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
    
    float diffP=maxP-currentP;
    diffP=diffP/2;
    diffP=diffP-1;
    
    
    //Radians which need to be deducted from arc.
    float offsetThetaNew=(360.0 * diffP)/(2*pi*pieChart.radius_); //In degree
    offsetThetaNew=offsetThetaNew*pi/180.0;//in radian
    
    
    return offsetThetaNew;
}

-(float)findMaxP:(float)sum :(int)totalSections :(float)innerRadius
{
    float pi=3.1415;
    int maxIndex=0;
    float maxValue=[[pieChart.valueArray_ objectAtIndex:0] floatValue];
    
    for(int i=1;i<totalSections;i++)
    {
        float value1=[[pieChart.valueArray_ objectAtIndex:i] floatValue];
        if(maxValue<value1)
        {
            maxValue=value1;
            maxIndex=i;
        }
        
    }
    float value1=[[pieChart.valueArray_ objectAtIndex:maxIndex] floatValue];
    float value2=[[pieChart.valueArray_ objectAtIndex:(maxIndex+1)%totalSections] floatValue];
    
    int m=maxIndex;
    if(maxIndex==0)
        m=totalSections-1;
    
    float value3=[[pieChart.valueArray_ objectAtIndex:m] floatValue];
    
    
    float maxP;
    if((value1-value2)<(value1-value3))
    {
        //between (value1 and value2) is max P
        maxP=(value1+value2)/2;
        maxP=maxP/sum; 
        maxP=maxP*2.0*pi;// in radians
        maxP=maxP*180/pi; //convert current angle radian to degree
        maxP=(maxP*2*pi*innerRadius)/360.0;//length  of max p
        
    }
    else
    {
        //between (value1 and value3) is max P
        maxP=(value1+value3)/2;
        maxP=maxP/sum; 
        maxP=maxP*2.0*pi;// in radians
        maxP=maxP*180/pi; //convert current angle radian to degree
        maxP=(maxP*2*pi*innerRadius)/360.0;//length  of max p
    }
    return maxP;
    
}


#pragma mark - PUBLIC METHODS



@end
