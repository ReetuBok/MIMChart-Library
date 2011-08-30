/*
 Copyright (C) 2011  Reetu Raj (reetu.raj@gmail.com)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *///
//  2DFragmentedDoughNut.m
//  MIM3D
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "2DFragmentedDoughNut.h"


@implementation _DFragmentedDoughNut
@synthesize valuesArray,tint,titleArray,center,isShadow;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];

    }
    return self;
}

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
        CGContextSetShadow(context, CGSizeMake(2.0, -2.0), 1.0);
    
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
        
        
   // CGContextSaveGState(context);
        
    //CGContextSetShadowWithColor(context, CGSizeMake(-2.0, 2.0), 5.0, [UIColor blackColor].CGColor);



    CGContextSetFillColorWithColor( context, [[UIColor alloc]initWithRed:0.16 green:0.17 blue:0.17 alpha:1.0].CGColor );
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGRect holeRect= CGRectMake(center.x - innerRadius/2 , center.y - innerRadius/2, innerRadius, innerRadius);
    CGContextFillEllipseInRect( context, holeRect );

        
      //  CGContextRestoreGState(context);
 
    
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

- (void)dealloc
{
    [super dealloc];
}

@end
