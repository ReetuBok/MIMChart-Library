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
//  FragmentedBarChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FragmentedBarChart : UIView {
    
    
    BOOL xIsString;
    
    NSMutableArray *_xElements;
    NSMutableArray *_yElements;
    NSString *filePath;
    NSMutableArray *valuesArray;
    float maxOfY;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    NSMutableArray *colorArray;
    int numOfHLines;
    float pixelsPerTile;
    int style;
    BOOL needStyleSetter;
    UIButton *styleButton;
    UILabel *styleLabel;
    BOOL isGradient;
    
    float barWidth;
}

@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign) int style;
@property(nonatomic,assign) BOOL needStyleSetter;
@property(nonatomic,assign) BOOL isGradient;
@property(nonatomic,assign) float barWidth;

-(float)FindMaxOfY;
-(float)FindBestScaleForGraph;
-(void)readTitlesFromCSV:(NSString*)path;
-(void)drawFragmentedBarGraph;
-(void)drawBackGroundGradient:(CGContextRef)context;
-(void)drawHorizontalBgLines:(CGContextRef)context;

-(void)displayYAxis;
-(void)displayXAxisWithTitleFromColumn:(int)column Style:(int)xstyle;
@end
