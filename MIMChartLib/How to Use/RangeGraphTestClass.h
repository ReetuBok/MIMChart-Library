//
//  RangeGraphTestClass.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 11/1/12.
//
//

#import <UIKit/UIKit.h>
#import "MIMRangeGraph.h"
@interface RangeGraphTestClass : UIViewController<RangeGraphDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *myTableView;
    MIMRangeGraph *mRangeGraph;
    NSMutableArray *dataArrayFromCSV;
    NSMutableArray *xDataArrayFromCSV;
    NSArray *anchorPropertiesArray;
    NSDictionary *horizontalLinesProperties;
    NSDictionary *verticalLinesProperties;
    
    NSArray *yValuesArray;
    NSArray *xValuesArray;
    NSArray *xNumArray;
    NSArray *xTitlesArray;
    
}

@end
