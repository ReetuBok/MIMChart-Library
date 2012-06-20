/*
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
 */

//
//  BasicPie.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/18/12.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMColorClass.h"
#import "MIMColor.h"
#import "DefaultPopOverForPieChart.h"
#import "Constant.h"
#import <QuartzCore/QuartzCore.h>

@interface BasicPie : UIView<UIGestureRecognizerDelegate>
{
    CGPoint center;
    float radius;
    float borderWidth;
    MIMColorClass *borderColor;
    BOOL glossEffect;
    TINTCOLOR tint;
    NSMutableArray *valueArray_;
    NSMutableArray *gradientArray_;
    NSMutableArray *colorArray_;
    NSMutableArray *angleArrays_;
    BOOL gradientActive;
    BOOL animation;
    BOOL userTouchAllowed;
    BOOL enableDoubleTap;//This is needed when user wants detail popup as well as info box
    BOOL enableShowDetailBox;
    BOOL enableBubbleBox;//Display bubbles
    
@private
    float lastRotation_;
    float netRotation_;
    UITapGestureRecognizer  *tapGesture;
    UITapGestureRecognizer  *dtapGesture;
    UIRotationGestureRecognizer *rotationGesture;
    float maxPForS1;
    float alpha;
    NSTimer *timer;
    int indexTapped;
    int afterTappingWhichDirectionToRotate;
    float Msum;
}

@property(nonatomic,assign)CGPoint center;
@property(nonatomic,assign)float radius;
@property(nonatomic,assign)float borderWidth;
@property(nonatomic,retain)MIMColorClass *borderColor;
@property(nonatomic,assign)BOOL glossEffect;
@property(nonatomic,assign)TINTCOLOR tint;
@property(nonatomic,retain)NSMutableArray *valueArray_;
@property(nonatomic,retain)NSMutableArray *gradientArray_;
@property(nonatomic,retain)NSMutableArray *colorArray_;
@property(nonatomic,retain)NSMutableArray *angleArrays_;
@property(nonatomic,assign)BOOL gradientActive;
@property(nonatomic,assign)BOOL animation;
@property(nonatomic,assign)BOOL userTouchAllowed;
@property(nonatomic,assign)BOOL enableDoubleTap;
@property(nonatomic,assign)BOOL enableShowDetailBox;
@property(nonatomic,assign)int afterTappingWhichDirectionToRotate;
@property(nonatomic,assign)BOOL enableBubbleBox;


-(void)initPie;

-(void)setUserTouchEnabled:(BOOL)enabled;
-(void)refreshPie;

//info box methods
-(void)rotatePieToIndex:(int)index whichDirection:(int)direction;

//Bubbles
-(int)getQuadrantAtIndex:(int)index;
-(CGPoint)getPointAtIndex:(int)index;
-(float)getSum;
@end
