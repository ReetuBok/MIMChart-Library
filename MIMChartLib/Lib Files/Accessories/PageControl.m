//
//  PageControl.m
//  Retail Analytics
//
//  Created by Mac Mac on 2/13/12.
//  Copyright (c) 2012 _MyCompany_. All rights reserved.
//

#import "PageControl.h"

@implementation PageControl
@synthesize currentPage,numberOfPages;
//@synthesize delegate;
// Tweak these or make them dynamic.
#define kDotDiameter 7.0
#define kDotSpacer 7.0



- (NSInteger)currentPage
{
    return _currentPage;
}

- (void)setCurrentPage:(NSInteger)page
{
    _currentPage = MIN(MAX(0, page), _numberOfPages-1);
    [self setNeedsDisplay];
}

- (NSInteger)numberOfPages
{
    return _numberOfPages;
}

- (void)setNumberOfPages:(NSInteger)pages
{
    _numberOfPages = MAX(0, pages);
    _currentPage = MIN(MAX(0, _currentPage), _numberOfPages-1);
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        // Default colors.
        self.backgroundColor = [UIColor clearColor];
       
    }
    return self;
}

- (void)drawRect:(CGRect)rect 
{
    CGContextRef context = UIGraphicsGetCurrentContext();   
    CGContextSetAllowsAntialiasing(context, true);
    
    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = self.numberOfPages*kDotDiameter + MAX(0, self.numberOfPages-1)*kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-kDotDiameter/2;
    for (int i=0; i<_numberOfPages; i++)
    {
        CGRect circleRect = CGRectMake(x, y, kDotDiameter, kDotDiameter);
        if (i == _currentPage)
        {
            CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
        }
        else
        {
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        }
        CGContextFillEllipseInRect(context, circleRect);
        x += kDotDiameter + kDotSpacer;
    }
}


/*

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   // if (!self.delegate) return;
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    CGFloat dotSpanX = self.numberOfPages*(kDotDiameter + kDotSpacer);
    CGFloat dotSpanY = kDotDiameter + kDotSpacer;
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);
    
    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;
    
    self.currentPage = floor(x/(kDotDiameter+kDotSpacer));
    //if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
    {
        [self.delegate pageControlPageDidChange:self];
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];
    
    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x - CGRectGetMidX(currentBounds);
    
    if(x<0 && self.currentPage>=0){
        self.currentPage--;
        [self.delegate pageControlPageDidChange:self]; 
    }
    else if(x>0 && self.currentPage<self.numberOfPages-1){
        self.currentPage++;
        [self.delegate pageControlPageDidChange:self]; 
    }   
}
*/

@end
