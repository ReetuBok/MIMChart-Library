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
//  MIMPieChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum
{
    REDTINT,
    GREENTINT,
    BEIGETINT
    

}TINTCOLOR;

@interface MIMPieChart : UIView {
    
    float radius;

    BOOL valuesReadFromCSV;
    NSMutableArray *valueArray;
    UIColor *backgroundColor;
    BOOL enableBottomTitles;
    NSMutableArray *titleArray;
    NSInteger tintValue;
    
    @private
    float _centerX;
    float _centerY;
    NSMutableArray *angleArrays;
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    TINTCOLOR tint;
    
    
}
@property(nonatomic,assign)float radius;
@property(nonatomic,assign)NSInteger tintValue;
@property(nonatomic,retain)UIColor *backgroundColor;
@property(nonatomic,assign)BOOL enableBottomTitles;
@property(nonatomic,retain)NSMutableArray *titleArray;
@property(nonatomic,assign) TINTCOLOR tint;

-(void)findCenter;
-(void)readFromCSV:(NSString*)path  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dcolumn;
-(void)drawPieChart;
-(void)drawBottomTitlesText;
-(int)findQuadrant:(CGPoint)touchPoint;

@end
