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
//  AnchorInfo.m
//  MIM3D
//
//  Created by Reetu Raj on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
        CFStringRef string =  (CFStringRef) infoString;
        CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
        CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);





        CGColorRef _red=[UIColor blackColor].CGColor;

        //Lets have our string  as red 
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    


        CTFontRef font = CTFontCreateWithName((CFStringRef)@"Helvetica-Bold", 12.0f, nil);
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
    [super dealloc];
}

@end
