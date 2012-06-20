//
//  MultiLineTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiLineGraph.h"

@interface MultiLineTestClass : UIViewController<LineGraphDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    MultiLineGraph *lineGraph;
    MultiLineGraph *lineGraph1;
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
}


@end
