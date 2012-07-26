//
//  StackedBarTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIMBarGraph.h"
#import "MIMColor.h"
@interface StackedBarTestClass : UIViewController<UITableViewDelegate,UITableViewDataSource,BarGraphDelegate>
{
    NSArray *xValuesArray;
    NSArray *yValuesArray;
    NSArray *xTitlesArray;

    
    IBOutlet UITableView *myTableView;
    MIMBarGraph *myBarChart;
    NSDictionary *barProperty;
}
@end
