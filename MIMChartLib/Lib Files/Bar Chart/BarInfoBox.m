//
//  BarInfoBox.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BarInfoBox.h"

@implementation BarInfoBox
@synthesize text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //Clear the color of background
    CGRect a=CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    CGContextSetBlendMode(context,kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddRect(context, a);      
    CGContextFillPath(context);
    
    
    
    CGContextSetBlendMode(context,kCGBlendModeNormal);
    
    
    //Flip the context so that the text will appear right , 
    //otherwise it appears upside down and its mirror image.
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(context, flipTransform);
    
    if([text length]>1)
    {
        
        NSInteger _stringLength=[text length];
        
        
        //Convert NSString to CFStringRef
        // Initialize an attributed string.
        //Copy the CFStringRef to CFMutableAttributedStringRef
        CFStringRef string =  (__bridge CFStringRef) text;
        CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
        CFAttributedStringReplaceString (attrString,CFRangeMake(0, 0), string);
        
        
        
        
        if (!textColor) 
        {
            CGColorRef _color=[UIColor grayColor].CGColor;            
            CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _color); 
        }
        else 
        {
            CGColorRef _color=[UIColor colorWithRed:textColor.red green:textColor.green blue:textColor.blue alpha:textColor.alpha].CGColor;            
            CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength),kCTForegroundColorAttributeName, _color); 
        }
           
        
        if(!font)
        {
            CTFontRef _font = CTFontCreateWithName((CFStringRef)@"Helvetica", 12.0f, nil);
            CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,_font);
        }
        else
        {
            CTFontRef _font = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, nil);
            CFAttributedStringSetAttribute(attrString,CFRangeMake(0, _stringLength),kCTFontAttributeName,_font);
        }
        
        
        //Set the paragrapgh attribute
        CTTextAlignment alignment = kCTCenterTextAlignment;
        CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
        CFAttributedStringSetAttribute(attrString, CFRangeMake(0, _stringLength), kCTParagraphStyleAttributeName, paragraphStyle);
        
        
//        CTLineRef line = CTLineCreateWithAttributedString(attrString);
//        
//        // Set text position and draw the line into the graphics context
//        CGContextSetTextPosition(context,2,12);
//        CTLineDraw(line, context);
//        CFRelease(line);     
//        
        
        
        // Initialize a rectangular path.
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect bounds = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
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


@end
