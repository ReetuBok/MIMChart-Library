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
//  XAxisBand.h
//  MIM3D
//
//  Created by Reetu Raj on 08/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface XAxisBand : UIView {
    
    NSMutableArray *xElements;
    float multipleOf;
    float _tileWidth;
    float _gridWidth;
    float scalingFactor;
    int style;
    BOOL lineChart;
    BOOL xIsString;

}
@property(nonatomic,retain) NSMutableArray *xElements;
@property(nonatomic,assign) float multipleOf;
@property(nonatomic,assign) float scalingFactor;
@property(nonatomic,assign) int style;
@property(nonatomic,assign)   BOOL lineChart;
@property(nonatomic,assign)    BOOL xIsString;

-(void)drawXAxis:(CGContextRef)ctx;
-(void)readTitleFromCSV:(NSString*)path AtColumn:(int)column;
-(void)readTitleFromCSV:(NSString*)path;
@end
