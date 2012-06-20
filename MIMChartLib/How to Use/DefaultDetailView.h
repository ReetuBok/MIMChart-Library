//
//  DefaultDetailView.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"



@interface DefaultDetailView : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView *myTableView;
    BasicPieChart *myPieChart;

    
}


@end
