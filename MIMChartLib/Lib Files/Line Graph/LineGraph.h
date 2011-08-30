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
//  LineGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Anchor.h"
#import "AnchorInfo.h"
#import "MIMColor.h"
#import "LineInfoBox.h"
#import "YAxisBand.h"
#import "XAxisBand.h"



@interface LineGraph : UIView {
    
@private
    NSMutableArray *myPathArray; //UIBezierPath *myPath;Array
    NSString *filePath;
    NSMutableArray *_yElements;
    NSMutableArray *_xElements;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;//Same will be the _tileHeight
    float maxOfY;
    BOOL xIsString;
    NSMutableArray *colorArray;
    
    BOOL needStyleSetter;
    UIButton *styleButton;
    UILabel *styleLabel;

    
    int style;
    float pixelsPerTile;
    int numOfHLines;
    ANCHORTYPE anchorType;

    int xColumn;
}

@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign)ANCHORTYPE anchorType;
@property(nonatomic,assign)    BOOL  needStyleSetter;
@property(nonatomic,assign) int style;
-(void)initAll;
-(int)findMaximumValue:(NSArray *)array;
-(void)CalculateGridDimensions;
-(void)ScalingFactor;
-(void)FindTileWidth;
-(float)FindMaxOfY;
-(float)FindScaleOfX;


-(void)findScaleForYTile:(float)screenHeight;
-(void)findScaleForXTile;
-(float)FindBestScaleForGraph;



-(void)setNewYForAnchor;

-(void)readFromCSV:(NSString*)path valueColumnsinRange:(NSArray *)rangeArray;
-(void)readFromCSV:(NSString*)path titleAtColumn:(NSInteger)tColumn valueInColumn:(NSArray *)range;
-(void)readFromCSV:(NSString*)path xInColumn:(NSArray *)XColumn yInColumn:(NSArray *)YColumn;

//AnchorMenu
-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point;
-(void)drawAnchorPoints;

-(void)drawWallGraph;
-(void)drawBgPattern:(CGContextRef)ctx;
-(void)drawVerticalBgLines:(CGContextRef)ctx;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;

-(void)displayYAxis;
-(void)displayXAxisWithStyle:(int)xstyle;
@end
