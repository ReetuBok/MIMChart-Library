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
//  LineGraph.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LineGraph.h"

@implementation LineGraph
@synthesize xIsString,anchorType,needStyleSetter,style;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        anchorType=CIRCLEBORDER;
    }
    return self;
}


#pragma mark - X and Y Axis stuff

-(void)displayYAxis
{
    
    YAxisBand *_yBand=[[YAxisBand alloc]initWithFrame:CGRectMake(-80,0, 80, CGRectGetHeight(self.frame))];
    [_yBand setScaleForYTile:pixelsPerTile withNumOfLines:numOfHLines];
    [self addSubview:_yBand];
    
    
}


-(void)displayXAxisWithStyle:(int)xstyle
{
    NSLog(@"filePath=%@",filePath);
    
    XAxisBand *_xBand=[[XAxisBand alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 100)];
    if(xIsString)
        [_xBand readTitleFromCSV:filePath AtColumn:xColumn];
    else
        [_xBand readTitleFromCSV:filePath];
    
    _xBand.xIsString=xIsString;
    _xBand.style=xstyle;
    _xBand.scalingFactor=[self FindBestScaleForGraph];
    _xBand.lineChart=YES;
    [self addSubview:_xBand];
    
}


/*This method is needed only if you use Style setter*/
-(IBAction)styleButtonClicked:(id)sender
{
    

   
    style=[sender tag]+1;
    
    
    
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



-(void)initAll
{
    
    
    srand(time(NULL));
    
    //[self drawLineInfoBox];
    [self FindTileWidth];
    [self CalculateGridDimensions];
    [self ScalingFactor];
    [self addSetterButton];
 
}
-(void)drawLineInfoBox
{
    LineInfoBox *box=[[LineInfoBox alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame), 0, 200, 400)];
    box.lineArray=[[NSMutableArray alloc]initWithArray:_xElements];
    [self addSubview:box];
}





-(void)CalculateGridDimensions
{
    
    _gridWidth=self.frame.size.width;
    _gridHeight=self.frame.size.height;
}


-(void)ScalingFactor
{

    maxOfY=[self findMaximumValue:_yValElements];
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

-(float)FindBestScaleForGraph
{
    
    return MAX(_scalingX, _scalingY);
    
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
        _scalingX=_gridWidth/[_yElements count];
        return;
    }
    
    int VerLines=_gridWidth/_tileWidth;
    float maxX=[self findMaximumValue:_xValElements];
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

#pragma  mark - Read from CSV


/*if range==nil, all the columns will be taken for drawing */
-(void)readFromCSV:(NSString*)path valueColumnsinRange:(NSArray *)rangeArray
{
    
    xColumn=0;
    
    _xElements=[[NSMutableArray alloc]init];
    
    
    //_xElements contains India,US,China etc
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    NSArray *columnArray=[[linesArray objectAtIndex:0] componentsSeparatedByString:@";"];
    
    filePath=[path retain];

    
    if(rangeArray==nil)
    {
        for (int k=1; k<[columnArray count]; k++) {
            [_xElements addObject:[columnArray objectAtIndex:k]];
        }
        
    }
    else
    {
        
        for (int k=0; k<[rangeArray count]; k++) {
            int _index=[[rangeArray objectAtIndex:k] intValue];
            [_xElements addObject:[columnArray objectAtIndex:_index]];
        }
    
    
    }
   
    
    
    
    
    
    _yElements=[[NSMutableArray alloc]init];
    
    
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    //start from 1 because first line has titles
    for (int i=1; i<[linesArray count]-1; i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
        [_yElements addObject:[columnArray objectAtIndex:0]];
        
    }
    
    
 
    
    
    
 
    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    myPathArray=[[NSMutableArray alloc]init];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    //Now Create Values Array
    if(rangeArray==nil)
    {
        
        for(int i=0;i<[_xElements count];i++)
        {

            
            for (int k=0; k<[linesArray count]-2; k++) {
                
            
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:i+1] floatValue];
                
                [_yValElements addObject:[NSNumber numberWithFloat:value]];
                [_xValElements addObject:[NSNumber numberWithFloat:k]];

            }
            
        }
        
        
        
    }
    else
    {
        
        
        for(int i=0;i<[rangeArray count];i++)
        {
        
            
            int _index=[[rangeArray objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:_index] floatValue];
                
                [_yValElements addObject:[NSNumber numberWithFloat:value]];
                [_xValElements addObject:[NSNumber numberWithFloat:k]];

                
            }
            
        }

    }
    
    
    [self initAll];
    
    
    
    //Now create Path Array
    if(rangeArray==nil)
    {
        
        for(int i=0;i<[_xElements count];i++)
        {
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=2.0;
            myPath.flatness=2.0;
            
            
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:i+1] floatValue];
           
                if(k==0)
                    [myPath moveToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                else
                    [myPath addLineToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                
                
                
                
            }
            
            
            
            [myPathArray addObject:myPath];
            
            
        }
        
        
        
    }
    else
    {
        
        
        for(int i=0;i<[rangeArray count];i++)
        {
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=2.0;
            myPath.flatness=2.0;
            myPath.miterLimit=5.0;
            
            int _index=[[rangeArray objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:_index] floatValue];
            
                
                if(k==0)
                    [myPath moveToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                else
                    [myPath addLineToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                
                
                
                
            }
            
            
            
            [myPathArray addObject:myPath];
            
            
        }
        
        
        
        
    }
    
    

    
}

-(void)readFromCSV:(NSString*)path titleAtColumn:(NSInteger)tColumn valueInColumn:(NSArray *)range
{

   
   
    
    xColumn=tColumn;
    
    _yElements=[[NSMutableArray alloc]init];
    
    
    //_xElements contains Jan, Feb, March
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    filePath=[path retain];
    
  
    for (int i=0; i<[linesArray count]-2; i++) 
    {
        NSArray *columnArray=[[linesArray objectAtIndex:i+1] componentsSeparatedByString:@";"];
        [_yElements addObject:[columnArray objectAtIndex:tColumn]];
 
    }
    
    
   
    
    //_xElements has data of how many lines and what lines represent
    _xElements=[[NSMutableArray alloc]init];
    
    if(range==nil)
    {
        NSLog(@"You can leave valueInColumn nil here");
        return;
        
    }
    else
    { 

        linesArray=[fileDataString componentsSeparatedByString:@"\n"];  
        NSArray *columnArray=[[linesArray objectAtIndex:0] componentsSeparatedByString:@";"];
        for (int k=0; k<[range count]; k++) 
        [_xElements addObject:[columnArray objectAtIndex:tColumn]];
    }

    
    //Now feed the real values of x and y 
    

    

    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    myPathArray=[[NSMutableArray alloc]init];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    //Now Create Values Array
    if(range==nil)
    {
        
       NSLog(@"You can leave valueInColumn nil here");
        
        
    }
    else
    {
        
        
        for(int i=0;i<[range count];i++)
        {
           
            
            int _index=[[range objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:_index] floatValue];
                
                [_yValElements addObject:[NSNumber numberWithFloat:value]];
                [_xValElements addObject:[NSNumber numberWithFloat:k]];
                
                
            }
            
        }
        
        
        
        
    }
    
    
    
    [self initAll];
    
    
    
    //Now Create Path
    if(range==nil)
    {
        
        NSLog(@"You can leave valueInColumn nil here");
        
        
    }
    else
    {
        
        
        for(int i=0;i<[range count];i++)
        {
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=2.0;
            myPath.flatness=2.0;
            myPath.miterLimit=5.0;
            
            int _index=[[range objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float value=[[columnArray objectAtIndex:_index] floatValue];
        
                
                if(k==0)
                    [myPath moveToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                else
                    [myPath addLineToPoint:CGPointMake(k*_scalingX , value*_scalingY)];
                
                
                
                
            }
            
            
            
            [myPathArray addObject:myPath];
            
            
        }
        
        
        
        
    }
    
}

-(void)readFromCSV:(NSString*)path xInColumn:(NSArray *)XColumn yInColumn:(NSArray *)YColumn
{

  
    
    
    filePath=[path retain];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray;
    
    //_xElements has data of how many lines and what lines represent
    _xElements=[[NSMutableArray alloc]init];
    
    if(XColumn==nil)
    {
        NSLog(@"You can leave valueInColumn nil here");
        return;
        
    }
    else
    { 
        
        linesArray=[fileDataString componentsSeparatedByString:@"\n"];  
        NSArray *columnArray=[[linesArray objectAtIndex:0] componentsSeparatedByString:@";"];
        for (int k=0; k<[XColumn count]; k++) 
            [_xElements addObject:[columnArray objectAtIndex:[[XColumn objectAtIndex:k]intValue]]];
    }
    
    
    //Now feed the real values of x and y 
    
    
    
    
    
    _yValElements=[[NSMutableArray alloc]init];
    _xValElements=[[NSMutableArray alloc]init];
    myPathArray=[[NSMutableArray alloc]init];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    //Now Create Values Array
    if(XColumn==nil)
    {
        
        NSLog(@"You can leave XColumn nil here");
        
        
    }
    else
    {
        
        
        for(int i=0;i<[XColumn count];i++)
        {
            
            
            int _indexX=[[XColumn objectAtIndex:i]intValue];
            int _indexY=[[YColumn objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
             
                
                [_yValElements addObject:[columnArray objectAtIndex:_indexY]];
                [_xValElements addObject:[columnArray objectAtIndex:_indexX]];
                
                
            }
            
        }
        
        
        
        
    }
    
    
    
    [self initAll];
    
    
    
    //Now Create Path
    if(XColumn==nil)
    {
        
        NSLog(@"You can leave XColumn nil here");
        
        
    }
    else
    {
        
        
        for(int i=0;i<[XColumn count];i++)
        {
            UIBezierPath *myPath=[[UIBezierPath alloc]init];
            myPath.lineWidth=2.0;
            myPath.flatness=2.0;
            myPath.miterLimit=5.0;
            
            int _indexX=[[XColumn objectAtIndex:i]intValue];
            int _indexY=[[YColumn objectAtIndex:i]intValue];
            
            for (int k=0; k<[linesArray count]-2; k++) {
                
                
                NSString *lineString=[linesArray objectAtIndex:k+1];
                NSArray *columnArray=[lineString componentsSeparatedByString:@";"];
                float valueX=[[columnArray objectAtIndex:_indexX] floatValue];
                float valueY=[[columnArray objectAtIndex:_indexY] floatValue];
                
                if(k==0)
                    [myPath moveToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY)];
                else
                    [myPath addLineToPoint:CGPointMake(valueX*_scalingX , valueY*_scalingY)];
                
                
                
                
            }
            
            
            
            [myPathArray addObject:myPath];
            
            
        }
        
        
        
        
    }

    
    

}




-(void)drawWallGraph
{
   
    
    [self setNeedsDisplay];
    [self drawAnchorPoints];
    
}

#pragma mark - draw Anchors

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
    
    int repCount=[_xValElements count]/[_xElements count]; //Number of anchors per line

    int totalColors=[MIMColor sizeOfColorArray];
 
    
    if(xIsString)
    {
        
        for (int i=0; i<[_xElements count]; i++){
        for (int j=0; j<[_yElements count]; j++) 
        {
            
            float newX=[[_xValElements objectAtIndex:(repCount * i)+j] floatValue]*_scalingX;
            float newY=_gridHeight-([[_yValElements objectAtIndex:(repCount * i)+j] floatValue]*_scalingY);
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);
            _anchor.type=anchorType;
            
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(i+style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
        
            
            
            
            _anchor.color=_color;
            _anchor.originalPoint=CGPointMake(newX,newY);
            _anchor.idTag=j;
            _anchor.delegate=self;
            [self addSubview:_anchor];
        }

        }
        
    }else{
        
        int elementsInEachLine=[_xValElements count]/[_xElements count];
        for (int j=0; j<[_xElements count]; j++)
        for (int i=0; i<elementsInEachLine; i++) {
            
            float newX=[[_xValElements objectAtIndex:i+(j*elementsInEachLine)] intValue]*_scalingX;
            float newY=_gridHeight-[[_yValElements objectAtIndex:i+(j*elementsInEachLine)] intValue]*_scalingY;
            Anchor *_anchor=[[Anchor alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            _anchor.center=CGPointMake(newX,newY);
            
            _anchor.type=anchorType;
            
            NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(j+style)%totalColors];
            float red=[[_colorDic valueForKey:@"red"] floatValue];
            float green=[[_colorDic valueForKey:@"green"] floatValue];
            float blue=[[_colorDic valueForKey:@"blue"] floatValue];
            UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
            
            
            
            _anchor.color=_color;
            _anchor.originalPoint=CGPointMake(newX,newY);
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


#pragma  mark - DRAW

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

    
    

    int totalColors=[MIMColor sizeOfColorArray];

    
    for(int i=0;i<[_xElements count];i++)
    {
        NSDictionary *_colorDic=[MIMColor GetColorAtIndex:(i+style)%totalColors];
        float red=[[_colorDic valueForKey:@"red"] floatValue];
        float green=[[_colorDic valueForKey:@"green"] floatValue];
        float blue=[[_colorDic valueForKey:@"blue"] floatValue];
        UIColor *_color=[[UIColor alloc]initWithRed:red green:green blue:blue alpha:1.0]; 
        
        [_color setStroke];
        
        UIBezierPath *myPath=[myPathArray objectAtIndex:i];
        [myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    }
    
    
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
    float scaleV=[self FindBestScaleForGraph];
    //Draw the Vertical ones
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7].CGColor);
    CGContextSetLineWidth(ctx, 0.1);
    int numVertLines=_gridWidth/scaleV;
    for (int i=0; i<numVertLines; i++) {
        
        CGContextMoveToPoint(ctx, i*scaleV,0);
        CGContextAddLineToPoint(ctx, i*scaleV,_gridHeight);
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




- (void)dealloc
{
    [super dealloc];
}

@end
