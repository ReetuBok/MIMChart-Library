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
#import "Constant.h"


@interface MIMPieChart : UIView {
    
    float radius_;
    
    NSMutableArray *valueArray_;
    NSMutableArray *angleArrays_;
    NSMutableArray *titleArray_;
    NSMutableArray *colorArray_;
    
    NSArray *gradientArray_;
    NSArray *gradientTypeArray_;
    
    
    
    BOOL enableBottomTitles;
    BOOL glossEffect;
    float borderWidth_;
    NSInteger tintValue;
    
    
    //Background Related:
    CGGradientRef backgroundGradient;
    UIColor *backgroundColor;
    UIView *backgroundView;
    
    
    //Double Tap always brings out the detailed section view
    
    
    //Style variable
    //style 1: titles are given to the right on a scrollview. On highlighting, it pops up and eases out , user can define
    //position of scrollview being left or right. With each title there is a display detailed info button.
    //style 2: whenever a section of pie is touched, pie rotates to bring the touched section on top and a popup appears 
    //with display detailed info button on it.
    
    
    
    float centerX_;
    float centerY_;
    
    
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    TINTCOLOR tint;
    int stateOfPiece; // 1 is selected 2 is unselected.
    int previousStateOfPiece;// 1 is selected 2 is unselected.
    
    
    
}
@property(nonatomic,assign)float radius_;

@property(nonatomic,retain)NSMutableArray *valueArray_;
@property(nonatomic,retain)NSMutableArray *angleArrays_;
@property(nonatomic,retain)NSMutableArray *titleArray_;
@property(nonatomic,retain)NSMutableArray *colorArray_;


@property(nonatomic,retain)NSArray *gradientArray_;
@property(nonatomic,retain)NSArray *gradientTypeArray_;






@property(nonatomic,assign)NSInteger tintValue;

@property(nonatomic,assign)BOOL enableBottomTitles;
@property(nonatomic,assign)BOOL glossEffect;
@property(nonatomic,assign)float borderWidth_;


@property(nonatomic,assign) TINTCOLOR tint;

//Background Related:
@property(nonatomic,assign)CGGradientRef backgroundGradient;
@property(nonatomic,retain)UIColor *backgroundColor;
@property(nonatomic,retain)UIView *backgroundView;

//center Related
@property(nonatomic,assign)float centerX_;
@property(nonatomic,assign)float centerY_;


-(void)readFromCSV:(NSString*)path  TitleAtColumn:(int)tcolumn  DataAtColumn:(int)dcolumn;


/*
 Ok here user can send the values in Array like [NSArray arraywithObjects:@"21",@"55",@"120",@"45"]
 User can opt to send the titleArray:
 colorsArray should be array of MIMColor class.
 
 How to Add MIMColor Object:
 
 
 */
-(void)readFromArray:(NSArray*)valuearray  Title:(NSArray *)titlesArray  Color:(NSArray *)colorsArray;


-(void)drawPieChart;
-(void)drawBottomTitlesText;

-(float)returnSum:(NSArray *)array;


@end
