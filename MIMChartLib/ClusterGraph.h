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
//  ClusterGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 17/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ClusterGraph : UIView {
    
    NSMutableArray *_xElements;
    NSMutableArray *_yElements;
    float maxOfY;
    float _scalingX;
    float _scalingY;
    float _tileWidth;
    BOOL xIsString;
    
}

@property(nonatomic,assign)    BOOL xIsString;

-(void)ScalingFactor;
-(float)FindMaxOfY;
-(int)findMaximumValue:(NSArray *)array;
-(void)findScaleForYTile:(float)screenHeight;
-(void)findScaleForXTile;
-(void)drawBackGroundGradient:(CGContextRef)context;
-(void)drawClusterGraph;
-(void)readYValuesFromCSV:(NSString *)path  AtColumn:(int)column;
-(void)readXvaluesFromCSV:(NSString *)path  AtColumn:(int)column;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;
@end
