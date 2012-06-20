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
//  ClusterGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "ClusterGraph.h"
#import "Cluster.h"

@implementation ClusterGraph
@synthesize xIsString;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)FindTileWidth
{
    
    _tileWidth=50;
    
    
}
-(float)FindMaxOfY
{
    
    return maxOfY;
    
}

-(void)readYValuesFromCSV:(NSString *)path  AtColumn:(int)column
{
    
    _yElements=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [_yElements addObject:[columnArray objectAtIndex:column]];
            k++;
            
        }
    


}

-(void)readXvaluesFromCSV:(NSString *)path  AtColumn:(int)column
{
    
    _xElements=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
            [_xElements addObject:[columnArray objectAtIndex:column]];
            k++;
            
        }
    

    
}
#pragma mark - scaling


-(void)ScalingFactor
{
    maxOfY=[self findMaximumValue:_yElements];
    [self findScaleForYTile:CGRectGetHeight(self.frame)]; // Find Scaling factor for Y
    [self findScaleForXTile];
}

-(int)findMaximumValue:(NSArray *)array
{
    int maxVal=[[array objectAtIndex:0] intValue];
    for (int i=1; i<[array count]; i++) {
        
        if(maxVal<[[array objectAtIndex:i] intValue])
            maxVal=[[array objectAtIndex:i] intValue];
    }   
    return maxVal;
    
}


-(void)findScaleForYTile:(float)screenHeight
{
    int HorLines=screenHeight/_tileWidth;
    float maxY=maxOfY;
    float pixelPerTile=maxY/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingY=_tileWidth/pixelPerTile;
    
    NSLog(@"_scalingY=%f",_scalingY);
    
}


-(void)findScaleForXTile
{
    if(xIsString){
        _scalingX=CGRectGetWidth(self.frame)/[_xElements count];
        return;
    }
    
    int VerLines=CGRectGetWidth(self.frame)/_tileWidth;
    
    float maxX=[self findMaximumValue:_xElements];
    float pixelPerTile=maxX/(VerLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingX=_tileWidth/pixelPerTile;
    NSLog(@"_scalingX=%f",_scalingX);
}


-(void)initAll
{
    [self FindTileWidth];
    [self ScalingFactor];
    
}


-(void)drawClusterGraph
{
    [self initAll];
    [self setNeedsDisplay];
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    
    [self drawBackGroundGradient:context];
    [self drawHorizontalBgLines:context];
    
    for (int i=0; i<[_xElements count]; i++) {
       
    float xOrigin=[[_xElements objectAtIndex:i] floatValue]*_scalingX;    
    float yOrigin=CGRectGetHeight(rect)-[[_yElements objectAtIndex:i] floatValue]*_scalingY;

    Cluster *clusterShape=[[Cluster alloc]initWithFrame:CGRectMake(0,0, 20, 20)];
    clusterShape.center=CGPointMake(xOrigin+10, yOrigin+10);
    clusterShape.color=[UIColor colorWithRed:.282 green:0.764 blue:0.996 alpha:1.0];
    clusterShape.radius=9;
    clusterShape.style=DOTS;
    [self addSubview:clusterShape];
        
        
    //Draw the shadow
    [clusterShape.layer setShadowRadius:1.0];
    [clusterShape.layer setShadowColor:[UIColor grayColor].CGColor];
    [clusterShape.layer setShadowOffset:CGSizeMake(1.0, -1.0)];
    [clusterShape.layer setShadowOpacity:0.8];
    [self addSubview:clusterShape];
        
   
        
    }
    
}

-(void)drawBackGroundGradient:(CGContextRef)context
{

    
    //Draw the background with the gray Gradient
    float _viewWidth=self.frame.size.width;
    float _viewHeight=self.frame.size.height;
    
    
    
    CGFloat BGLocations[3] = { 0.0, 0.65, 1.0 };
    CGFloat BgComponents[12] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.9, 0.9, 0.9 , 1.0,  // Start color
        0.75, 0.75, 0.75 , 1.0 }; // Mid color and End color
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 3);
    
    
    CGPoint startBg = CGPointMake(_viewWidth/2,_viewHeight/2); 
    CGFloat endRadius=MAX(_viewWidth/2, _viewHeight/2);
    
    
    CGContextDrawRadialGradient(context, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);
    
    



}

-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7].CGColor);
    CGContextSetLineWidth(ctx, 0.1);
    int numHorzLines=CGRectGetHeight(self.frame)/_tileWidth;
    for (int i=0; i<numHorzLines; i++) {
        
        CGContextMoveToPoint(ctx, 0,i*_tileWidth);
        CGContextAddLineToPoint(ctx,CGRectGetWidth(self.frame) , i*_tileWidth);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
}



- (void)dealloc
{
    ////[super dealloc];
}

@end
