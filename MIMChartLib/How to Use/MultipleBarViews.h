//
//  MultipleBarViews.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMBarGraph.h"

@interface MultipleBarViews : UIViewController<UIPickerViewDelegate,BarGraphDelegate>
{
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;

    IBOutlet MIMBarGraph *mBarChart;
    IBOutlet MIMBarGraph *mGroupBarChart;
    IBOutlet MIMBarGraph *mStackBarChart;
    
    IBOutlet UILabel *YearLabel;
    NSArray *yearArray;
    int selectedYear;

}
@end
