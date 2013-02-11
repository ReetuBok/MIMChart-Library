//
//  DataManager.m
//  MIMChartLib
//
//  Created by Reetu Raj Bok on 12/15/12.
//
//

#import "DataManager.h"

@implementation DataManager
@synthesize yValuesArray;
@synthesize xTitlesArray;
@synthesize xValuesArray;

#pragma mark - Wall graph Data Methods
-(void)createSingleWallPositiveData
{
    yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
    xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
}

-(void)createThreeWallPositiveData
{
    NSArray *array1=[NSArray arrayWithObjects:@"104.622"  ,  @"104.270" ,   @"100.635"   , @"103.684"   , @"105.483",    @"105.101" ,   @"105.447" ,   @"104.468",    @"102.064" ,   @"100.319"  ,  @"100.145"  ,  @"100.567", nil];
    
    
    NSArray *array2=[NSArray arrayWithObjects:@"72.80",
                     @"69.55",
                     @"34.50",
                     @"33.96",
                     @"45.31",
                     @"54.05",
                     @"61.45",
                     @"62.57",
                     @"65.00",
                     @"74.58",
                     @"63.70",
                     @"69.58", nil];
    
    NSArray *array3=[NSArray arrayWithObjects:@"93.83",
                     @"93.96",
                     @"93.63",
                     @"93.70",
                     @"93.65",
                     @"93.82",
                     @"93.88",
                     @"93.80",
                     @"93.79",
                     @"93.86",
                     @"93.78",
                     @"93.47", nil];
    
    
    
    yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,array3,nil];
    
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
}

-(void)createSingleWallNegativeData
{
    
    yValuesArray=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
    
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    
    xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
}

-(void)createDoubleWallNegativeData
{
    NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
    NSArray *array2=[NSArray arrayWithObjects:@"-140",@"-135",@"-120",@"-130", @"10",@"120",@"123" ,@"50",@"58" ,@"40",@"125",@"120",nil];
    yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,nil];
    
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
}

-(void)createThreeWallNegativeData
{
    
    NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"10",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
    NSArray *array2=[NSArray arrayWithObjects:@"-140",@"-135",@"-120",@"-130", @"10",@"120",@"123" ,@"50",@"58" ,@"40",@"125",@"120",nil];
    NSArray *array3=[NSArray arrayWithObjects:@"-10",@"-235",@"-80",@"-90", @"120",@"110",@"133" ,@"70",@"68" ,@"50",@"105",@"110",nil];
    yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,array3,nil];
    
    
    xValuesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
    
    xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan",
                  @"Feb",
                  @"Mar",
                  @"Apr",
                  @"May",
                  @"Jun",
                  @"Jul",
                  @"Aug",
                  @"Sep",
                  @"Oct",
                  @"Nov",
                  @"Dec", nil];
}



-(void)createDataForLongSingleWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV
{
    [xDataArrayFromCSV removeAllObjects];xDataArrayFromCSV=nil;
    [dataArrayFromCSV removeAllObjects];dataArrayFromCSV=nil;
    
    
    xDataArrayFromCSV=[[NSMutableArray alloc]init];
    dataArrayFromCSV=[[NSMutableArray alloc]init];
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data3.csv"];
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [dataArrayFromCSV addObject:[columnArray objectAtIndex:1]];
        [xDataArrayFromCSV addObject:[columnArray objectAtIndex:0]];
    }
    
    yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
    xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
    xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
    
    
}

-(void)createDataForLongMultipleWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV
{
    xDataArrayFromCSV=[[NSMutableArray alloc]init];
    dataArrayFromCSV=[[NSMutableArray alloc]init];
    
    NSMutableArray *valArray=[[NSMutableArray alloc]init];
    NSMutableArray *xvalArray=[[NSMutableArray alloc]init];
    
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data3.csv"];
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [valArray addObject:[columnArray objectAtIndex:1]];
        [xvalArray addObject:[columnArray objectAtIndex:0]];
    }
    
    [xDataArrayFromCSV addObject:xvalArray];
    [dataArrayFromCSV addObject:valArray];
    
    
    
    NSMutableArray *valArray1=[[NSMutableArray alloc]init];
    NSMutableArray *xvalArray1=[[NSMutableArray alloc]init];
    
    
    csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data4.csv"];
    fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [valArray1 addObject:[columnArray objectAtIndex:1]];
        [xvalArray1 addObject:[columnArray objectAtIndex:0]];
    }
    
    [xDataArrayFromCSV addObject:xvalArray1];
    [dataArrayFromCSV addObject:valArray1];
    
    
    yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
    xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
    xTitlesArray=[xDataArrayFromCSV objectAtIndex:0];
    
    
    
}

-(void)createDataForLongNegativeWall:(NSMutableArray *)xDataArrayFromCSV :(NSMutableArray *)dataArrayFromCSV
{
    xDataArrayFromCSV=[[NSMutableArray alloc]init];
    dataArrayFromCSV=[[NSMutableArray alloc]init];
    
    NSMutableArray *valArray=[[NSMutableArray alloc]init];
    NSMutableArray *xvalArray=[[NSMutableArray alloc]init];
    
    NSString *csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data3.csv"];
    NSString *fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [valArray addObject:[NSString stringWithFormat:@"-%@",[columnArray objectAtIndex:1]]];
        [xvalArray addObject:[columnArray objectAtIndex:0]];
    }
    
    [xDataArrayFromCSV addObject:xvalArray];
    [dataArrayFromCSV addObject:valArray];
    
    
    
    NSMutableArray *valArray1=[[NSMutableArray alloc]init];
    NSMutableArray *xvalArray1=[[NSMutableArray alloc]init];
    
    
    csvPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"data4.csv"];
    fileDataString=[NSString stringWithContentsOfFile:csvPath encoding:NSUTF8StringEncoding error:nil];
    linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    
    for (int i=1;i<[linesArray count];i++)
    {
        
        NSString *lineString=[linesArray objectAtIndex:i];
        NSArray *columnArray=[lineString componentsSeparatedByString:@","];
        [valArray1 addObject:[columnArray objectAtIndex:1]];
        [xvalArray1 addObject:[columnArray objectAtIndex:0]];
    }
    
    [xDataArrayFromCSV addObject:xvalArray1];
    [dataArrayFromCSV addObject:valArray1];
    
    yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
    xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
    xTitlesArray=[xDataArrayFromCSV objectAtIndex:0];

    
    
    
}

/*
-(void)dealloc
{
    [super dealloc];
    [yValuesArray release];
    [xTitlesArray release];
    [xValuesArray release];
}
 */
@end
