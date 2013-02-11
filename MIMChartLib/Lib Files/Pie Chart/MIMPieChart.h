/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  MIMPieChart.h
//  MIMChartLib
//
//  Created by Reetu Raj on 10/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
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
    NSMutableArray *borderColorArray_;
    
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
@property(nonatomic,retain)NSMutableArray *borderColorArray_;

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
