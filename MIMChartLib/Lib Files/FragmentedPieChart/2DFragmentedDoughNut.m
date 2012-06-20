/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
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
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  2DFragmentedDoughNut.m
//  MIM2D Library
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "2DFragmentedDoughNut.h"

@interface _DFragmentedDoughNut () 
-(void)setOutRadius:(float)ORadius AndInnerRadius:(float)IRadius;
@end

@implementation _DFragmentedDoughNut
@synthesize tint,center,isShadow;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        
        if([MIMColor sizeOfColorArray]==0)
            [MIMColor InitColors];
        
    }
    return self;
}



-(void)drawDoughNut
{
    //This will call all delegates
    float innerR_;
    float outerR_;
    if([delegate respondsToSelector:@selector(innerRadiusForDoughNut:)])
    {
        innerR_=[delegate innerRadiusForDoughNut:self];
        NSAssert((innerR_ !=0),@"WARNING::Inner Radius is 0.");
    }
    else
    {
        NSLog(@"Warning:Set Inner Radius.Use delegate Method innerRadiusForDoughNut: ");
        return;
    }
    
    
    
    if([delegate respondsToSelector:@selector(outerRadiusForDoughNut:)])
    {
        outerR_=[delegate outerRadiusForDoughNut:self];
        NSAssert((outerR_ !=0),@"WARNING::Outer Radius is 0.");
    }
    else
    {
        NSLog(@"Warning:Set Outer Radius.Use delegate Method outerRadiusForDoughNut: ");
        return;
    }
    
    
    
    if([delegate respondsToSelector:@selector(valuesForDoughNut:)])
    {
        valuesArray=[delegate valuesForDoughNut:self];
        NSAssert(([valuesArray count] !=0),@"WARNING::No Values to draw DoughNut.");
    }
    else
    {
        NSLog(@"Warning:No Values to draw DoughNut.Use delegate Method valuesForDoughNut: ");
        return;
    }
    
    
    
    if([delegate respondsToSelector:@selector(titlesForDoughNut:)])
    {
        titleArray=[delegate titlesForDoughNut:self];
    }
    else
    {
        NSLog(@"Warning:No Values for titles in DoughNut.Use delegate Method titlesForDoughNut: ");
        return;
    }
    
    
    [self setOutRadius:outerR_ AndInnerRadius:innerR_];
    
    
 
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    //Draw the background as grey gradient.
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Draw the background with the gray Gradient
    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
    
    
    CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
    CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.9, 0.9, 0.9 , 1.0,  // Start color
        0.75, 0.75, 0.75 , 1.0 }; // Mid color and End color
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    
    CGPoint startBg = CGPointMake(_viewWidth/2,_viewHeight/2); 
    CGFloat endRadius=MAX(_viewWidth/2, _viewHeight/2);
    
    
    CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    
    
   
    
    int c=[valuesArray count];
    
    CGFloat angleArray[c];
    CGFloat offset=0;
    int sum=0;
    
        
   
        
        
        
    
  
        
        
        
    //Draw the background with the gray Gradient
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    if(isShadow)
        CGContextSetShadow(context, CGSizeMake(1.0, -1.0), 4.0);
    
    for(int i=0;i<[valuesArray count];i++)
    {
        
        sum+=[[valuesArray objectAtIndex:i] intValue];
    }

        
        
    int totalColors=[MIMColor sizeOfColorArray];
    
    int tintOffset;
    if(tint==REDTINT)
        tintOffset=17;
    if(tint==GREENTINT)
        tintOffset=0;
    if(tint==BEIGETINT)
        tintOffset=30;
    
    for(int i=0;i<[valuesArray count];i++)
    {
        
        angleArray[i]=(float)(([[valuesArray objectAtIndex:i] intValue])/(float)sum)*(2*3.14); // in radians
        
        
        CGContextMoveToPoint(context, center.x,center.y);
        CGContextAddArc(context, center.x,center.y, outerRadius,offset,offset+angleArray[i], 0);
        offset+=angleArray[i];
        
        
        NSDictionary *colorDic=[MIMColor GetColorAtIndex:(i+tintOffset)%totalColors];    
        float red=[[colorDic valueForKey:@"red"] floatValue];
        float green=[[colorDic valueForKey:@"green"] floatValue];
        float blue=[[colorDic valueForKey:@"blue"] floatValue];
        UIColor *color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.8];    
        
        
        CGContextSetFillColorWithColor(context, color.CGColor);

        CGContextClosePath(context); 
        CGContextFillPath(context);
        
        
        [self drawTitles:angleArray[i] WithRotation:offset-angleArray[i]/2 WithOffset:offset WithTitle:[titleArray objectAtIndex:i]];
        
        
        
    }
        
        
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor( context, [[UIColor alloc]initWithRed:0.16 green:0.17 blue:0.17 alpha:1.0].CGColor );
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGRect holeRect= CGRectMake(center.x - innerRadius, center.y - innerRadius, innerRadius*2, innerRadius*2);
    CGContextFillEllipseInRect( context, holeRect );
    CGContextRestoreGState(context);
 
    
}


-(void)drawTitles:(CGFloat)val WithRotation:(CGFloat)angle  WithOffset:(CGFloat)offset WithTitle:(NSString *)titleVal
{

    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
    //Create the title
    DoughtNutFragmentTitle *titleView=[[DoughtNutFragmentTitle alloc]initWithFrame:CGRectMake((_viewWidth-160)/2,_viewHeight/2, 160, 40)];
    titleView.rotationAngle=angle;
    titleView.title=[NSString stringWithFormat:@"%.0f%@\n%@",(val * 100 )/(2*3.14),@" %",titleVal];
    [titleView draw];
    [self addSubview:titleView];
}

-(void)displayCloseButton
{
    UIButton *closeButton=[UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame=CGRectMake(CGRectGetMaxX(self.frame)-32, 20, 32, 32);
    [closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
}

-(IBAction)closeButtonClicked:(id)sender
{
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"displayLabels" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reformDoughtNutShapeBack" object:nil];
   
}


#pragma mark - PRIVATE METHODS
-(void)setOutRadius:(float)ORadius AndInnerRadius:(float)IRadius
{
    
    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
    center.x=_viewWidth/2;
    center.y=_viewHeight/2;
    
    outerRadius=ORadius;
    innerRadius=IRadius;
    
    [self setNeedsDisplay];

}



- (void)dealloc
{
    ////[super dealloc];
}

@end
