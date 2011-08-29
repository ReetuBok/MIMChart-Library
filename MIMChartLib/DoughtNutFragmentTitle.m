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
//  DoughtNutFragmentTitle.m
//  MIM3D
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DoughtNutFragmentTitle.h"
#import "2DFragmentedDoughNut.h"

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
    CFStringRef string =  (CFStringRef) test;
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
    [super dealloc];
}

@end
