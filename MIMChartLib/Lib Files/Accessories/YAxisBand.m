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
 */


//
//  YAxisBand.m
//  MIM2D Library
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "YAxisBand.h"

@interface YAxisBand()
{
    float lineWidth;
    float tileHeight;
    float pixelPerYTile;
    int HorLines;
    UIColor *lineColor;
    float minStart;
    
}
-(void)drawYAxis:(CGContextRef)ctx;
@end

@implementation YAxisBand

@synthesize properties;
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
    
    
    MIMColorClass *c=[MIMColorClass colorWithRed:0.7 Green:0.7 Blue:0.7 Alpha:1.0];
    if([properties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[properties valueForKey:@"color"]];
    
    lineColor=[UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha];
    
    //Width
    lineWidth=0.1;
    if([properties valueForKey:@"linewidth"]) 
        lineWidth=[[properties valueForKey:@"linewidth"] floatValue];
    
    if(lineWidth==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    if([properties valueForKey:@"pxpertile"]) 
        pixelPerYTile=[[properties valueForKey:@"pxpertile"] floatValue];
    
    
    if([properties valueForKey:@"num"]) 
        HorLines=[[properties valueForKey:@"num"] intValue];
    
    
    if([properties valueForKey:@"minY"]) 
        minStart=[[properties valueForKey:@"minY"] intValue];
    
    tileHeight=50;
    if([properties valueForKey:@"tileHeight"]) 
        tileHeight=[[properties valueForKey:@"tileHeight"] intValue];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self initVariables];
    
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
        
        
        for (int i=0; i<=HorLines; i++)
        {
            
            
            
            //This is the string we want to write on our screen and we also need to get the string length
            NSString *test =[NSString stringWithFormat:@"%.0f",minStart];
            NSInteger _stringLength=[test length];
            
            //NSLog(@"pixelPerYTile=%@",test);
            
            //Convert NSString to CFStringRef
            // Initialize an attributed string.
            //Copy the CFStringRef to CFMutableAttributedStringRef
            CFStringRef string =  (__bridge CFStringRef) test;
            CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
            CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
            
            
            
            
            
            CGColorRef _red=lineColor.CGColor;
            
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
            CGRect bounds = CGRectMake(0.0, tileHeight* i + 5, CGRectGetWidth(rect)-4, 15.0);
            CGPathAddRect(path, NULL, bounds);
            
            // Create the framesetter with the attributed string.
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
            CFRelease(attrString);
            
            // Create the frame and draw it into the graphics context
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), path, NULL);
            CFRelease(framesetter);
            CTFrameDraw(frame, context);
            
            
            minStart+=pixelPerYTile;
            
        }
        
    }
    
    
    
}

-(void)drawYAxis:(CGContextRef)ctx
{
    
    
    
    if(lineWidth<1) lineWidth=1;
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, self.frame.size.width,5);
    CGContextAddLineToPoint(ctx,self.frame.size.width, self.frame.size.height);
    CGContextDrawPath(ctx, kCGPathStroke);
    

    
    
    
}


- (void)dealloc
{
    ////[super dealloc];
}

@end
