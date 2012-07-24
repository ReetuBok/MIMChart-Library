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
//  XAxisLabel.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "XAxisLabel.h"
#import <CoreText/CoreText.h>

@implementation XAxisLabel
@synthesize text,labelTag,style,width,lineChart,mBackgroundColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        mBackgroundColor=[UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   
    if(!xTitleColor)
        return;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetShouldAntialias(ctx, YES);

    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);


    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextAddRect(ctx, CGRectMake(0, 0, width, 15.0));      
    CGContextFillPath(ctx);
    
    
    CGContextSetBlendMode(ctx,kCGBlendModeNormal);
    CGContextSetFillColorWithColor(ctx, mBackgroundColor.CGColor);
    CGContextAddRect(ctx, CGRectMake(0, 0, width, 15.0));      
    CGContextFillPath(ctx);
    

    
    //This is the string we want to write on our screen and we also need to get the string length
    NSString *test =[NSString stringWithFormat:@"%@",text];
    NSInteger _stringLength=[test length];
    
    
    //Convert NSString to CFStringRef
    // Initialize an attributed string.
    //Copy the CFStringRef to CFMutableAttributedStringRef
    CFStringRef string =  (__bridge CFStringRef) test;
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
    

    CGColorRef _red=xTitleColor.CGColor;
    
    //Lets have our string  as red 
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    
    
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"Helvetica", 12.0f, nil);
    CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,font);
    
    
    switch (style) 
    {
        case 1: 
            self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(-1.57), CGAffineTransformMakeTranslation(-width/2, width/2));   
            break;
            
        case 2:
        {
            float theta=1.57/2;
            if(lineChart)
            self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(-theta), CGAffineTransformMakeTranslation(-width* asin(theta), width/2* acos(theta)));
            else
            self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(-1.57/2), CGAffineTransformMakeTranslation(-width/2, width/2));   

        }

            break;
            
    }

    
    
    //Set the paragrapgh attribute
    CTTextAlignment alignment; 
    
    switch (style) {
            
        case 1:
              alignment = kCTRightTextAlignment;
            break;
            
        case 2:
              alignment = kCTRightTextAlignment;
            break;
        case 3:
              alignment = kCTLeftTextAlignment;
            break;
        case 4:
            alignment = kCTCenterTextAlignment;
            break;
        case 5:
            alignment = kCTCenterTextAlignment;
            break;
    }
    
    
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength), kCTParagraphStyleAttributeName, paragraphStyle);
    

    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0, 0, width, 15.0);
    CGPathAddRect(path, NULL, bounds);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path, NULL);
    CFRelease(framesetter);
    CTFrameDraw(frame, ctx);
   
}


-(void)drawTitleWithColor:(UIColor *)color
{
    xTitleColor=color;
    [self setNeedsDisplay];
}




- (void)dealloc
{
    ////[super dealloc];
}

@end
