//
//  DetailPopOverStyle2.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailPopOverStyle2.h"




@implementation DetailPopOverStyle2
@synthesize detailPopUpType;
@synthesize roundedCorner;
@synthesize arrowDirection;
@synthesize  ptitle;
@synthesize  icon;
@synthesize  summary;
@synthesize  detail;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
  
    //clear behind arrow
    CGContextSaveGState(context);
    CGContextBeginPath(context);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
    CGContextFillRect(context, CGRectMake(0, 0,CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    CGContextRestoreGState(context);
    
   
    
    
    //Arrow
    if(arrowDirection==DIRECTION_RIGHT)
    {
        rrect = CGRectMake(0, 0, CGRectGetWidth(self.frame)-14, CGRectGetHeight(self.frame));

        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)-15, CGRectGetHeight(self.frame)/2-13);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)-15, CGRectGetHeight(self.frame)/2+13);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextDrawPath(context,kCGPathFill);
        CGContextRestoreGState(context);
        
    }
    else if(arrowDirection==DIRECTION_TOP)
    {
        rrect = CGRectMake(0, 14, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-14);

        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetWidth(self.frame)/2, 0);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)/2-13, 14);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)/2+13, 14);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextDrawPath(context,kCGPathFill);
        CGContextRestoreGState(context);
        
    }
    else if(arrowDirection==DIRECTION_BOTTOM)
    {
        rrect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-14);

        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)/2-13, CGRectGetHeight(self.frame)-14);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame)/2+13, CGRectGetHeight(self.frame)-14);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextDrawPath(context,kCGPathFill);
        CGContextRestoreGState(context);
        
        
    }
    else
    {
        rrect = CGRectMake(14, 0, CGRectGetWidth(self.frame)-14, CGRectGetHeight(self.frame));

        
        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame)/2);
        CGContextAddLineToPoint(context, 15, CGRectGetHeight(self.frame)/2-13);
        CGContextAddLineToPoint(context, 15, CGRectGetHeight(self.frame)/2+13);
        CGContextClosePath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextDrawPath(context,kCGPathFill);
        CGContextRestoreGState(context);
    
    }
    
    //Background White
    if(roundedCorner)
    {
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        
        CGFloat radius = 10.0; 
        CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect); 
        CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect); 
        // Start at 1 
        CGContextMoveToPoint(context, minx, midy); 
        // Add an arc through 2 to 3 
        CGContextAddArcToPoint(context, minx, miny, midx, miny, radius); 
        // Add an arc through 4 to 5 
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius); 
        // Add an arc through 6 to 7 
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius); 
        // Add an arc through 8 to 9 
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius); 
        // Close the path 
        CGContextClosePath(context); 
        // Fill & stroke the path 
        CGContextDrawPath(context, kCGPathFillStroke); 
        
        CGContextRestoreGState(context);
        
        
    }
    else
    {
        
        //white bg
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor);    
        CGContextFillRect(context, rrect);
        CGContextRestoreGState(context);
    }
    
    
    
    
    UIGraphicsPopContext();

    //Gradient behind the textbox
    
    if(roundedCorner)
    {
        CGRect a=gRect;
        a.size.height+=44;
        gRect=a;
        
        CGContextSaveGState(context);
        CGContextAddRect(context, gRect);
        CGContextClip(context); 
        

        CGFloat shineLocations[2] = { 0.0, 1.0 };
        CGFloat shineComponents[8] = { 0.6, 0.6, 0.6 , 0.0,  // Start color
            1.0, 1.0, 1.0 , 1.0 }; // Mid color and End color
        CGColorSpaceRef shineRGBColorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef shineLinearGradient = CGGradientCreateWithColorComponents(shineRGBColorspace, shineComponents, shineLocations, 2);
        
        CGPoint endP=CGPointMake(100, 0);
        CGPoint startP=CGPointMake(100, gRect.size.height-4);
        
        CGContextDrawLinearGradient(context, shineLinearGradient, startP, endP, kCGGradientDrawsAfterEndLocation);
        CGColorSpaceRelease(shineRGBColorspace);
        CGGradientRelease(shineLinearGradient);
        
        
        CGContextRestoreGState(context);
        
        
    }
    else
        bgView.frame=gRect;
 
    
    
    
}


-(void)createTheView
{
    if(arrowDirection==DIRECTION_RIGHT)
    {
        gRect=CGRectMake(2, 43, 198-16, 148-22-22);
    
    }
    else if(arrowDirection==DIRECTION_TOP)
    {
        gRect=CGRectMake(2, 43+14, 198-2, 148-22-14-22);
        
    }
    else if(arrowDirection==DIRECTION_BOTTOM)
    {
        gRect=CGRectMake(2, 43, 198-2, 148-22-14-22);
 
    }
    else
    {
        gRect=CGRectMake(16, 43, 198-16, 148-22-22);
        
    }
    
    
    
    if(!roundedCorner)
    {
        bgView=[[UIImageView alloc]initWithFrame:gRect];
        [bgView setImage:[UIImage imageNamed:@"pie_pop_over_gradient.jpg"]];
        [self addSubview:bgView];
    }
    
    
    
    if(arrowDirection==DIRECTION_TOP )
    {
        
        //Title
        titleLabelBg=[[UILabel alloc]initWithFrame:CGRectMake(2, 2+40+14, 182+14,1)];
        
        
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+16, 2+14, 140, 40)];
        
        iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 14, 40, 40)];
        
        descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5+2, 42+14, 180+14, 110-14)];
    }
    else if(arrowDirection==DIRECTION_BOTTOM)
    {
        
        titleLabelBg=[[UILabel alloc]initWithFrame:CGRectMake(2, 2+40, 182+14, 1)];
        
        
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+16, 2, 140, 40)];
        
        iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(0+2, 0, 40, 40)];
        
        descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5+2, 42, 180+14, 110-14)];
        
    }
    else if(arrowDirection==DIRECTION_RIGHT)
    {
        //Title
        titleLabelBg=[[UILabel alloc]initWithFrame:CGRectMake(0+2, 2+40, 182, 1)];
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+2, 2, 140, 40)];
        
        iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(0+2, 0, 40, 40)];
        
        descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5+2, 42, 180, 110)];
        
    }
    else
    {
        //Title
        titleLabelBg=[[UILabel alloc]initWithFrame:CGRectMake(0+16, 2+40, 182, 1)];
        
        titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40+16, 2, 140, 40)];
        
        iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(0+16, 0, 40, 40)];
        
        descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5+16, 42, 180, 110)];
        
    }
    
    
    [titleLabelBg setBackgroundColor:[UIColor grayColor]];
    [titleLabelBg setAlpha:0.5];
    [self addSubview:titleLabelBg];
    
    
    [titleLabel setTextColor:[UIColor darkGrayColor]];
    titleLabel.numberOfLines=2;
    titleLabel.lineBreakMode=UILineBreakModeWordWrap;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [self addSubview:titleLabel];
    
    
    [descriptionLabel setTextColor:[UIColor blackColor]];
    descriptionLabel.numberOfLines=5;
    descriptionLabel.baselineAdjustment=TRUE;
    descriptionLabel.lineBreakMode=UILineBreakModeWordWrap;
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [self addSubview:descriptionLabel];
    
    [self addSubview:iconImg];

    
}


-(void)resetFrames
{
    if(arrowDirection==DIRECTION_RIGHT)
    {
        gRect=CGRectMake(2, 43, 198-16, 148-22-22);
        
    }
    else if(arrowDirection==DIRECTION_TOP)
    {
        gRect=CGRectMake(2, 43+14, 198-2, 148-22-14-22);
        
    }
    else if(arrowDirection==DIRECTION_BOTTOM)
    {
        gRect=CGRectMake(2, 43, 198-2, 148-22-14-22);
        
    }
    else
    {
        gRect=CGRectMake(16, 43, 198-16, 148-22-22);
        
    }
    
    
    if(arrowDirection==DIRECTION_TOP )
    {
        
        //Title
        titleLabelBg.frame=CGRectMake(2, 2+40+14, 182+14,1);
        
        
        
        titleLabel.frame=CGRectMake(40+16, 2+14, 140, 40);
        
        iconImg.frame=CGRectMake(2, 14, 40, 40);
        
        descriptionLabel.frame=CGRectMake(5+2, 42+14, 180+14, 110-14);
    }
    else if(arrowDirection==DIRECTION_BOTTOM)
    {
        
        
        titleLabelBg.frame=CGRectMake(2, 2+40, 182+14, 1);
        
        
        
        titleLabel.frame=CGRectMake(40+16, 2, 140, 40);
        
        iconImg.frame=CGRectMake(0+2, 0, 40, 40);
        
        descriptionLabel.frame=CGRectMake(5+2, 42, 180+14, 110-14);
        
    }
    else if(arrowDirection==DIRECTION_RIGHT)
    {
        //Title
        titleLabelBg.frame=CGRectMake(0+2, 2+40, 182, 1);
        
        titleLabel.frame=CGRectMake(40+2, 2, 140, 40);
        
        iconImg.frame=CGRectMake(0+2, 0, 40, 40);
        
        descriptionLabel.frame=CGRectMake(5+2, 42, 180, 110);
        
    }
    else
    {
        //Title
        titleLabelBg.frame=CGRectMake(0+16, 2+40, 182, 1);
        
        titleLabel.frame=CGRectMake(40+16, 2, 140, 40);
        
        iconImg.frame=CGRectMake(0+16, 0, 40, 40);
        
        descriptionLabel.frame=CGRectMake(5+16, 42, 180, 110);
        
    }
    
    bgView.frame=gRect;



}

-(void)setTheValues
{
    [titleLabel setText:ptitle];
  
    
    if(![icon isEqualToString:@""])
    {
        [iconImg setHidden:NO];
        UIImage *im=[UIImage imageNamed:icon];
        [iconImg setImage:im];
        
        CGRect a=iconImg.frame;
        a.size.width=im.size.width;
        a.size.height=im.size.height;
        iconImg.frame=a;
                
        
    }
    else
    {
        [iconImg setHidden:YES];
    }
    
    [descriptionLabel setText:summary];


}

-(void)initAlpha
{
    if(detailPopUpType==mPIE_DETAIL_POPUP_TYPE2 || detailPopUpType==mPIE_DETAIL_POPUP_TYPE3)
    {
        titleLabelBg.alpha=0;
        titleLabel.alpha=0;
        iconImg.alpha=0;
        descriptionLabel.alpha=0;
        alpha=0;
        
        [timer invalidate];
        timer=nil;
    }

}


-(void)StartTimerForShowingText
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    titleLabelBg.alpha=1.0;
    titleLabel.alpha=1.0;
    iconImg.alpha=1.0;
    descriptionLabel.alpha=1.0;
    
    [UIView commitAnimations];
    
}


@end
