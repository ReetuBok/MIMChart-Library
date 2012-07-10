//
//  MIMMeter.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMMeter.h"
#import "Constant.h"

@interface MIMMeter()
{
    float lineWidth;
    UIColor *lineColor;
    UIColor *handleColor;
    float _firstX;
    float _firstY;
}

@end

@implementation MIMMeter
@synthesize mProperties,minPointX,maxPointX;
@synthesize tileWidth=_tileWidth;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)initVariables
{
    
    
    MIMColorClass *c=[MIMColorClass colorWithRed:1 Green:0 Blue:0 Alpha:1.0];
    if([mProperties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[mProperties valueForKey:@"color"]];
    lineColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    
    c=[MIMColorClass colorWithRed:0 Green:0 Blue:0 Alpha:1.0];
    if([mProperties valueForKey:@"hcolor"]) 
        c=[MIMColorClass colorWithComponent:[mProperties valueForKey:@"hcolor"]];
    handleColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    
    //Width
    lineWidth=2;
    if([mProperties valueForKey:@"width"]) 
        lineWidth=[[mProperties valueForKey:@"width"] floatValue];
    
    if(lineWidth==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self addGestureRecognizer:panRecognizer];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self initVariables];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    //Clear the color of background
    CGRect r=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, r);      
    CGContextFillPath(context);
    
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    CGContextSaveGState(context);
    UIColor *shadowColor=[lineColor colorWithAlphaComponent:1.0];
    //Draw the line
    r=CGRectMake((CGRectGetWidth(rect) -lineWidth)/2, 0, lineWidth, CGRectGetHeight(rect)-5);
    CGContextSetFillColorWithColor(context, lineColor.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, shadowColor.CGColor);
    CGContextAddRect(context, r);      
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    

    
    
    
    
    //Draw the handler    
    CGContextMoveToPoint(context, (CGRectGetWidth(rect))/2, CGRectGetHeight(rect)-30);
    CGContextAddLineToPoint(context, (CGRectGetWidth(rect))/2 - 15, CGRectGetHeight(rect));
    CGContextAddLineToPoint(context, (CGRectGetWidth(rect))/2 + 15, CGRectGetHeight(rect));
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, handleColor.CGColor);
    CGContextFillPath(context);
    
    
    
}



-(void)move:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:[self superview]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) 
    {
        _firstX = [self center].x;
        _firstY = [self center].y;
    }
    
    translatedPoint = CGPointMake(_firstX+translatedPoint.x, _firstY);
    
    if(translatedPoint.x > minPointX && translatedPoint.x < maxPointX)
    [self setCenter:translatedPoint];

    
    int index=[self crossingAnchorPoint:translatedPoint];
    [self.delegate meterCrossingAnchorPoint:index];
}

-(int)crossingAnchorPoint:(CGPoint)point
{
    int index=-1;
    float currentX=point.x;
    
    float reminder=fmodf(currentX, _tileWidth);
    //NSLog(@"reminder=%f",reminder);
    if(reminder>53)
    {
        index=currentX/_tileWidth;
        index+=1;
        
        NSLog(@"crossing anchor Point=%i",index);
    }
    else if(reminder<7)
    {
        index=currentX/_tileWidth;
        NSLog(@"crossing anchor Point=%i",index);
    }
    
    return index;
}
@end
