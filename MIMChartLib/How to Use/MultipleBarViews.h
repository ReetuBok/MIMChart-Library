//
//  MultipleBarViews.h
//  MIMChartLib
//
//  Created by Reetu Raj on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarChart.h"

@interface MultipleBarViews : UIViewController<UIPickerViewDelegate,BarChartDelegate>
{
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xTitlesArray;

    IBOutlet BarChart *mBarChart;
    IBOutlet UILabel *YearLabel;
    NSArray *yearArray;
    int selectedYear;

}
@end
