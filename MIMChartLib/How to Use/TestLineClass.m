/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  TestLineClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 15/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "TestLineClass.h"

@implementation TestLineClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor blackColor];
        
        
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)createDataForLongNegativeLines
{
    [xDataArrayFromCSV removeAllObjects];xDataArrayFromCSV=nil;
    [dataArrayFromCSV removeAllObjects];dataArrayFromCSV=nil;
    
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
    
    
    
}
- (void)createDataForLongMultipleLines
{
    [xDataArrayFromCSV removeAllObjects];xDataArrayFromCSV=nil;
    [dataArrayFromCSV removeAllObjects];dataArrayFromCSV=nil;
    
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
    
    
    
}

-(void)createDataForLongSingleLine
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
    
    

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    horizontalLinesProperties=nil;
        

    [super viewDidLoad];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if(![deviceType isEqualToString:@"iPhone"])
        return 500;
    
    
    return 200;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Line Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  17;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    verticalLinesProperties=nil;
    
    switch (indexPath.row) 
    {
        case 0:
        {
            
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
        
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
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
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            //Set initial Y-Label as 0..
            mLineGraph.minimumLabelOnYIsZero=TRUE;
            

            //Set color for line graph
            MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
            mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1, nil];

        
            mLineGraph.titleLabel.text=@"Example 1: User assigned color for the line graph. Minimum Assigned value on Y-Axis is 0.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
        }
            break;
            
        case 1:
        {

            horizontalLinesProperties=[[NSDictionary alloc] initWithObjectsAndKeys:@"2,1",@"dotted", nil];
            verticalLinesProperties=[[NSDictionary alloc]initWithObjectsAndKeys:@"1,2",@"dotted", nil];
            
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
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
            
            
           
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
          
            
            mLineGraph.titleLabel.text=@"Example 2: User assigned style for X-Axis and Y-Axis separator lines style.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
        case 2:
        {

            
            
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
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
        
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            mLineGraph.mbackgroundColor=[MIMColorClass colorWithComponent:@"255,255,255"];
            
        
            mLineGraph.titleLabel.text=@"Example 3: User assigned white background color.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            [mLineGraph drawMIMLineGraph];
            
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
        case 3:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
            
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
            
            
           
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 30, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            
            
            //Define color of line graph
            MIMColorClass *c1=[MIMColorClass colorWithComponent:@"248,172,65"];
            mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1, nil];
            
            //Define transparent background
            mLineGraph.mbackgroundColor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
            
            //I have set the background color of cell as darkgrey, so that transparent background of the linegraph is visible.
            cell.contentView.backgroundColor=[UIColor darkGrayColor];
            
            mLineGraph.titleLabel.text=@"Example 4: User assigned transparent background color.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            

            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
        case 4:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
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
            
        
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            

            mLineGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE], nil];
            
            
            mLineGraph.titleLabel.text=@"Example 5: Hide the Anchor Points.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            

            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
        case 5:
        {
            verticalLinesProperties=nil;
            horizontalLinesProperties=[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:30.0] forKey:@"gap"];
            anchorPropertiesArray=nil;
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
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
            
            

            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;

            
            mLineGraph.titleLabel.text=@"Example 6: Set gap between Y-Axis separator.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
        }
            break;
        case 6:
        {

            //Set the gap for x-axis separator lines.
            verticalLinesProperties=[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:100.0] forKey:@"gap"];
            
            horizontalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
            
            yValuesArray=[[NSArray alloc]initWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",@"2000",@"9000",@"4000",@"10000",@"17000",@"15000",@"11000",nil];
            
            
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
            
            

            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            
            mLineGraph.xTitleStyle=XTitleStyle1;

            
            mLineGraph.titleLabel.text=@"Example 7: Set gap between X-Axis separator.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
    
        }
            break;
        case 7:
        {
            horizontalLinesProperties=nil;
            anchorPropertiesArray=nil;
            verticalLinesProperties=[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:15.0] forKey:@"gap"];
            [self createDataForLongSingleLine];
            
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            mLineGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE], nil];
            

            
            
            mLineGraph.titleLabel.text=@"Example 8: Set gap between X-Axis separator and X-Axis Label style.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            mLineGraph.xTitleStyle=XTitleStyle1;

            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
        }
            break;
        case 8:
        {
            horizontalLinesProperties=nil;
            anchorPropertiesArray=nil;
            verticalLinesProperties=nil;
            
            
            

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
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-70, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;

            //Set the colors for multiple lines.
            MIMColorClass *c1=[MIMColorClass colorWithComponent:@"0,169,249"];
            MIMColorClass *c2=[MIMColorClass colorWithComponent:@"255,0,0"];
            MIMColorClass *c3=[MIMColorClass colorWithComponent:@"0,230,49"];
            
            mLineGraph.lineColorArray=[NSArray arrayWithObjects:c1,c2,c3, nil];

            
            
            mLineGraph.titleLabel.text=@"Example 9: Multiple line graph with user assigned color.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
            
        case 9:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
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
            
            
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            NSNumber *a=    [NSNumber numberWithInt:SQUAREFILLED];
            NSNumber *a1=    [NSNumber numberWithInt:CIRCLEFILLED];
            NSNumber *a2=    [NSNumber numberWithInt:CIRCLEFILLED];
            mLineGraph.anchorTypeArray=[[NSMutableArray alloc]initWithObjects:a,a2,a1, nil];
            
            
            
            mLineGraph.titleLabel.text=@"Example 10: Set different anchor style for multiple lines.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
        case 10:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;

            
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
            
            
            anchorPropertiesArray= [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithBool:YES],@"5",nil]
                                                                                         forKeys:[NSArray arrayWithObjects:@"hideShadow",@"radius",nil]],
                                    [NSDictionary dictionaryWithObject:@"5" forKey:@"radius"],
                                    [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"hideShadow"], nil];
            
            
            //You can also set anchorTypeArray to assign TYPE of anchors.

            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width - 20.0, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;

            
            
            mLineGraph.titleLabel.text=@"Example 11: User-defined Properties(radius,shadow) for Anchors.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
    
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
        case 11:
        {
            
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;

            

            yValuesArray=[[NSArray alloc]initWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
            
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
            
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
    
            anchorPropertiesArray= [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"0,0,255",
                                                                                                  [NSNumber numberWithBool:YES],
                                                                                                  @"6",@"255,0,0",nil]
                                                                                         forKeys:[NSArray arrayWithObjects:@"borderColor",
                                                                                                  @"hideShadow",@"radius",@"fillColor",nil]], nil];
            
            
            //Here border color is different than fill color AND fill color is different than line color.
            mLineGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:CIRCLEBORDER], nil];
            
            
            mLineGraph.titleLabel.text=@"Example 12: Negative Values & User-defined Properties(radius,fillColor & borderColor) for Anchors.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
        case 12:
        {
            
            horizontalLinesProperties=nil;
            anchorPropertiesArray=nil;
            verticalLinesProperties=nil;
            
            [self createDataForLongMultipleLines];
            
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:[xDataArrayFromCSV objectAtIndex:0]];
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            
            mLineGraph.titleLabel.text=@"Example 13: Long Line Graph with X Labels in Style 2.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            mLineGraph.xTitleStyle=XTitleStyle1;

            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
        }
            break;
            
        case 13:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
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
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;

            
            anchorPropertiesArray= [NSArray arrayWithObjects:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"],[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"touchenabled"], nil];

            
            mLineGraph.titleLabel.text=@"Example 14: Touch Enabled Anchors.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
            
        case 14:
        {
            horizontalLinesProperties=nil;
            verticalLinesProperties=nil;
            anchorPropertiesArray=nil;
            
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
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Jan\n 2012",
                          @"Feb\n 2012",
                          @"Mar\n 2012",
                          @"Apr\n 2012",
                          @"May\n 2012",
                          @"Jun\n 2012",
                          @"Jul\n 2012",
                          @"Aug\n 2012",
                          @"Sep\n 2012",
                          @"Oct\n 2012",
                          @"Nov\n 2012",
                          @"Dec\n 2012", nil];
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            mLineGraph.xTitleStyle=XTitleStyle1;
            
            mLineGraph.titleLabel.text=@"Example 15:Multiline X-Label  with style XTitleStyle1.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
        case 15:
        {
            horizontalLinesProperties=nil;
            anchorPropertiesArray=nil;
            verticalLinesProperties=nil;

            //If you want to display only single value, you need to add 0 as first element of the value array
            //I will add it on the line graph code, so that user doesnt have to add 0.
            //But for now this is how it is done.
            

            
            yValuesArray=[[NSArray alloc]initWithObjects:@"0",@"47",nil];
            
            //Also add an empty string for x labels.
            
            xValuesArray=[[NSArray alloc]initWithObjects:@" ",@"2012", nil];
            xTitlesArray=[[NSArray alloc]initWithObjects:@" ",@"2012", nil];
            
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 40, myTableView.frame.size.width-40, myTableView.frame.size.width * 0.5)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;

            //If for some reason, you need margins.
            mLineGraph.margin=MIMMarginMake(50.0, 50.0, 100.0, 100.0);
            
                               
            
            mLineGraph.titleLabel.text=@"Example 16:Handle single value display on line graph & Set Margins.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);
            
            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            

            
        }
            break;
        case 16:
        {
            horizontalLinesProperties=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"20", nil] forKeys:[NSArray arrayWithObjects:@"gap", nil]];
            verticalLinesProperties=[NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:10.0] forKey:@"gap"];

            [self createDataForLongNegativeLines];
            
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            
            anchorPropertiesArray=nil;
            
            mLineGraph=[[MIMLineGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            mLineGraph.delegate=self;
            mLineGraph.tag=10+indexPath.row;
            
            mLineGraph.titleLabel.text=@"Example 17:X-Axis Labels with Style 2.";
            mLineGraph.titleLabel.frame=CGRectMake(0, -30, myTableView.frame.size.width, 30);

            
            [mLineGraph drawMIMLineGraph];
            [cell.contentView addSubview:mLineGraph];
            
            
            
           
            
        }
            break;
            
    }
    return cell;
    
    
}



#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    return yValuesArray;
}

-(NSArray *)valuesForXAxis:(id)graph
{
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
   
    return xTitlesArray;

}

-(NSArray *)AnchorProperties:(id)graph
{
    return anchorPropertiesArray;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph 
{
    return horizontalLinesProperties;

}

-(NSDictionary*)verticalLinesProperties:(id)graph
{
    return verticalLinesProperties;
}


-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, myTableView.frame.size.width * 0.5 + 20, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}




- (void)viewDidUnload
{
    
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation==UIInterfaceOrientationPortrait);
}
- (void)dealloc
{
    
}

@end
