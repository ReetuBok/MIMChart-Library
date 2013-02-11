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
#import "MIMMargin.h"

@interface MIMWallGraph : UIView<AnchorDelegate,MIMMeterDelegate>
{
    BOOL fitsToScreenWidth; 
    BOOL isGradient;
    BOOL displayMeterline;
    float meterLineYOffset;
    
    XTitleStyle xTitleStyle;
    MIMColorClass *mbackgroundColor;
    
    id<WallGraphDelegate>delegate;
    
    NSArray *anchorTypeArray;    
    
    NSArray *wallColorArray;
    NSArray *wallGradientArray;
    BOOL minimumLabelOnYIsZero;
    UILabel *titleLabel;

    MIMMargin margin;
        
    MIMFloatingView *floatingView;

}

@property(nonatomic,retain)id<WallGraphDelegate>delegate;
@property(nonatomic,assign)BOOL fitsToScreenWidth;
@property(nonatomic,assign)BOOL isGradient;
@property(nonatomic,assign)BOOL displayMeterline;
@property(nonatomic,assign)float meterLineYOffset;

@property(nonatomic,assign)XTitleStyle xTitleStyle;
@property(nonatomic,retain)MIMColorClass *mbackgroundColor;

@property(nonatomic,retain)NSArray *anchorTypeArray;   
@property(nonatomic,retain)NSArray *wallColorArray;
@property(nonatomic,retain)NSArray *wallGradientArray;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,retain)UILabel *titleLabel;

@property(nonatomic,assign)MIMMargin margin;

-(void)drawMIMWallGraph;

@end
