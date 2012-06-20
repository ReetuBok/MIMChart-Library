//
//  PieBubble.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PieBubble.h"

@implementation PieBubble

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        bubbleStyle=0;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    
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

    float w=CGRectGetWidth(self.frame)/2;
    float ox=w*2*0.2; 
    float s=w*2*0.8;
    
    switch (bubbleStyle) 
    {
        case mPIE_BUBBLE_STYLE1:
        {
            CGContextSaveGState(context);
            float k=0.6;
            
            if(quadrant_==4)
            {
            
                //Line
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor); 
                CGContextSetLineWidth(context, 2);
                CGContextMoveToPoint(context, w+w/2, w/4);
                CGContextAddLineToPoint(context, 0, 2*w);
                CGContextStrokePath(context);
                
                //Grey Background
                CGRect a=CGRectMake(ox,0,s,s);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                //White Foreground
                k=1;
                a=CGRectMake(ox+2,2,s-4,s-4);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                //Create the Label
                UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(ox+2,2,s-4,s-4)];
                [textLabel setBackgroundColor:[UIColor clearColor]];
                [textLabel setText:bubbleString];
                [textLabel setTextAlignment:UITextAlignmentCenter];
                [textLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:11]];
                [textLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
                [self addSubview:textLabel];
            }
            else if(quadrant_==1)
            {
                //Line
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor); 
                CGContextSetLineWidth(context, 2);
                CGContextMoveToPoint(context, w+w/2,w+w/2);
                CGContextAddLineToPoint(context, 0, 0);
                CGContextStrokePath(context);
                
                //Grey Background
                CGRect a=CGRectMake(ox,ox,s,s);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
               
                
                //White Foreground
                k=1;
                a=CGRectMake(ox+2,ox+2,s-4,s-4);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                //Create the Label
                UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(ox+2,ox+2,s-4,s-4)];
                [textLabel setBackgroundColor:[UIColor clearColor]];
                [textLabel setText:bubbleString];
                [textLabel setTextAlignment:UITextAlignmentCenter];
                [textLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:11]];
                [textLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
                [self addSubview:textLabel];
                
            }
            else if(quadrant_==2)
            {
                //Line
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor); 
                CGContextSetLineWidth(context, 2);
                CGContextMoveToPoint(context, w/4,w+w/2);
                CGContextAddLineToPoint(context, 2*w, 0);
                CGContextStrokePath(context);
                
                //Grey Background
                CGRect a=CGRectMake(0,ox,s,s);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                
                //White Foreground
                k=1;
                a=CGRectMake(2,ox+2,s-4,s-4);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                //Create the Label
                UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(2,ox+2,s-4,s-4)];
                [textLabel setBackgroundColor:[UIColor clearColor]];
                [textLabel setText:bubbleString];
                [textLabel setTextAlignment:UITextAlignmentCenter];
                [textLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:11]];
                [textLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
                [self addSubview:textLabel];
                
            }
            else if(quadrant_==3)
            {
                //Line
                CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor); 
                CGContextSetLineWidth(context, 2);
                CGContextMoveToPoint(context, w/4,w/4);
                CGContextAddLineToPoint(context, 2*w, 2*w);
                CGContextStrokePath(context);
                
                
                //Grey Background
                CGRect a=CGRectMake(0,0,s,s);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                

          
                //White Foreground
                k=1;
                a=CGRectMake(2,2,s-4,s-4);
                CGContextSetFillColorWithColor(context, [UIColor colorWithRed:k green:k blue:k alpha:1.0].CGColor);    
                CGContextAddEllipseInRect(context, a);
                CGContextFillPath(context);
                
                
                
                //Create the Label
                UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(2,2,s-4,s-4)];
                [textLabel setBackgroundColor:[UIColor clearColor]];
                [textLabel setText:bubbleString];
                [textLabel setTextAlignment:UITextAlignmentCenter];
                [textLabel setFont:[UIFont fontWithName:@"TrebuchetMS" size:11]];
                [textLabel setTextColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]];
                [self addSubview:textLabel];
                
            }
            
            CGContextRestoreGState(context);
            
            

        }
        break;
            
        default:
            break;
    }
    

   
    
}

-(void)DrawBubbleWithStyle:(PIE_BUBBLE_STYLE)style withText:(NSString *)text inQuadrant:(int)quadrant
{
    bubbleStyle=style;
    bubbleString=[[NSString alloc]initWithString:text];
    quadrant_=quadrant;
    [self setNeedsDisplay];
}
@end
