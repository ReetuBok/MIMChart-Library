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
//  Anchor.m
//  MIM3D
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Anchor.h"
#import "AnchorInfo.h"


@implementation Anchor
@synthesize delegate,idTag,originalPoint,highlightOn,moveOn,color,type;
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
        [tapGesture release];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
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
            if(color)
            CGContextSetStrokeColorWithColor(context, color.CGColor);
            else
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            
            CGContextAddEllipseInRect(context, CGRectMake(7, 7, 7, 7));      
            CGContextStrokePath(context);
        
        }
            break;
        case CIRCLEFILLED:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            


            if(color)
                CGContextSetFillColorWithColor(context, color.CGColor);
            else
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            
            CGContextAddEllipseInRect(context, CGRectMake(7, 7, 7, 7));      
            CGContextFillPath(context);
            
        }
            break;
        case SQUAREFILLED:
        {
            CGContextSetBlendMode(context,kCGBlendModeNormal);
            
            
            
            if(color)
                CGContextSetFillColorWithColor(context, color.CGColor);
            else
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            
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
            if(color)
                CGContextSetStrokeColorWithColor(context, color.CGColor);
            else
                CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            
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
    [super dealloc];
}

@end
