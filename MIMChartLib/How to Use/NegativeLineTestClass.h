//
//  NegativeLineTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NegativeLineGraph.h"

@interface NegativeLineTestClass : UIViewController<LineGraphDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    NegativeLineGraph *lineGraph;
    NegativeLineGraph *lineGraph1;
}

@end
