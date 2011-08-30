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
//  BarChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MIMColor.h"
#import "YAxisBand.h"
#import "XAxisBand.h"


@interface BarChart : UIView {
    
    
    float barWidth;
    float pixelsPerTile;
    int numOfHLines;
    
    BOOL groupBars;
    NSMutableArray *colorArray;
    NSString *filePath;
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    BOOL xIsString;
    float maxOfY;
    
    NSMutableArray *_yElements;
    NSMutableArray *_xElements;
    NSMutableArray *_yValElements;
    NSMutableArray *_xValElements;
    
    BOOL isGradient;
    BOOL horizontalGradient;
    
    int style;
    BOOL needStyleSetter;
    UIButton *styleButton;
    UILabel *styleLabel;
    
    int xColumn;
    
}
@property(nonatomic,assign)    BOOL groupBars;
@property(nonatomic,assign) BOOL xIsString;
@property(nonatomic,assign) float barWidth;
@property(nonatomic,assign) BOOL needStyleSetter;
@property(nonatomic,assign) int style;
@property(nonatomic,assign)    BOOL isGradient;
@property(nonatomic,assign)BOOL horizontalGradient;
-(void)drawBarGraph;

//Scale
-(void)displayYAxis;
-(void)displayXAxisWithStyle:(int)xstyle;


-(void)initAll;
-(float)findMaximumValue:(NSArray *)array;


-(void)CalculateGridDimensions;
-(void)ScalingFactor;
-(void)FindTileWidth;
-(float)FindMaxOfY;
-(float)FindScaleOfX;

-(void)addSetterButton;


-(void)findScaleForYTile:(float)screenHeight;
-(void)findScaleForXTile;
-(float)FindBestScaleForGraph;


-(void)readFromCSV:(NSString*)csvPath  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dColumn;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;

//draw
-(void)drawBg:(CGContextRef)context;



@end
