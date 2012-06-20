/*Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*/
//
//  BasicPie.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BasicPie.h"
#import "BasicPieChart.h"

@interface BasicPie()
-(void)HidePreviousPopUp;
-(void)StartTimerForAnimatingPieEasingIn;
-(void)bouncyEffectOnPie;

-(void)findCenter;
-(float)offsetThetaForSection1:(float)maxP :(float)innerRadius :(int)totalSections;
-(float)offsetThetaBorderForSection1:(float)maxP :(float)innerRadius :(int)totalSections;
-(float)findMaxP:(float)sum :(int)totalSections :(float)innerRadius;
@end


@implementation BasicPie
@synthesize center;
@synthesize radius;
@synthesize borderWidth;
@synthesize borderColor;
@synthesize glossEffect;
@synthesize tint;
@synthesize valueArray_;
@synthesize gradientArray_;
@synthesize gradientActive;
@synthesize colorArray_;
@synthesize angleArrays_;
@synthesize animation;
@synthesize userTouchAllowed;
@synthesize enableDoubleTap;
@synthesize enableShowDetailBox;
@synthesize afterTappingWhichDirectionToRotate;
@synthesize enableBubbleBox;


#pragma mark - INIT
float pi=3.1415;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.alpha=0.1;

        
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)setUserTouchEnabled:(BOOL)enabled
{
    if(enabled)
    {
        tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapByUser:)];
        tapGesture.delegate=self;
        tapGesture.numberOfTapsRequired=1;
        [self addGestureRecognizer:tapGesture];
        
        if(enableDoubleTap && enableShowDetailBox)
        {
            dtapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(DTapByUser:)];
            dtapGesture.delegate=self;
            dtapGesture.numberOfTapsRequired=2;
            [self addGestureRecognizer:dtapGesture];
            
            
            
            [tapGesture requireGestureRecognizerToFail:dtapGesture];

        }
        

        
        rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(RotationByUser:)];
        rotationGesture.delegate=self;
        [self addGestureRecognizer:rotationGesture];
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}


-(void)StartTimerForAnimatingPieEasingIn
{
    timer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(IncreaseTheAlpha) userInfo:nil repeats:YES];
    
}

-(void)IncreaseTheAlpha
{
    
    alpha+=0.05;
    
    self.alpha=alpha;
        
    if(alpha>=1.0)
    {
        [timer invalidate];
        timer=nil;
        
        return;
    }
    
    
}



-(void)findCenter
{
    //Find the angle of the touchPoint.
    //Draw the background with the gray Gradient
    //float viewHeight=self.frame.size.height;
    center=CGPointMake(self.radius + 5, self.radius + 5);
    

    
}

-(float)returnSum:(NSArray *)array
{
    float sum=0.0;
    
    for(int i=0;i<[array count];i++)
        sum+=[[array objectAtIndex:i] floatValue];
    
    return sum;
    
}

-(float)offsetThetaForSection1:(float)maxP :(float)innerRadius :(int)totalSections
{
    
    
    
    float sum=[self returnSum:self.valueArray_];
    float pi=3.1415;
    
    
    float myAngle=[[self.valueArray_ objectAtIndex:0] floatValue]/sum; // in radians
    myAngle=myAngle*2.0*pi;
    
    
    float nextAngle=[[self.valueArray_ objectAtIndex:totalSections-1] floatValue]/sum; // in radians
    nextAngle=nextAngle*2.0*pi;
    
    
    
    float currentP=(myAngle+nextAngle)/2;
    currentP=currentP*180/pi; //convert current angle radian to degree
    currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
    
    float diffP=maxP-currentP;
    diffP=diffP/2;
    
    
    maxPForS1=diffP;
    
    
    //Radians which need to be deducted from arc.
    float offsetThetaNew=(360.0 * diffP)/(2*pi*self.radius); //In degree
    offsetThetaNew=offsetThetaNew*pi/180.0;//in radian
    
    
    return offsetThetaNew;
}


-(float)offsetThetaBorderForSection1:(float)maxP :(float)innerRadius :(int)totalSections
{
    
    
    
    float sum=[self returnSum:self.valueArray_];
    float pi=3.1415;
    
    
    float myAngle=[[self.valueArray_ objectAtIndex:0] floatValue]/sum; // in radians
    myAngle=myAngle*2.0*pi;
    
    
    float nextAngle=[[self.valueArray_ objectAtIndex:totalSections-1] floatValue]/sum; // in radians
    nextAngle=nextAngle*2.0*pi;
    
    
    
    
    
    
    float currentP=(myAngle+nextAngle)/2;
    currentP=currentP*180/pi; //convert current angle radian to degree
    currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
    
    float diffP=maxP-currentP;
    diffP=diffP/2;
    diffP=diffP-1;
    
    
    //Radians which need to be deducted from arc.
    float offsetThetaNew=(360.0 * diffP)/(2*pi*self.radius); //In degree
    offsetThetaNew=offsetThetaNew*pi/180.0;//in radian
    
    
    return offsetThetaNew;
}

-(float)findMaxP:(float)sum :(int)totalSections :(float)innerRadius
{
    float pi=3.1415;
    int maxIndex=0;
    float maxValue=[[self.valueArray_ objectAtIndex:0] floatValue];
    
    for(int i=1;i<totalSections;i++)
    {
        float value1=[[self.valueArray_ objectAtIndex:i] floatValue];
        if(maxValue<value1)
        {
            maxValue=value1;
            maxIndex=i;
        }
        
    }
    float value1=[[self.valueArray_ objectAtIndex:maxIndex] floatValue];
    float value2=[[self.valueArray_ objectAtIndex:(maxIndex+1)%totalSections] floatValue];
    
    int m=maxIndex;
    if(maxIndex==0)
        m=totalSections-1;
    
    float value3=[[self.valueArray_ objectAtIndex:m] floatValue];
    
    
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


- (void)drawRect:(CGRect)rect
{
    if(self.animation==TRUE)
        [self StartTimerForAnimatingPieEasingIn];
    else
        self.alpha=1.0;
    
    // Drawing code
    [self findCenter];
    
    
    
    
    
    
    int totalSections=[self.valueArray_ count];
    
    
    
    //Draw the background with the gray Gradient
    self.angleArrays_=[[NSMutableArray alloc]initWithCapacity:totalSections];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Set Background Clear.    
    CGContextSaveGState(context);
    float k=1.0;
    CGRect a=self.frame;
    a.origin.x=0;
    a.origin.y=0;
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
    CGContextAddRect(context, a);
    CGContextFillPath(context);
    CGContextRestoreGState(context);

    
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);

    
    float sum=[self returnSum:self.valueArray_];
    
    //Update the sum of superview
    [(BasicPieChart*)self.superview setSumOfValues:sum];
    

    float innerRadius=0.0;
    
    float constantTheta=[[self.valueArray_ objectAtIndex:0] floatValue]/sum;  
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
        
        float myAngle=[[self.valueArray_ objectAtIndex:i] floatValue]/sum; // in radians
        myAngle=myAngle*2.0*pi;
        
        
        float nextAngle=[[self.valueArray_ objectAtIndex:(i+1)%totalSections] floatValue]/sum; // in radians
        nextAngle=nextAngle*2.0*pi;
        
        
        
        
        
        
        
        float currentP=(myAngle+nextAngle)/2;
        currentP=currentP*180/pi; //convert current angle radian to degree
        currentP=(currentP*2*pi*innerRadius)/360.0;//length  of max p
        
        float diffP=maxP-currentP;
        diffP=diffP/2;
        
        //Radians which need to be deducted from arc.
        offsetThetaNew=(360.0 * diffP)/(2*pi*self.radius); //In degree
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
        newCenterX+=(self.center.x);
        
        float newCenterY=(innerRadius+diffP+PreviousL) * sinf(arcOffset);
        newCenterY+=self.center.y;
        
        //Add starting angle and ending angle
        //in angle array for later comparison
        if(i==0)
            [self.angleArrays_ addObject:[NSNumber numberWithFloat:2*pi -(myAngle/2)]];
        else
            [self.angleArrays_ addObject:[NSNumber numberWithFloat:arcOffset-(myAngle/2)]];
        //NSLog(@"%f",[[self.angleArrays_ lastObject] floatValue]);
        [self.angleArrays_ addObject:[NSNumber numberWithFloat:arcOffset+(myAngle/2)]];
        //NSLog(@"%f",[[self.angleArrays_ lastObject] floatValue]);
        /*************/
        //SECTION COLORS/ GRADIENTS
        /*************/
        
        if(gradientActive)
        {
            
            CGContextSaveGState(context);
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, self.radius-diffP-PreviousL,arcOffset-(myAngle/2)+offsetTheta,arcOffset+(myAngle/2)-offsetThetaNew, 0);
            CGContextClosePath(context); 
            CGContextClip(context); 
            
            
            
            //User may give single as well as multiple gradients.
            if([self.gradientArray_ count]==1)
            {
                //Apply that same single gradient to all the sections
                CGPoint endRadius;
                CGPoint startshine;
                
                if(arcOffset>3.14)
                {
                    endRadius  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2)); ;
                }
                else {
                    startshine  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    endRadius =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2));
                }
                
                
                CGGradientRef myGradient=(__bridge CGGradientRef)[self.gradientArray_ objectAtIndex:0];
                CGContextDrawLinearGradient(context,myGradient , startshine, endRadius, kCGGradientDrawsAfterEndLocation);
                
            }
            else
            {
                
                CGPoint endRadius;
                CGPoint startshine;
                
                if(arcOffset>3.14)
                {
                    endRadius  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2));
                }
                else {
                    startshine  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    endRadius =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2));
                }
                
                
                CGGradientRef myGradient=(__bridge CGGradientRef)[self.gradientArray_ objectAtIndex:i];
                CGContextDrawLinearGradient(context, myGradient, startshine, endRadius, kCGGradientDrawsAfterEndLocation);
                
            }
            
            
            
            
            CGContextRestoreGState(context);
            
            
            
            
            
        }
        else
        {
            
            
            
            
            CGContextMoveToPoint(context, newCenterX, newCenterY);
            CGContextAddArc(context, newCenterX, newCenterY, self.radius-diffP-PreviousL,arcOffset-(myAngle/2)+offsetTheta,arcOffset+(myAngle/2)-offsetThetaNew, 0);
            
            
            UIColor *color;
            if(self.tint==BEIGETINT)
            {
                int totalColors=[MIMColor sizeOfColorArray];
                NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+30)%totalColors];    //i+17 brown tint//30 dark colors(like beige)// // total 43
                float red=[[colorDic valueForKey:@"red"] floatValue];
                float green=[[colorDic valueForKey:@"green"] floatValue];
                float blue=[[colorDic valueForKey:@"blue"] floatValue];
                
                color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
            }
            else if(self.tint ==REDTINT)
            {
                int totalColors=[MIMColor sizeOfColorArray];
                NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+17)%totalColors];
                float red=[[colorDic valueForKey:@"red"] floatValue];
                float green=[[colorDic valueForKey:@"green"] floatValue];
                float blue=[[colorDic valueForKey:@"blue"] floatValue];
                
                color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
            }
            else if(self.tint==GREENTINT)
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
                MIMColorClass *mcolor=[self.colorArray_ objectAtIndex:i];
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
            [myPath addArcWithCenter:CGPointMake(newCenterX, newCenterY) radius:self.radius-diffP-PreviousL startAngle:arcOffset-(myAngle/2)+offsetTheta endAngle:arcOffset+(myAngle/2)-offsetThetaNew clockwise:1];
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
            CGContextAddArc(context, newCenterX, newCenterY, self.radius-diffP-PreviousL-2,arcOffset-(myAngle/2-0.018)+offsetTheta,arcOffset+(myAngle/2-0.018)-offsetThetaNew, 0);
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
                    endRadius  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/4),newCenterY+(self.radius) * sinf(arcOffset-myAngle/4));
                }
                else 
                {
                    endRadius  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset-myAngle/2),newCenterY+(self.radius) * sinf(arcOffset-myAngle/2)); 
                    startshine =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset),newCenterY+(self.radius) * sinf(arcOffset));    
                }
                
            }
            else 
            {
                if(gradientActive)
                {
                    startshine  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/4),newCenterY+(self.radius) * sinf(arcOffset+myAngle/4)); 
                    endRadius =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2));
                }
                else 
                {
                    startshine  = CGPointMake(newCenterX+(self.radius) * cosf(arcOffset),newCenterY+(self.radius) * sinf(arcOffset)); 
                    endRadius =CGPointMake(newCenterX+(self.radius) * cosf(arcOffset+myAngle/2),newCenterY+(self.radius) * sinf(arcOffset+myAngle/2));
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
}



-(void)refreshPie
{
    [self setNeedsDisplay];
    
}


#pragma mark - GESTURE METHODS


/******************************************************************************************************************/
//
//  This methods handles the rotation gesture by user
//  It implements inertia, which makes pie slow down rotation eventually 
//
/******************************************************************************************************************/

-(void)RotationByUser:(id)sender
{
    
    [self HidePreviousPopUp];
    
	if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
		lastRotation_ = 0.0;
		return;
	}
    
	CGFloat rotation = 0.0 - (lastRotation_ - [(UIRotationGestureRecognizer*)sender rotation]);
    
	CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
	[[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
    
	lastRotation_ = [(UIRotationGestureRecognizer*)sender rotation];
}



-(void)TapByUser:(id)sender
{
       
    
    //Find by what angle it has to rotate
    CGPoint touchPointOnSelf=[(UITapGestureRecognizer *)sender locationInView:self];
    float angleToRotateOnSelf=atan2f((touchPointOnSelf.y - self.center.y), (touchPointOnSelf.x -  self.center.x));
    
    
    float currentAngle=angleToRotateOnSelf;
    if(currentAngle<0)
        currentAngle=2*pi + currentAngle;
    

    
    //Find which index piece of pie has been touched
    for (int i=0; i<[self.angleArrays_ count]; i+=2) {

        float range1=[[self.angleArrays_ objectAtIndex:i] floatValue];
        float range2=[[self.angleArrays_ objectAtIndex:i+1] floatValue];;
      
        
        //NSLog(@"prospective currentAngle = %f",currentAngle);
        if(currentAngle >= range1 && currentAngle< range2 && i>0)
        {
            indexTapped=i/2;
            //NSLog(@"currentAngle = %f : Print angle found at i=%i",currentAngle,i/2);
            break;
        }
        else if(((currentAngle >= range1 && currentAngle<=2*pi)||(currentAngle>= 0  && currentAngle< range2)) && i==0)
        {
            indexTapped=i/2;
            //NSLog(@"currentAngle = %f : Print angle found at i=%i",currentAngle,i/2);
            break;
        }
 
        
        
    }
    

    if(enableBubbleBox)
    {
        //Just Find the point on circle's circumference.
        float range1=[[self.angleArrays_ objectAtIndex:2*indexTapped] floatValue];
        float range2=[[self.angleArrays_ objectAtIndex:2*indexTapped+1] floatValue];;
        
        float theta=range1+range2;
        int quadrant=1;
        if(indexTapped==0)
            theta=0;
        else
        {
            theta=theta/2;
            
            if((theta>0)&&(theta<1.57))
                quadrant=1;
            else if((theta>=1.57)&&(theta<3.14))
                quadrant=2;
            else if((theta>=3.14)&&(theta<4.71))
                quadrant=3;
            else if((theta>=4.71)&&(theta<6.28))
                quadrant=4;
            
        }
        

        
        
        [(BasicPieChart *)self.superview showBubbleAtPoint:CGPointMake(center.x+radius*cosf(theta), center.y+radius*sinf(theta)) AtIndex:indexTapped inQuadrant:quadrant];
        return;
    }

    
    
    if(enableDoubleTap)
    {
        
        //It will rotate and
        //tells info box to translate values
        [self rotatePieToIndex:indexTapped whichDirection:1];
        [(BasicPieChart *)self.superview setOffsetOfInfoBoxStyleToIndex:indexTapped];
    }
    else
    {
        //It will rotate
        //and display detail Popup   
    
        CGPoint touchPoint=[(UITapGestureRecognizer *)sender locationInView:[self superview]];
        float angleToRotate=atan2f((touchPoint.y - self.center.y), (touchPoint.x -  self.center.x));
        

        if(afterTappingWhichDirectionToRotate==1)
            angleToRotate=angleToRotate;
        else if(afterTappingWhichDirectionToRotate==2)
            angleToRotate=3.14+angleToRotate;
        else if(afterTappingWhichDirectionToRotate==3)
            angleToRotate=-(1.57-angleToRotate);
        else if(afterTappingWhichDirectionToRotate==4)
            angleToRotate=1.57+angleToRotate;
        
        
        CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,-angleToRotate);
        
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
        [UIView commitAnimations];
    
    
        
             
        [self HidePreviousPopUp];
        [self performSelector:@selector(callParentViewToDisplayPopUp) withObject:nil afterDelay:1.0];
    
        netRotation_+=angleToRotate;

        
    }
  
    
}


-(void)DTapByUser:(id)sender
{
    
    //Find by what angle it has to rotate
    CGPoint touchPointOnSelf=[(UITapGestureRecognizer *)sender locationInView:self];
    float angleToRotateOnSelf=atan2f((touchPointOnSelf.y - self.center.y), (touchPointOnSelf.x -  self.center.x));
    
    
    float currentAngle=angleToRotateOnSelf;
    if(currentAngle<0)
        currentAngle=2*pi + currentAngle;
    
    //NSLog(@"angleToRotate=%f",angleToRotate);
    
    //Find which piece of pie has been touched
    for (int i=0; i<[self.angleArrays_ count]; i+=2) {
        
        float range1=[[self.angleArrays_ objectAtIndex:i] floatValue];
        float range2=[[self.angleArrays_ objectAtIndex:i+1] floatValue];;
        
        
        //NSLog(@"prospective currentAngle = %f",currentAngle);
        if(currentAngle >= range1 && currentAngle< range2 && i>0)
        {
            indexTapped=i/2;
            //NSLog(@"currentAngle = %f : Print angle found at i=%i",currentAngle,i/2);
            break;
        }
        else if(((currentAngle >= range1 && currentAngle<=2*pi)||(currentAngle>= 0  && currentAngle< range2)) && i==0)
        {
            indexTapped=i/2;
            //NSLog(@"currentAngle = %f : Print angle found at i=%i",currentAngle,i/2);
            break;
        }
        
        
        
    }
    
    CGPoint touchPoint=[(UITapGestureRecognizer *)sender locationInView:[self superview]];
    float angleToRotate=atan2f((touchPoint.y - self.center.y), (touchPoint.x -  self.center.x));
    
    if(afterTappingWhichDirectionToRotate==1)
        angleToRotate=angleToRotate;
    else if(afterTappingWhichDirectionToRotate==2)
        angleToRotate=3.14+angleToRotate;
    else if(afterTappingWhichDirectionToRotate==3)
        angleToRotate=-(1.57-angleToRotate);
    else if(afterTappingWhichDirectionToRotate==4)
        angleToRotate=1.57+angleToRotate;
    
    
    
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
	CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,-angleToRotate);
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
    [UIView commitAnimations];
    
    [self HidePreviousPopUp];
    [self performSelector:@selector(callParentViewToDisplayPopUp) withObject:nil afterDelay:1.0];
    
    
    netRotation_+=angleToRotate;
    
}


-(void)bouncyEffectOnPie
{
    self.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:1.0], nil];
    bounceAnimation.duration = 0.5;
    bounceAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:bounceAnimation forKey:@"bounce"];
    self.layer.transform = CATransform3DIdentity;
    

}

-(void)HidePreviousPopUp
{
    [(BasicPieChart *)self.superview hideThePopOver];
}


-(void)callParentViewToDisplayPopUp
{
    //[self bouncyEffectOnPie];
    [(BasicPieChart *)self.superview displayThePopOver:indexTapped];
}


#pragma mark - Info Box Methods

//When user touches info box label, it translates to the middle.
//Pie should also rotate such that the corresponding pie section
//faces that box label.
-(void)rotatePieToIndex:(int)index whichDirection:(int)direction
{
    
    int comp2pi=netRotation_/6.28;
    float mentissa=netRotation_-(comp2pi * 6.28);
    
    
    float range1=[[self.angleArrays_ objectAtIndex:2*index] floatValue];
    float range2=[[self.angleArrays_ objectAtIndex:2*index+1] floatValue];;
    
    
    float angleToRotate=range1+range2;
    
    if(index==0)
        angleToRotate=0;
    else
        angleToRotate=angleToRotate/2;
    
    
    angleToRotate=angleToRotate-mentissa;
    

    
    CGAffineTransform currentTransform = self.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,-angleToRotate);
    

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[self setTransform:newTransform];
    [UIView commitAnimations];
    
    
    netRotation_+=angleToRotate;


}

-(int)getQuadrantAtIndex:(int)index
{

    
    //Just Find the point on circle's circumference.
    float range1=[[self.angleArrays_ objectAtIndex:2*index] floatValue];
    float range2=[[self.angleArrays_ objectAtIndex:2*index+1] floatValue];;
    
    float theta=range1+range2;
    int quadrant=1;
    if(index==0)
        theta=0;
    else
    {
        theta=theta/2;
        
        if((theta>0)&&(theta<1.57))
            quadrant=1;
        else if((theta>=1.57)&&(theta<3.14))
            quadrant=2;
        else if((theta>=3.14)&&(theta<4.71))
            quadrant=3;
        else if((theta>=4.71)&&(theta<6.28))
            quadrant=4;
        
    }
    
    return quadrant;
    
}

-(CGPoint)getPointAtIndex:(int)index
{
    //Just Find the point on circle's circumference.
    float range1=[[self.angleArrays_ objectAtIndex:2*index] floatValue];
    float range2=[[self.angleArrays_ objectAtIndex:2*index+1] floatValue];;
    
    float theta=range1+range2;

    if(index==0)
        theta=0;
    else
        theta=theta/2;
      
    return CGPointMake(center.x+radius*cosf(theta), center.y+radius*sinf(theta));
    
}

-(float)getSum
{
    return Msum;
}

@end
