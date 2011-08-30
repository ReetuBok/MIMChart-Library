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
//  XAxisLabel.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XAxisLabel.h"
#import <CoreText/CoreText.h>

@implementation XAxisLabel
@synthesize text,labelTag,style,width,lineChart;

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
   
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);


    CGContextSetBlendMode(ctx,kCGBlendModeClear);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextAddRect(ctx, CGRectMake(0, 0, width, 15.0));      
    CGContextFillPath(ctx);
    
    
     CGContextSetBlendMode(ctx,kCGBlendModeNormal);
    
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextAddRect(ctx, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));  
//    CGContextFillPath(ctx);
    
    //This is the string we want to write on our screen and we also need to get the string length
    NSString *test =[NSString stringWithFormat:@"%@",text];
    NSInteger _stringLength=[test length];
    
    
    //Convert NSString to CFStringRef
    // Initialize an attributed string.
    //Copy the CFStringRef to CFMutableAttributedStringRef
    CFStringRef string =  (CFStringRef) test;
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
    

    CGColorRef _red=[UIColor whiteColor].CGColor;
    
    //Lets have our string  as red 
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    
    
    
    CTFontRef font = CTFontCreateWithName((CFStringRef)@"Helvetica", 12.0f, nil);
    CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,font);
    
    
    switch (style) {
        case 1:
//            self.transform=CGAffineTransformConcat(CGAffineTransformMakeRotation(-1.57/2), CGAffineTransformMakeTranslation(-width/2, width/2));   
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





- (void)dealloc
{
    [super dealloc];
}

@end
