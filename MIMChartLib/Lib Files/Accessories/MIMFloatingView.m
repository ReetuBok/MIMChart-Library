//
//  MIMFloatingView.m
//  MIMChartLib
//
//  Created by Mac Mac on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMFloatingView.h"

@implementation MIMFloatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    /*
    float width=CGRectGetWidth(rect);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);
    
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
    
    
    //CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:1.0 alpha:1].CGColor);
    CGContextAddRect(ctx, CGRectMake(0, 0, width, CGRectGetHeight(rect)));      
    CGContextFillPath(ctx);
    
//    
//    CGContextSetBlendMode(ctx,kCGBlendModeNormal);
//    CGContextSetFillColorWithColor(ctx, mBackgroundColor.CGColor);
//    CGContextAddRect(ctx, CGRectMake(0, 0, width, 15.0));      
//    CGContextFillPath(ctx);
     */
}

-(void)setLabelsOnView:(NSString *)title subtitle:(NSString *)subtitle
{
    UILabel *title_=[[UILabel alloc]initWithFrame:CGRectMake(5, 2, CGRectGetWidth(self.frame), 20)];
    [title_ setBackgroundColor:[UIColor clearColor]];
    [title_ setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [title_ setText:title];
    [title_ setTextColor:[UIColor blackColor]];
    
    [self addSubview:title_];
    
    
    UILabel *subtitle_=[[UILabel alloc]initWithFrame:CGRectMake(5, 22, CGRectGetWidth(self.frame), 20)];
    [subtitle_ setBackgroundColor:[UIColor clearColor]];
    [subtitle_ setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    [subtitle_ setText:subtitle];
    [subtitle_ setTextColor:[UIColor blackColor]];
    
    [self addSubview:subtitle_];
    
}


@end
