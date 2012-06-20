//
//  NegativeWallTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NegativeWallGraph.h"



@interface NegativeWallTestClass : UIViewController<UITableViewDelegate,UITableViewDataSource,WallGraphDelegate> 
{
    IBOutlet UITableView *myTableView;
    NegativeWallGraph *wallGraph;
    NegativeWallGraph *wallGraph1;
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
}
@end
