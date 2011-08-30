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
//  YAxisBand.m
//  MIM3D
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YAxisBand.h"


@implementation YAxisBand


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tileWidth=50;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(pixelPerYTile!=0)
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
    
        [self drawYAxis:context];

        
    for (int i=1; i<HorLines; i++) {

    //This is the string we want to write on our screen and we also need to get the string length
    NSString *test =[NSString stringWithFormat:@"%.0f",pixelPerYTile*i];
    NSInteger _stringLength=[test length];
    
    //NSLog(@"pixelPerYTile=%@",test);

    //Convert NSString to CFStringRef
    // Initialize an attributed string.
    //Copy the CFStringRef to CFMutableAttributedStringRef
    CFStringRef string =  (CFStringRef) test;
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
    

    
    
    
    CGColorRef _red=[UIColor whiteColor].CGColor;
    
    //Lets have our string  as red 
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _red);    
    

    CTFontRef font = CTFontCreateWithName((CFStringRef)@"GillSans", 12.0f, nil);
    CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,font);
 
    //Set the paragrapgh attribute
    CTTextAlignment alignment = kCTRightTextAlignment;
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength), kCTParagraphStyleAttributeName, paragraphStyle);
    
    
    
    
    
    // Initialize a rectangular path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, _tileWidth* i - 5, CGRectGetWidth(rect)-4, 15.0);
    CGPathAddRect(path, NULL, bounds);
    
    // Create the framesetter with the attributed string.
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRelease(attrString);
    
    // Create the frame and draw it into the graphics context
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path, NULL);
    CFRelease(framesetter);
    CTFrameDraw(frame, context);
    
    
   }
    
    }

        

}

-(void)drawYAxis:(CGContextRef)ctx
{
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8].CGColor);
    CGContextSetLineWidth(ctx, 1.6);
    CGContextMoveToPoint(ctx, self.frame.size.width,0);
    CGContextAddLineToPoint(ctx,self.frame.size.width, self.frame.size.height);
    CGContextDrawPath(ctx, kCGPathStroke);
    
}

-(void)setScaleForYTile:(float)value  withNumOfLines:(int)numOfHorLines
{

    pixelPerYTile=value;
    HorLines=numOfHorLines;
    [self setNeedsDisplay];
    
}




- (void)dealloc
{
    [super dealloc];
}

@end
