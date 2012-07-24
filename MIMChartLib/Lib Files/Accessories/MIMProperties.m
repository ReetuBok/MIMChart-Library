//
//  MIMProperties.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MIMProperties.h"


@implementation MIMProperties




+(void)drawHorizontalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)hlProperties gridHeight:(float)gridHeight tileHeight:(float)tileHeight gridWidth:(float)gridWidth leftMargin:(float)leftMargin topMargin:(float)topMargin;

{
    
    float _tileHeight=tileHeight;
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    
    BOOL horizontalLinesVisible=TRUE;
    if([hlProperties valueForKey:@"hide"]) 
        horizontalLinesVisible=[[hlProperties valueForKey:@"hide"] boolValue];
    
    if(!horizontalLinesVisible)
    {
        NSLog(@"Caution:Horizontal Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawHorizontalLines:");
        return;
    }
    
    
    
    //Width
    float widthOfLine=0.1;
    if([hlProperties valueForKey:@"width"]) 
        widthOfLine=[[hlProperties valueForKey:@"width"] floatValue];
    
    if(widthOfLine==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    //Color
    MIMColorClass *c=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
    if([hlProperties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[hlProperties valueForKey:@"color"]];
    
    //Find if it needs to be dotted line
    NSString *dotted=@"";
    if([hlProperties valueForKey:@"dotted"]) 
        dotted=[hlProperties valueForKey:@"dotted"];
    
    
    
    CGContextSaveGState(ctx);
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    int numHorzLines=_gridHeight/_tileHeight;
    
    
    for (int i=1; i<=numHorzLines; i++) 
    {    
        CGContextMoveToPoint(ctx, leftMargin,gridHeight+topMargin- i*_tileHeight );
        CGContextAddLineToPoint(ctx,_gridWidth+leftMargin ,gridHeight+topMargin- i*_tileHeight);
    }
    
    if([dotted isEqualToString:@""])
    {    
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    else 
    {
        NSArray *c=[dotted componentsSeparatedByString:@","];
        
        NSEnumerator *enumerator;
        float * floatArray;
        id floatObject;
        int index=0;
        
        floatArray = (float *) malloc(sizeof(float) * [c count]);
        enumerator = [c objectEnumerator];
        while(floatObject = [enumerator nextObject])
        {
            floatArray[index] = [floatObject floatValue];
            index++;
        }
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineDash(ctx,0,floatArray,[c count]);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);
    
    
}



+(void)drawVerticalBgLines:(CGContextRef)ctx  withProperties:(NSDictionary *)vlProperties gridHeight:(float)gridHeight tileWidth:(float)tileWidth gridWidth:(float)gridWidth scalingX:(float)scalingX  xIsString:(BOOL)xIsString bottomMargin:(float)bottomMargin leftMargin:(float)leftMargin topMargin:(float)topMargin
{
    
    float _tileWidth=tileWidth;
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    float _scalingX=scalingX;
    
    BOOL verticalLinesVisible=TRUE;
    if([vlProperties valueForKey:@"hide"]) 
        verticalLinesVisible=[[vlProperties valueForKey:@"hide"] boolValue];
    
    if(!verticalLinesVisible)
    {
        NSLog(@"Caution:Vertical Lines wont be visible on Line Graph. If you want them to be visible use  delegate method drawVerticalLines:");
        
        return;
    }
    
    
    //Width
    float widthOfLine=0.1;
    if([vlProperties valueForKey:@"width"]) 
        widthOfLine=[[vlProperties valueForKey:@"width"] floatValue];
    
    if(widthOfLine==0) NSLog(@"WARNING: Line width of horizontal line is 0.");
    
    
    
    //Color
    MIMColorClass *c=[MIMColorClass colorWithRed:0.8 Green:0.8 Blue:0.8 Alpha:1.0];
    if([vlProperties valueForKey:@"color"]) 
        c=[MIMColorClass colorWithComponent:[vlProperties valueForKey:@"color"]];
    
    //Find if it needs to be dotted line
    NSString *dotted=@"";
    if([vlProperties valueForKey:@"dotted"]) 
        dotted=[vlProperties valueForKey:@"dotted"];
    

    
    
    CGContextSaveGState(ctx);

    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:c.red green:c.green blue:c.blue alpha:c.alpha].CGColor);
    CGContextSetLineWidth(ctx, widthOfLine);
    
    int numVertLines=_gridWidth/_scalingX;
    
    if(xIsString)
    {
//        if([[_xValElements objectAtIndex:0] isKindOfClass:[NSString class]]) numVertLines=[_xValElements count];
//        else numVertLines=[[_xValElements objectAtIndex:0] count];
//        
        
        for (int i=1; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i * _scalingX + leftMargin,topMargin);
            CGContextAddLineToPoint(ctx, i * _scalingX + leftMargin,_gridHeight+topMargin);
        }
        
    }
    else
    {
        for (int i=1; i<numVertLines; i++) 
        {   
            CGContextMoveToPoint(ctx, i*_tileWidth + leftMargin,topMargin);
            CGContextAddLineToPoint(ctx, i*_tileWidth + leftMargin,_gridHeight+topMargin);
        }
    }
    

    if([dotted isEqualToString:@""])
    {    
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    else 
    {

        NSArray *c=[dotted componentsSeparatedByString:@","];
        
        NSEnumerator *enumerator;
        float * floatArray;
        id floatObject;
        int index=0;
        
        floatArray = (float *) malloc(sizeof(float) * [c count]);
        enumerator = [c objectEnumerator];
        while(floatObject = [enumerator nextObject])
        {
            floatArray[index] = [floatObject floatValue];
            index++;
        }
        
        CGContextSetLineWidth(ctx, 1);
        CGContextSetLineDash(ctx,0,floatArray,[c count]);
        CGContextStrokePath(ctx);
    }
    
    CGContextRestoreGState(ctx);

    
}


+(void)drawBgPattern:(CGContextRef)ctx color:(MIMColorClass *)mbackgroundColor gridWidth:(float)gridWidth gridHeight:(float)gridHeight leftMargin:(float)leftMargin topMargin:(float)topMargin
{
    
    float _gridHeight=gridHeight;
    float _gridWidth=gridWidth;
    
    //Check if User has given any color for Background
    if(mbackgroundColor)
    {
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:mbackgroundColor.red green:mbackgroundColor.green blue:mbackgroundColor.blue alpha:mbackgroundColor.alpha].CGColor);
        CGContextFillRect(ctx, CGRectMake(leftMargin, topMargin, _gridWidth, _gridHeight));
        CGContextRestoreGState(ctx);
        return;
        
        
    }
    
//    if([delegate respondsToSelector:@selector(backgroundViewForLineChart:)])
//    {
//        
//        
//        return;
//    }
//    
//    
    
    //Else Draw the background with the gray Gradient
    CGContextSaveGState(ctx);
    CGFloat BGLocations[3] = { 0.0,0.5 ,1.0 };
    CGFloat BgComponents[12] = { 0.96, 0.96, 0.96 , 1.0,  // Start color
        0.99, 0.99, 0.99 , 1.0,  // Start color
        1.0, 1.0, 1.0 , 1.0 }; // Mid color and End color
    
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    CGContextAddRect(ctx, CGRectMake(leftMargin, topMargin, _gridWidth, _gridHeight+topMargin));
    if(!CGContextIsPathEmpty(ctx))
        CGContextClip(ctx);
    
    CGContextDrawLinearGradient(ctx, bgRadialGradient, CGPointMake(0, topMargin), CGPointMake(0, _gridHeight+topMargin), 0 );
    
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    CGContextRestoreGState(ctx);
    
}

+(void)createGloss:(CGContextRef)context  OnRect:(CGRect)rect withStyle:(int)glossStyle
{
    float red,green,blue,alpha,Dred,Dgreen,Dblue,DAlpha;

    
    if(glossStyle!=6)
    {
        Dred=1.0;
        Dgreen=1.0;
        Dblue=1.0;
        DAlpha=0.5;
        
        
        red=1.0;
        green=1.0;
        blue=1.0;
        alpha=0.05;
        
        switch (glossStyle) 
        {
            case 1:
            default:
            {
                CGContextSaveGState(context);
                
                
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(rect));
                CGPathAddCurveToPoint(path, NULL, 0, CGRectGetHeight(rect),CGRectGetWidth(rect)/2 ,CGRectGetHeight(rect)/5, CGRectGetWidth(rect),  CGRectGetHeight(rect)/10);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
                
            case 2:
            {
                CGContextSaveGState(context);
                
                CGMutablePathRef path= CGPathCreateMutable();
                CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(rect)*0.6);
                
                CGPathAddQuadCurveToPoint(path, NULL, CGRectGetWidth(rect)*0.5, CGRectGetHeight(rect)*0.55, CGRectGetWidth(rect), CGRectGetHeight(rect)*0.4);
                CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), 0);
                CGPathAddLineToPoint(path, NULL, 0, 0);
                CGPathCloseSubpath(path);
                CGContextAddPath(context, path);
                
                CGContextClip(context);
            }
                break;
        }
        
        
        
        //DRaw the gloss gradient
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { red, green, blue, alpha,  // Start color
            Dred, Dgreen, Dblue, DAlpha }; // Mid color and End color
        
        
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        CGPoint start = CGPointMake(CGRectGetWidth(rect),CGRectGetHeight(rect)*0.7); 
        CGPoint end = CGPointMake(CGRectGetWidth(rect), -5);
        CGContextDrawLinearGradient(context, glossGradient, start, end, kCGGradientDrawsBeforeStartLocation);
        
        
        CGContextRestoreGState(context);
        
        
    }
    
}




@end
