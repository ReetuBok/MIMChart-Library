//
//  BasicPieChart.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMPieChartDelegate.h"
#import "MIMColorClass.h"
#import "MIMColor.h"
#import "DefaultPopOverForPieChart.h"
#import "BasicPie.h"
#import "Constant.h"
#import "DetailPopOverStyle2.h"
#import <QuartzCore/QuartzCore.h>
#import "DefaultInfoBox.h"
#import "InfoBoxStyle1.h"
#import "PieBubble.h"

@class InfoBoxStyle1;

@interface BasicPieChart : UIView<UIGestureRecognizerDelegate>
{
    
    BasicPie *pie;
    float sumOfValues;
    
    
    //USER WILL DEFINE
    //ALL THESE PROPERTIES.
    
    id<MIMPieChartDelegate> delegate; 
    
    DIRECTION arrowDirection;//Defines direction of Arrow of detail popUp.
    ALIGNMENT alignment;//Defines Alignment of Pie Itself.
    
    
    CGPoint offSetMargin; //User can define the margin between top border and left border and pie itself.
    float borderWidth;
    MIMColorClass *borderColor;
    BOOL glossEffect;
    TINTCOLOR tint;
    PIE_DETAIL_POPUP_TYPE detailPopUpType;
    BOOL animation;
    
    //This bool handles whether the direction indicator triangle  will be displayed in popup or not.
    //default is NO
    BOOL hidePopUpArrow; 
    
    //This bool handles whether there will be shadow behind detail view pop up.
    //Default is YES
    BOOL shadowBehindPopUp;
    
    
    //This lets user touch the pieChart, rotate it.    
    BOOL userTouchAllowed;
    
    
    //PopUp will have rounded corners
    BOOL detailPopUpRoundedCorner;
    
    //The default triangle can be white/black
    //Otherwise user need to hidePopUpArrow and 
    //make one of its own in detail viewForPopUpAtIndex
    
    POPUP_ARROW_TINT_STYLE popUpArrowTintStyle;
    
    BOOL dropShadowOnRoad;
    
    
    //-------------------Info Box Vairiables-------------------
    BOOL showInfoBox;
    INFOBOX_STYLE infoBoxStyle;
    CGSize infoBoxSize;
    UIFont *fontName;
    MIMColorClass *fontColor;
    BOOL shadowBehindBoxes;
    BOOL infoBoxSmoothenCorners;
    CGPoint infoBoxOffset;
    //ALIGNMENT infoBoxAlignment; //THis alignemnt should derieve from Pie Chart's self alignment
    //otherwise you can use Offset anyways
    
    
    //-------------------Bubbles-------------------
    BOOL showPercentBubbles;
    PIE_BUBBLE_STYLE bubbleStyle;
    BOOL showAllBubbles;
    
    @private
    
    int selectedPie;
    BOOL returnBackToOriginalLocation;
    BOOL gradientActive;

    
    UIPopoverController *popOver_;
    
    CGRect pieOriginalFrame;
    MIMColorClass *bgColor;
    NSInteger delayForIntroductionAnimation;
    
    
    DefaultPopOverForPieChart *defaultpopUp;
    DetailPopOverStyle2 *popUp;
    
    NSArray *pieTitleArray;
    NSArray *pieDescArray;
    NSArray *pieImageNameArray;
    
    //Info box
    InfoBoxStyle1 *infoboxStyle_1;
    NSArray *showBubbleOnIndices;
    
    
}
@property (nonatomic,assign)float sumOfValues;
@property (nonatomic,retain) id<MIMPieChartDelegate> delegate;
@property (nonatomic,assign)float borderWidth;
@property (nonatomic,retain)MIMColorClass *borderColor;
@property (nonatomic,assign)BOOL glossEffect;
@property (nonatomic,assign)TINTCOLOR tint;
@property (nonatomic,assign)CGPoint offSetMargin;
@property (nonatomic,assign)DIRECTION arrowDirection;
@property (nonatomic,assign)PIE_DETAIL_POPUP_TYPE detailPopUpType;
@property (nonatomic,assign)BOOL animation;
@property (nonatomic,assign)BOOL hidePopUpArrow;
@property (nonatomic,assign)POPUP_ARROW_TINT_STYLE popUpArrowTintStyle;
@property (nonatomic,assign)BOOL userTouchAllowed;
@property (nonatomic,assign)BOOL detailPopUpRoundedCorner;
@property (nonatomic,assign)BOOL dropShadowOnRoad;

//Info BOX
@property (nonatomic,assign)BOOL showInfoBox;
@property (nonatomic,assign)INFOBOX_STYLE infoBoxStyle;
@property (nonatomic,assign)CGSize infoBoxSize;
@property (nonatomic,retain)UIFont *fontName;
@property (nonatomic,retain)MIMColorClass *fontColor;
@property (nonatomic,assign)BOOL shadowBehindBoxes;
@property (nonatomic,assign)CGPoint infoBoxOffset;
@property (nonatomic,assign)BOOL infoBoxSmoothenCorners;


//Bubbles
@property (nonatomic,assign)BOOL showPercentBubbles;
@property (nonatomic,assign)PIE_BUBBLE_STYLE bubbleStyle;
@property (nonatomic,assign)BOOL showAllBubbles;


-(void)drawPieChart;
-(void)hideThePopOver;
-(void)displayThePopOver:(int)indexTapped;
-(BOOL)getAnimationValue;
-(void)showBubbleAtAllIndices;


-(void)setAnimationWithDelay:(NSInteger)time;


-(void)rotatePieToIndex:(int)index whichDirection:(int)direction;
-(void)setOffsetOfInfoBoxStyleToIndex:(int)index;


//Bubble
-(void)showBubbleAtPoint:(CGPoint)point AtIndex:(int)index inQuadrant:(int)quadrant;
-(void)showBubbleAtIndices:(NSArray*)indices;
@end
