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
//  DoughtNutFragmentTitle.m
//  MIM2D Library
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "DoughtNutFragmentTitle.h"
#import "MIMFragmentedDoughNut.h"

@implementation DoughtNutFragmentTitle
@synthesize  title;
@synthesize   rotationAngle;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];

        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CTTextAlignment alignment;
    
    if((rotationAngle > 1.57)&&(rotationAngle < 4.7))
    {
        //Make the horizontal flip so that text is readable from user's view angle.
        alignment= kCTRightTextAlignment;
        CGAffineTransform transform = CGAffineTransformMake(-1.0, 0.0, 0.0, 1.0, 184, 0.0);
        CGContextConcatCTM(context,transform);
    }
    else
    {
        alignment= kCTLeftTextAlignment;
        CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, 40);
        CGContextConcatCTM(context, flipTransform);
    }
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    
    //Clear the color of background
    CGContextSetLineWidth(context, 92.0);
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, rect);      
    CGContextStrokePath(context);
    
   
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);
  
    //This is the string we want to write on our screen and we also need to get the string length
    NSString *test = self.title;
    NSInteger _stringLength=[test length];
    
    
    //Convert NSString to CFStringRef
    // Initialize an attributed string.
    //Copy the CFStringRef to CFMutableAttributedStringRef
    CFStringRef string =  (__bridge CFStringRef) test;
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
    
    
    
    
    
    CGColorRef _red=[UIColor blackColor].CGColor;
    
    //Lets have our string  as red 
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    
    
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"GillSans", 14.0f, nil);
    CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,font);
    
    //Set the paragrapgh attribute
     
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength), kCTParagraphStyleAttributeName, paragraphStyle);
    
    
    
    
    
    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, 184.0, 40.0);
    CGPathAddRect(path, NULL, bounds);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path, NULL);
    CFRelease(framesetter);
    CTFrameDraw(frame, context);
    
        

    
    
}

-(void)draw
{
    float outerRadius=200;
    if(rotationAngle >= 0 && rotationAngle <= 3.14)
        self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(rotationAngle), CGAffineTransformMakeTranslation((outerRadius + 80)* cos(rotationAngle), (outerRadius + 80)* sin(rotationAngle)));
    
    if(rotationAngle > 3.14 && rotationAngle <= 2*3.14)
        self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(rotationAngle), CGAffineTransformMakeTranslation((outerRadius + 110)* cos(rotationAngle), (outerRadius + 110)* sin(rotationAngle)));
}
 



- (void)dealloc
{
    ////[super dealloc];
}

@end
