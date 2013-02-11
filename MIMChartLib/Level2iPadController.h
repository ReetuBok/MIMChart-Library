//
//  Level2iPadController.h
//  MIMChartLib
//
//  Created by Reetu Raj on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListBasicPieCharts.h"
#import "ListBevelPieCharts.h"
#import "ListPaddedPieCharts.h"
#import "ListBiTransPieChart.h"
#import "ListSectionedPieCharts.h"

#import "ChartAnimation.h"

#import "DefaultDetailView.h"
#import "DetailViewStyle2.h"
#import "DetailViewStyle3.h"
#import "UserDefinedDetailView.h"

#import "DefaultInfoBoxTestClass.h"
#import "InfoBoxStyle1TestClass.h"
#import "InfoBoxStyle2TestClass.h"


#import "TestLineClass.h"
#import "TestLineClass2.h"


#import "TestClassFragmented.h"

#import "WallTestClass.h"



#import "BarTestClass.h"
#import "GroupBarTestClass.h"
#import "StackedBarTestClass.h"
#import "MultipleBarViews.h"

#import "GaugeGraphTestClass.h"
#import "RangeGraphTestClass.h"


@interface Level2iPadController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    NSArray *chartTypeSectionArray;
    NSArray *featureListCellArray;
    NSString *titleString;
}
@property(nonatomic,retain)NSString *titleString;
@end
