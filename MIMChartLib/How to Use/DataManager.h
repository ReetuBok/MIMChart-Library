//
//  DataManager.h
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 12/15/12.
//
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
{
    NSArray *yValuesArray;
    NSArray *xTitlesArray;
    NSArray *xValuesArray;

}
@property(nonatomic,retain)NSArray *yValuesArray;
@property(nonatomic,retain)NSArray *xTitlesArray;
@property(nonatomic,retain)NSArray *xValuesArray;

//Wall
-(void)createSingleWallPositiveData;
-(void)createThreeWallPositiveData;
-(void)createSingleWallNegativeData;
-(void)createDoubleWallNegativeData;
-(void)createThreeWallNegativeData;
-(void)createDataForLongSingleWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV;
-(void)createDataForLongMultipleWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV;
-(void)createDataForLongNegativeWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV;
@end
