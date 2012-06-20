//
//  UserDefinedDetailView.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicPieChart.h"
#import "PageControl.h"


@interface UserDefinedDetailView : UIViewController<MIMPieChartDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    BasicPieChart *myPieChart;
    
    
    float sum;
    NSArray *valueArray;
    NSArray *titleArray;
    
}



@end
