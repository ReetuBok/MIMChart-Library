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
#import "AnchorInfo.h"


@implementation Anchor
@synthesize delegate,idTag,highlightOn,moveOn,color,type;
@synthesize enabled,isShadow;

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
    if(enabled)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnchor:)];
        [self addGestureRecognizer:tapGesture];
        
    }
}

-(void)drawAnchor
{
    
    [self setNeedsDisplay];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(color==nil)
        return;
    
    [self addGestures];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 20.0);
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, CGRectMake(0, 0, 20, 20));      
    CGContextStrokePath(context);
    
    if(isShadow)
        CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 1.5, [UIColor blackColor].CGColor);
    
    switch (type) 
    {
        case CIRCLEBORDER:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);

            //Fill it with white circle
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddEllipseInRect(context, CGRectMake(7, 7, 7, 7));  
            CGContextFillPath(context);
            
            
            CGContextSetLineWidth(context, 1.0);
   
            CGContextSetStrokeColorWithColor(context, color.CGColor);
    
            
            CGContextAddEllipseInRect(context, CGRectMake(7, 7, 7, 7));      
            CGContextStrokePath(context);
        
        }
            break;
        case CIRCLEFILLED:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            



                CGContextSetFillColorWithColor(context, color.CGColor);
            
            CGContextAddEllipseInRect(context, CGRectMake(7, 7, 7, 7));      
            CGContextFillPath(context);
            
        }
            break;
        case SQUAREFILLED:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            
            
            

            CGContextSetFillColorWithColor(context, color.CGColor);
           
            
            CGContextAddRect(context, CGRectMake(7, 7, 7, 7));      
            CGContextFillPath(context);
            
        }
            break;
        case SQUAREBORDER:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            
            //Fill it with white circle
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, CGRectMake(7, 7, 7, 7));  
            CGContextFillPath(context);
            
            
            CGContextSetLineWidth(context, 1.0);
            
            CGContextSetStrokeColorWithColor(context, color.CGColor);
            
            
            CGContextAddRect(context, CGRectMake(7, 7, 7, 7));      
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
        default:
        {
            CGContextSetShadowWithColor(context, CGSizeMake(1.0,1.0), 3.0, [UIColor blackColor].CGColor);
            CGContextSetLineWidth(context, 2.0);
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, CGRectMake(7, 7, 5, 5));      
            CGContextStrokePath(context);
            
        }
            break;
    }

    
    
    
    
    
    if(highlightOn){
    
        CGContextSetBlendMode(context,kCGBlendModeNormal);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextAddRect(context, CGRectMake(7, 7, 5, 5));      
        CGContextFillPath(context);
    
    }
}


- (void)tapAnchor:(UIPanGestureRecognizer *)gestureRecognizer
{
    //Send back to its delegate along with its tagID
    [delegate displayAnchorInfo:self.idTag At:CGPointMake(self.center.x, self.center.y)];
    
   
}

- (void)dealloc
{
    
}

@end
