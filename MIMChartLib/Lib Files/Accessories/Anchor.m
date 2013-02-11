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
//  Anchor.m
//  MIM2D Library
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "Anchor.h"
#import <QuartzCore/QuartzCore.h>

#define DIM 20.0
@implementation Anchor
@synthesize delegate,anchorTag,properties;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        
        
    }
    return self;
}

-(void)addGestures
{
    if([properties valueForKey:@"touchenabled"])
    if([[properties valueForKey:@"touchenabled"] boolValue])
    {
        if(!tapGesture)
        {
            tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnchor:)];
            [self addGestureRecognizer:tapGesture];
        }
        
    }
}

-(void)drawAnchor
{
    [self addGestures];
    [self setNeedsDisplay];
   
}

//pending
//highlightOn - highlights when tapped on it. highlight color, hightlight shadowColor, highlight bordercolor. 
//moving up and down the anchor.

- (void)drawRect:(CGRect)rect
{
    if([[properties allKeys] count]==0)return;
    
    int style=[[properties valueForKey:@"style"] intValue];

    float radius=7;
    if([properties valueForKey:@"radius"])
        radius=[[properties valueForKey:@"radius"] floatValue];

    if(radius>10)
        NSLog(@"WARNING:RADIUS > 10 may  get truncated on sides..");
    

    //Create clear background
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddRect(context, CGRectMake(0, 0, 20, 20));      
    CGContextFillPath(context);
    
    
    
    
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);
     
    float shadowRadius=2.0;
    if([properties valueForKey:@"shadowRadius"])
        shadowRadius=[[properties valueForKey:@"shadowRadius"] floatValue];

    CGSize shadowSize=CGSizeMake(1.0,1.0);
    if([properties valueForKey:@"shadowSize"])
        shadowSize=[[properties valueForKey:@"shadowSize"] CGSizeValue];
    
    UIColor *shadowColor=[UIColor blackColor];
    if([properties valueForKey:@"shadowColor"])
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:[properties valueForKey:@"shadowColor"]];
        shadowColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    }
    
    BOOL shadowOn=TRUE;
    if([properties valueForKey:@"hideShadow"])
    {
        if([[properties valueForKey:@"hideShadow"] boolValue])
            shadowOn=FALSE;
        else 
            CGContextSetShadowWithColor(context, shadowSize, shadowRadius, shadowColor.CGColor);
    }
    else CGContextSetShadowWithColor(context, shadowSize, shadowRadius, shadowColor.CGColor);
    
    
   


    UIColor *emptyColor=[UIColor whiteColor];
    
    
    UIColor *fillColor=[UIColor whiteColor];
    if([properties valueForKey:@"fillColor"])
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:[properties valueForKey:@"fillColor"]];
        fillColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];

    }
    
    
    UIColor *borderColor=[UIColor blackColor];
    if([properties valueForKey:@"borderColor"])
    {
        MIMColorClass *c=[MIMColorClass colorWithComponent:[properties valueForKey:@"borderColor"]];
        borderColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    }
    
//    float borderWidth=0.4;
//    if([properties valueForKey:@"borderWidth"])
//        borderWidth=[[properties valueForKey:@"borderWidth"] floatValue];
//    
    float borderWidth=0.8;

    CGRect r;
    
    r=CGRectMake(1 + ((DIM - 2*radius - 2)/2), 1 + ((DIM - 2*radius-2)/2), 2*radius - 2,  2*radius-2);    
    
    switch (style) 
    {
        case CIRCLE:
        case DEFAULT:
        {
            

            //Fill Background
            CGContextSetFillColorWithColor(context, emptyColor.CGColor);
            CGContextAddEllipseInRect(context, r);  
            CGContextFillPath(context);
            
            //Stroke Border
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
            CGContextAddEllipseInRect(context, r);  
            CGContextStrokePath(context);
        
        }
            break;
        case CIRCLEFILLED:
        case 0:
        {
            CGContextSetFillColorWithColor(context, fillColor.CGColor);
            CGContextAddEllipseInRect(context, r);  
            CGContextFillPath(context);
            
        }
            break;
        case SQUAREFILLED:
        {
            CGContextSetFillColorWithColor(context, fillColor.CGColor);
            CGContextAddRect(context, r);  
            CGContextFillPath(context);
            
        }
            break;
        case SQUARE:
        {
            CGContextSetAllowsAntialiasing(context, NO);
            CGContextSetShouldAntialias(context, NO);
            
    
            
            
            //Fill Background
            CGContextSetFillColorWithColor(context, emptyColor.CGColor);
            CGContextAddRect(context, r);  
            CGContextFillPath(context);
            
            
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, fillColor.CGColor);
            CGContextAddRect(context, r);  
            CGContextStrokePath(context);
            
        }
            break;
        case SQUAREBORDER:
        {
            
            //Fill Background
            CGContextSetFillColorWithColor(context, fillColor.CGColor);
            CGContextAddRect(context, r);  
            CGContextFillPath(context);
            
            
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextAddRect(context, r);  
            CGContextStrokePath(context);
            
        }
            break;
        case CIRCLEBORDER:
        {
            
            //Fill Background
            CGContextSetFillColorWithColor(context, fillColor.CGColor);
            CGContextAddEllipseInRect(context, r);  
            CGContextFillPath(context);
            
            //Stroke Border
            CGContextSetLineWidth(context, borderWidth);
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextAddEllipseInRect(context, r);  
            CGContextStrokePath(context);
            
        }
            break;
        case NONE:
        {
            /*
            CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 3.0, [UIColor blackColor].CGColor);
            CGContextSetLineWidth(context, 2.0);
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, CGRectMake(7, 7, 5, 5));      
            CGContextStrokePath(context);
             */
        
        }
            break;
    
    }

    
    
    
    
    
    if([[properties valueForKey:@"drawhighlight"] boolValue])
    {
    
        CGContextSetBlendMode(context,kCGBlendModeNormal);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextAddRect(context, CGRectMake(7, 7, 5, 5));      
        CGContextFillPath(context);
    
    }
}


- (void)tapAnchor:(UIPanGestureRecognizer *)gestureRecognizer
{
    //Send back to its delegate along with its tagID
    [delegate displayAnchorInfo:self.anchorTag At:CGPointMake(self.center.x, self.center.y)];
    
   
}
#define POPINOVERSHOOTPERCENTAGE 0.3
-(void)createPopOutAnimation
{

    CGSize c=self.frame.size;
    CAKeyframeAnimation *boundsOvershootAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds.size"];
    CGSize startingSize = CGSizeZero;
    CGSize overshootSize = CGSizeMake(c.width * (1.0f + POPINOVERSHOOTPERCENTAGE), c.height * (1.0f + POPINOVERSHOOTPERCENTAGE));
    CGSize undershootSize = CGSizeMake(c.width * (1.0f - POPINOVERSHOOTPERCENTAGE), c.height * (1.0f - POPINOVERSHOOTPERCENTAGE));
    
    
    NSArray *boundsValues = [NSArray arrayWithObjects:[NSValue valueWithCGSize:startingSize],
                             [NSValue valueWithCGSize:overshootSize],
                             [NSValue valueWithCGSize:undershootSize],
                             [NSValue valueWithCGSize:c], nil];
    [boundsOvershootAnimation setValues:boundsValues];
    
    NSArray *times = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
                      [NSNumber numberWithFloat:0.5f*2],
                      [NSNumber numberWithFloat:0.9f*2],
                      [NSNumber numberWithFloat:1.0f*2], nil];    
    [boundsOvershootAnimation setKeyTimes:times];
    
    
    NSArray *timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], 
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                nil];
    [boundsOvershootAnimation setTimingFunctions:timingFunctions];
    boundsOvershootAnimation.fillMode = kCAFillModeForwards;
    boundsOvershootAnimation.removedOnCompletion = NO;
    
    [self.layer addAnimation:boundsOvershootAnimation forKey:@"bounds.size"];

}
-(void)createBounceAnimation
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.3],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.7],
                           nil];    
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 0.7;
    
    [self.layer addAnimation:animation forKey:@"popup"];

    
}
- (void)dealloc
{
    //[self removeGestureRecognizer:tapGesture];
}

@end
