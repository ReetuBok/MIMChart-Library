//
//  DetailViewStyle3.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"

@interface DetailViewStyle3 : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *myTableView;
    BasicPieChart *myPieChart;
    
    
}

@end
