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
//  AnchorInfo.m
//  MIM2D Library
//
//  Created by Reetu Raj on 27/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "AnchorInfo.h"


@implementation AnchorInfo
@synthesize infoString,tagID;
@synthesize displaying;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        infoString=@"";
        self.backgroundColor=[UIColor clearColor];
        displaying=YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //Clear the color of background
    CGContextSetLineWidth(context, 20.0);
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, rect);      
    CGContextStrokePath(context);
    
    
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    //Flip the context so that the text will appear right , 
    //otherwise it appears upside down and its mirror image.
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    if([infoString length]>1)
    {
    
        NSInteger _stringLength=[infoString length];


        //Convert NSString to CFStringRef
        // Initialize an attributed string.
        //Copy the CFStringRef to CFMutableAttributedStringRef
        CFStringRef string =  (__bridge CFStringRef) infoString;
        CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
        CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);





        CGColorRef _red=[UIColor blackColor].CGColor;

        //Lets have our string  as red 
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    


        CTFontRef font = CTFontCreateWithName((CFStringRef)@"Helvetica", 12.0f, nil);
        CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,font);

        //Set the paragrapgh attribute
        CTTextAlignment alignment = kCTRightTextAlignment;
        CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength), kCTParagraphStyleAttributeName, paragraphStyle);


        CTLineRef line = CTLineCreateWithAttributedString(attrString);

        // Set text position and draw the line into the graphics context
        CGContextSetTextPosition(context,2,2);
        CTLineDraw(line, context);
        CFRelease(line);        
        

    }



}

- (void)dealloc
{
    
}

@end
