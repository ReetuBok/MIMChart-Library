//
//  MIMWallGraph.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallGraphDelegate.h"
#import "Constant.h"
#import "MultiWallLongGraph.h"

@interface MIMWallGraph : UIView<AnchorDelegate,MIMMeterDelegate>
{
    BOOL fitsToScreenWidth; 
    BOOL isGradient;
    BOOL displayMeterline;
    float meterLineYOffset;
    
    X_TITLES_STYLE xTitleStyle;
    MIMColorClass *mbackgroundColor;
    
    id<WallGraphDelegate>delegate;
    
    NSArray *anchorTypeArray;    
    
    NSArray *wallColorArray;
    NSArray *wallGradientArray;
    BOOL minimumLabelOnYIsZero;
    UILabel *titleLabel;

    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
    MIMFloatingView *floatingView;

}

@property(nonatomic,retain)id<WallGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)BOOL isGradient;
@property(nonatomic,assign)BOOL displayMeterline;
@property(nonatomic,assign)float meterLineYOffset;

@property(nonatomic,assign)X_TITLES_STYLE xTitleStyle;
@property(nonatomic,retain)MIMColorClass *mbackgroundColor;

@property(nonatomic,retain)NSArray *anchorTypeArray;   
@property(nonatomic,retain)NSArray *wallColorArray;
@property(nonatomic,retain)NSArray *wallGradientArray;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,retain)UILabel *titleLabel;


@property(nonatomic,assign)float rightMargin;
@property(nonatomic,assign)float topMargin;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;
-(void)drawMIMWallGraph;

@end
