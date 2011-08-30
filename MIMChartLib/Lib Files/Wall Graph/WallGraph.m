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
//  WallGraph.m
//  MIM3D
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WallGraph.h"
#import "Anchor.h"
#import "AnchorInfo.h"
#import "MIMColor.h"
#import "YAxisBand.h"
#import "XAxisBand.h"

@implementation WallGraph
@synthesize xIsString,isGradient,style,patternImage;
@synthesize needStyleSetter,anchorType,isShadow;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
    }
    return self;
}

#pragma mark - style button

/*This method is needed only if you use Style setter*/
-(IBAction)styleButtonClicked:(id)sender
{
    
    
    
    if(isGradient)    style=[sender tag]+2;
    else     style=[sender tag]+1;
    
    
    
    [(UIButton*)sender setTag:style];
    [styleLabel setText:[NSString stringWithFormat:@"style=%i",style]];
    
    
    //Remove all Anchor
    
    for(UIView *view in self.subviews)
        if([view isKindOfClass:[Anchor class]]||[view isKindOfClass:[AnchorInfo class]])
            [view removeFromSuperview];
    
    
    
    [self drawWallGraph];
    
}




-(void)addSetterButton
{
    if(needStyleSetter)
    {
        
        //Style setter code start
        styleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        styleButton.tag=style;
        [styleButton setFrame:CGRectMake(10, 10, 100, 30)];
        [styleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [styleButton setTitle:@"Next" forState:UIControlStateNormal];
        [styleButton addTarget:self action:@selector(styleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:styleButton];
        //Style setter code end
        
        
        styleLabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
        [styleLabel setBackgroundColor:[UIColor clearColor]];
        [styleLabel setText:[NSString stringWithFormat:@"style=%i",style]];
        [styleLabel setTextColor:[UIColor blackColor]];
        [styleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [self addSubview:styleLabel];
        
    }
    
    
}



#pragma mark - draw x and y axis
-(void)displayYAxis
{
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame))];
    [_yBand setScaleForYTile:pixelsPerTile withNumOfLines:numOfHLines];
    [self addSubview:_yBand];
    
    
}



#pragma mark - read data

-(void)readFromCSV:(NSString *)csvPath  TitleAtColumn:(int)tColumn  DataAtColumn:(int)dColumn
{
    
    _yElements=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    for (int k=1; k<[linesArray count]-1; k++) {

        
    NSString *lineString=[linesArray objectAtIndex:k];
    NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
    [_yElements addObject:[columnArray objectAtIndex:dColumn]];    
        
    }
    

    
    
    _xElements=[[NSMutableArray alloc]init];
    
    

    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int k=1; k<[linesArray count]-1; k++) {
        
        
        NSString *lineString=[linesArray objectAtIndex:k];
        NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
        [_xElements addObject:[columnArray objectAtIndex:tColumn]];    
        
    }
       
    

    
     [self initAll];

}

-(void)initAll
{
    [self FindTileWidth];
    [self CalculateGridDimensions];
    [self ScalingFactor];
    [self addSetterButton];
}



-(void)CalculateGridDimensions
{

    _gridWidth=self.frame.size.width;
    _gridHeight=self.frame.size.height;
}


-(void)ScalingFactor
{
    maxOfY=[self findMaximumValue:_yElements];
    [self findScaleForYTile:_gridHeight]; // Find Scaling factor for Y
    [self findScaleForXTile];
}

-(void)FindTileWidth
{
 
    _tileWidth=50;
    

}

-(float)FindMaxOfY
{
    
    return maxOfY;

}

-(float)FindScaleOfX
{
    
    return _scalingX;
    
}



-(void)findScaleForYTile:(float)screenHeight
{
    int HorLines=screenHeight/_tileWidth;
    
    numOfHLines=HorLines;
    
    float maxY=maxOfY;
    float pixelPerTile=maxY/(HorLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    pixelsPerTile=pixelPerTile;
   
    
    _scalingY=_tileWidth/pixelPerTile;
    
    
}


-(void)findScaleForXTile
{
    if(xIsString){
        _scalingX=_gridWidth/([_xElements count]-1);
        return;
    }
    
    int VerLines=_gridWidth/_tileWidth;
    float maxX=[self findMaximumValue:_xElements];
    float pixelPerTile=maxX/(VerLines-1);
    int countDigits=[[NSString stringWithFormat:@"%.0f",pixelPerTile] length];
    
    //New Pixel per tile swould be
    pixelPerTile=pixelPerTile/pow(10, countDigits-1);
    pixelPerTile=ceilf(pixelPerTile);
    pixelPerTile=pixelPerTile*pow(10, countDigits-1);
    
    
    _scalingX=_tileWidth/pixelPerTile;

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






-(void)drawWallGraph
{
   
    [self setNeedsDisplay];
    [self drawAnchorPoints];

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(ctx, true);
    CGContextSetShouldAntialias(ctx, true);
    
    CGAffineTransform flipTransform = CGAffineTransformMake( 1, 0, 0, -1, 0, self.frame.size.height);
    CGContextConcatCTM(ctx, flipTransform);
  
    
    [self drawBgPattern:ctx];
    [self drawVerticalBgLines:ctx];
    [self drawHorizontalBgLines:ctx];
    
    
    [self drawThePattern:ctx];
    
    CGContextBeginPath(ctx);

    CGContextMoveToPoint(ctx,0,0);
    if(isShadow)
    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0,1.0), 3.0, [UIColor blackColor].CGColor);
    
    
    if(xIsString)
    {
        int k=0;
        

        
        

        
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,i*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
            k++;
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,(k-1)*_scalingX , 0);
    
    
    }
    else
    {
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
    }
    
     CGContextClosePath(ctx);

    
    
    int totalColors=[MIMColor sizeOfColorArray];
    
    if(isGradient)
    {
        CGContextClip(ctx);

        
        NSDictionary *lColor=[MIMColor GetColorAtIndex:(style+1)%totalColors];
        float red=[[lColor valueForKey:@"red"] floatValue];
        float green=[[lColor valueForKey:@"green"] floatValue];
        float blue=[[lColor valueForKey:@"blue"] floatValue];

        
        NSDictionary *dColor=[MIMColor GetColorAtIndex:(style)%totalColors];
        
        float dred=[[dColor valueForKey:@"red"] floatValue];
        float dgreen=[[dColor valueForKey:@"green"] floatValue];
        float dblue=[[dColor valueForKey:@"blue"] floatValue];
        
        
        
        
        CGGradientRef glossGradient;
        CGColorSpaceRef rgbColorspace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { dred, dgreen, dblue, 0.7,  // Start color
            red,green,blue, 0.7 }; // Mid color and End color
        rgbColorspace = CGColorSpaceCreateDeviceRGB();
        glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
        
        
        
        CGPoint start = CGPointMake(0,0); 
        CGPoint end = CGPointMake(0, maxOfY*_scalingY);
        CGContextDrawLinearGradient(ctx, glossGradient, end ,start , kCGGradientDrawsBeforeStartLocation);
        
        CGColorSpaceRelease(rgbColorspace);
        CGGradientRelease(glossGradient);
        
        //Draw the line on the top edge of the wall
        [self drawWallEdge:ctx WithColors:dColor];

        
    }
    else
    {
        NSDictionary *lColor=[MIMColor GetColorAtIndex:(style)%totalColors];
        float red=[[lColor valueForKey:@"red"] floatValue];
        float green=[[lColor valueForKey:@"green"] floatValue];
        float blue=[[lColor valueForKey:@"blue"] floatValue];
        UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:0.7];
        CGContextSetFillColorWithColor(ctx, _color.CGColor);

        CGContextDrawPath(ctx, kCGPathFillStroke);
        
        
        //Draw the line on the top edge of the wall
        [self drawWallEdge:ctx WithColors:lColor];

    
    }
   

   
    
   
    
    CGContextFlush(ctx);
}


-(void)drawBgPattern:(CGContextRef)ctx
{
    //Draw the background with the gray Gradient
    CGFloat BGLocations[2] = { 0.0, 1.0 };
    CGFloat BgComponents[8] = { 1.0, 1.0, 1.0 , 1.0,  // Start color
        0.9, 0.9, 0.9 , 1.0 }; // Mid color and End color
    CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef bgRadialGradient = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 2);
    
    
    CGPoint startBg = CGPointMake(_gridWidth/2,_gridHeight/2); 
    CGFloat endRadius=MAX(_gridWidth/2, _gridHeight/2);
    
    
    CGContextDrawRadialGradient(ctx, bgRadialGradient, startBg, 0, startBg, endRadius, kCGGradientDrawsAfterEndLocation);
    CGColorSpaceRelease(BgRGBColorspace);
    CGGradientRelease(bgRadialGradient);

}


-(void)drawVerticalBgLines:(CGContextRef)ctx
{
    
    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7].CGColor);
    CGContextSetLineWidth(ctx, 0.1);
    
    int numVertLines;
    
    if(xIsString)
        numVertLines=_gridWidth/([_xElements count]-1);
    else
        numVertLines=0;
    
    
    for (int i=0; i<numVertLines; i++) {
        
        CGContextMoveToPoint(ctx, i*_tileWidth,0);
        CGContextAddLineToPoint(ctx, i*_tileWidth,_gridHeight);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    


}

-(void)drawHorizontalBgLines:(CGContextRef)ctx
{
    
    //Draw Gray Lines as the markers
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7].CGColor);
    CGContextSetLineWidth(ctx, 0.1);
    int numHorzLines=_gridHeight/_tileWidth;
    for (int i=0; i<numHorzLines; i++) {
        
        CGContextMoveToPoint(ctx, 0,i*_tileWidth);
        CGContextAddLineToPoint(ctx,_gridWidth , i*_tileWidth);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    
    
    
    
}

-(void)drawWallEdge:(CGContextRef)ctx WithColors:(NSDictionary *)dColor
{

    float dred=[[dColor valueForKey:@"red"] floatValue];
    float dgreen=[[dColor valueForKey:@"green"] floatValue];
    float dblue=[[dColor valueForKey:@"blue"] floatValue];
    
    
    
    CGContextSetLineWidth(ctx, 3.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:dred green:dgreen blue:dblue alpha:1.0].CGColor);
    
    if(xIsString)
    {
        
        CGContextMoveToPoint(ctx, 0, [[_yElements objectAtIndex:0] floatValue]*_scalingY);
        int k=1;
        for (int i=1; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,k*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
            k++;
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,(k-1)*_scalingX , 0);
        
        
    }
    else
    {
        CGContextMoveToPoint(ctx, [[_xElements objectAtIndex:0] intValue]*_scalingX, [[_yElements objectAtIndex:0] floatValue]*_scalingY);
        
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
    }
    
    
    
    CGContextStrokePath(ctx);
}


-(void)drawThePattern:(CGContextRef)ctx
{
    
    CGContextBeginPath(ctx);
    CGContextSetFillColorWithColor(ctx,[UIColor colorWithPatternImage:[UIImage imageNamed:@"lines1.png"]].CGColor);
    CGContextMoveToPoint(ctx, 0, 0);
    
    
    
    if(xIsString)
    {
        int k=0;
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,k*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
            k++;
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,(k-1)*_scalingX , 0);
        
        
    }
    else
    {
        for (int i=0; i<[_xElements count]; i++) {
            
            CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:i] intValue]*_scalingX , [[_yElements objectAtIndex:i] floatValue]*_scalingY);
        }
        
        //Add the last point at the bottom of y axis.
        CGContextAddLineToPoint(ctx,[[_xElements objectAtIndex:([_xElements count]-1)] intValue]*_scalingX , 0);
    }
    
    
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFill);


}

#pragma mark - Anchor Points


-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point
{
    
    //Find if the AnchorInfo at that tag is already displaying
    for (id view in self.subviews) {
        if([view isKindOfClass:[AnchorInfo class]])
            if([(AnchorInfo *)view displaying] &&([(AnchorInfo *)view tagID]==tagID)){
                [view removeFromSuperview];
                return;
            }
        
    }
    
    
    float anchorY=[[_yElements objectAtIndex:tagID] floatValue];
    
    AnchorInfo *aInfo=[[AnchorInfo alloc]initWithFrame:CGRectMake(point.x-10, point.y-30, 320, 20)];
    [aInfo setTagID:tagID];
    
    if(xIsString)
        [aInfo setInfoString:[NSString stringWithFormat:@"(%@,%.0f)",[_xElements objectAtIndex:tagID],anchorY]];
    else
        [aInfo setInfoString:[NSString stringWithFormat:@"(%.0f,%.0f)",[[_xElements objectAtIndex:tagID] floatValue],anchorY]];
    
    
    
    
    [self addSubview:aInfo];
    [aInfo setNeedsDisplay];
}

-(void)drawAnchorPoints
{
    int totalColors=[MIMColor sizeOfColorArray];
    
    if(xIsString)
    {
        
        for (int i=0; i<[_xElements count]; i++) 
        {
            
            float newX=i*_scalingX;
            float newY=_gridHeight-[[_yElements objectAtIndex:i] intValue]*_scalingY;
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);
            _anchor.originalPoint=CGPointMake(newX,newY);
            _anchor.type=anchorType;
            _anchor.enabled=YES;
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
            
            
            
            
            _anchor.color=_color;
            _anchor.isShadow=isShadow;
            _anchor.idTag=i;
            _anchor.delegate=self;
            [self addSubview:_anchor];
        }
        
    }
    else
    {
        
        
        for (int i=0; i<[_xElements count]; i++) {
            
            float newX=[[_xElements objectAtIndex:i] intValue]*_scalingX;
            float newY=_gridHeight-[[_yElements objectAtIndex:i] intValue]*_scalingY;
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);
            _anchor.originalPoint=CGPointMake(newX,newY);
             _anchor.type=anchorType;
            _anchor.enabled=YES;
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
            
            
            
            
            _anchor.color=_color;
            _anchor.isShadow=isShadow;
            _anchor.idTag=i;
            _anchor.delegate=self;
            [self addSubview:_anchor];
        }
    }
    
    
    
}

-(void)setNewYForAnchor
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    float movedY=[userDefault floatForKey:@"pointy"];
    NSInteger tagID=[userDefault integerForKey:@"id"];
    movedY=_gridHeight-movedY;    
    [_yElements replaceObjectAtIndex:tagID withObject:[NSString stringWithFormat:@"%f",movedY/_scalingY]];
    [self setNeedsDisplay];
}


- (void)dealloc
{
    [super dealloc];
}

@end
