//
//  DetailPopOverStyle2.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface DetailPopOverStyle2 : UIView
{
    PIE_DETAIL_POPUP_TYPE detailPopUpType;
    NSTimer *timer;
    float alpha;
    BOOL roundedCorner;
    DIRECTION arrowDirection;
    
    NSString *ptitle;
    NSString *icon;
    NSString *summary;
    NSString *detail;
    
    
    
    @private
    UILabel *titleLabelBg;
    UILabel *titleLabel;
    UIImageView *iconImg;
    UILabel *descriptionLabel;
    UIImageView *bgView;
    CGRect rrect;
    CGRect gRect;
    
}

@property(nonatomic,assign)PIE_DETAIL_POPUP_TYPE detailPopUpType;
@property(nonatomic,assign)BOOL roundedCorner;
@property(nonatomic,assign)DIRECTION arrowDirection;

@property(nonatomic,retain)NSString *ptitle;
@property(nonatomic,retain)NSString *icon;
@property(nonatomic,retain)NSString *summary;
@property(nonatomic,retain)NSString *detail;

-(void)setTheValues;
-(void)createTheView;

-(void)StartTimerForShowingText;
-(void)initAlpha;
@end
