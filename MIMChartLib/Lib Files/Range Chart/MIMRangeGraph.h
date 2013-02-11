//
//  MIMRangeChart.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import <UIKit/UIKit.h>
#import "RangeGraphDelegate.h"
#import "Constant.h"
#import "MIMLongRangeGraph.h"

@interface MIMRangeGraph : UIView
{
    id<RangeGraphDelegate>delegate;

    
    NSMutableArray *anchorTypeArray;//ANCHORTYPE
    XTitleStyle xTitleStyle;//
    MIMColorClass *mbackgroundColor;
    NSArray *rangeColorArray;//Make a color Array too.
    BOOL minimumLabelOnYIsZero;
    UILabel *titleLabel;
    float rangeLineThickness;
    
    float rightMargin;
    float topMargin;
    float leftMargin;
    float bottomMargin;
}

@property(nonatomic,retain)id<RangeGraphDelegate>delegate;

@property(nonatomic,assign)XTitleStyle xTitleStyle;
@property(nonatomic,retain)NSMutableArray *anchorTypeArray;
@property(nonatomic,retain)MIMColorClass *mbackgroundColor;
@property(nonatomic,retain)NSArray *rangeColorArray;
@property(nonatomic,assign)BOOL minimumLabelOnYIsZero;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,assign)float rangeLineThickness;

@property(nonatomic,assign)float rightMargin;
@property(nonatomic,assign)float topMargin;
@property(nonatomic,assign)float leftMargin;
@property(nonatomic,assign)float bottomMargin;

-(void)drawMIMRangeGraph;
@end
