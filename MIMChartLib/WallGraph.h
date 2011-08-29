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
//  WallGraph.h
//  MIM3D
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Anchor.h"

@interface WallGraph : UIView {
    
    BOOL needStyleSetter;
    UIButton *styleButton;
    UILabel *styleLabel;
    int style;
    
    float pixelsPerTile;
    int numOfHLines;
    
    @private
    NSMutableArray *_yElements;
    NSMutableArray *_xElements;
    float _gridWidth;
    float _gridHeight;
    float _scalingX;
    float _scalingY;
    float _tileWidth;//Same will be the _tileHeight
    float maxOfY;
    BOOL xIsString;
    BOOL isGradient;
    BOOL isShadow;
    UIImage *patternImage;
    ANCHORTYPE anchorType;
}

@property(nonatomic,assign)BOOL xIsString;
@property(nonatomic,assign)BOOL isGradient;
@property(nonatomic,assign)BOOL needStyleSetter;
@property(nonatomic,assign)BOOL isShadow;
@property(nonatomic,assign) int style;
@property(nonatomic,retain) UIImage *patternImage;
@property(nonatomic,assign) ANCHORTYPE anchorType;
-(void)initAll;
-(int)findMaximumValue:(NSArray *)array;
-(void)populateXandYFromUserInput;
-(void)CalculateGridDimensions;
-(void)ScalingFactor;
-(void)FindTileWidth;
-(float)FindMaxOfY;
-(float)FindScaleOfX;

-(void)displayYAxis;

-(void)findScaleForYTile:(float)screenHeight;
-(void)findScaleForXTile;

-(void)drawWallGraph;
-(void)drawAnchorPoints;
-(void)setNewYForAnchor;

-(void)readFromCSV:(NSString *)csvPath  TitleAtColumn:(int)tColumn  DataAtColumn:(int)dColumn;

//AnchorMenu
-(void)displayAnchorInfo:(NSInteger)tagID At:(CGPoint)point;
-(void)RemoveAnchorInfo:(NSInteger)tagID;

-(void)drawThePattern:(CGContextRef)ctx;
-(void)drawWallEdge:(CGContextRef)ctx WithColors:(NSDictionary *)dColor;
-(void)drawBgPattern:(CGContextRef)ctx;
-(void)drawVerticalBgLines:(CGContextRef)ctx;
-(void)drawHorizontalBgLines:(CGContextRef)ctx;
@end
