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
//  WallTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 13/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import "WallTestClass.h"


@implementation WallTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor blackColor];
    }
    return self;
}

- (void)dealloc
{
    ////[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TABLE View

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if(![deviceType isEqualToString:@"iPhone"])
        return 500;
    
    
    return 200;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Basic Wall Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  12;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    xProperty=nil;
    yProperty=nil;
    horizontalLinesProperties=nil;
    verticalLinesProperties=nil;
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            horizontalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted", nil];
            verticalLinesProperties=[NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted", nil];
            
            
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
            
            NSArray *keys=[NSArray arrayWithObjects:@"color",@"width", nil];
            NSArray *values=[NSArray arrayWithObjects:@"0,0,0,1",@"2.0", nil];
            xProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            yProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 5, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.55)];
            mWallGraph.tag=indexPath.row+10;
            mWallGraph.delegate=self;
            mWallGraph.mbackgroundColor=[MIMColorClass colorWithComponent:@"0,0,0,1"];
            mWallGraph.isGradient=YES;
            mWallGraph.displayMeterline=YES;
            mWallGraph.xTitleStyle=X_TITLES_STYLE1;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
        }
            break;
            
        case 1:
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
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.tag=indexPath.row+10;
            mWallGraph.delegate=self;
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:CIRCLEFILLED], nil];
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];

            
            
        }
            break;
        case 2:
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
            
            NSArray *keys=[NSArray arrayWithObjects:@"color",@"width", nil];
            NSArray *values=[NSArray arrayWithObjects:@"0,0,1,1",@"0.5", nil];
            xProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            yProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            
        }
            break;
        case 3:
        {
            //Test for hiding X-Axis.
            NSArray *keys=[NSArray arrayWithObjects:@"hide", nil];
            NSArray *values=[NSArray arrayWithObjects:[NSNumber numberWithBool:YES], nil];
            xProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];

            
            [self createDataForLongSingleWall];

            
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.55)];
            mWallGraph.delegate=self;
            mWallGraph.isGradient=YES;
            mWallGraph.displayMeterline=YES;
            mWallGraph.meterLineYOffset=30;
            mWallGraph.tag=10+indexPath.row;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            
        }
            break;
        case 4:
        {
            //Test for hiding Y-Axis
            //NSArray *keys=[NSArray arrayWithObjects:@"hide", nil];
            //NSArray *values=[NSArray arrayWithObjects:[NSNumber numberWithBool:YES], nil];
            //yProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];

            
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
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.isGradient=YES;
            mWallGraph.xTitleStyle=X_TITLES_STYLE1;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            //All WIthout Anchors
            
        }
            break;
            
        case 5:
        {
            NSArray *array1=[NSArray arrayWithObjects:@"104.622"  ,  @"104.270" ,   @"100.635"   , @"103.684"   , @"105.483",    @"105.101" ,   @"105.447" ,   @"104.468",    @"102.064" ,   @"100.319"  ,  @"100.145"  ,  @"100.567", nil];
            //        NSArray *array2=[NSArray arrayWithObjects:@"172.80",
            //                         @"169.55",
            //                         @"134.50",
            //                         @"133.96",
            //                         @"145.31",
            //                         @"154.05",
            //                         @"161.45",
            //                         @"162.57",
            //                         @"165.00",
            //                         @"174.58",
            //                         @"163.70",
            //                         @"169.58", nil];
            //THERE IS PROBLEM WITH ABOVE ARRAY- CHECK PLEASE.
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
            
            yValuesArray=[[NSArray alloc]initWithObjects:array1,array2,array3,nil];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE], 
                                       nil];
            
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.xTitleStyle=X_TITLES_STYLE2;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            

            
        }
            break;
            
        case 6:
        {
            NSArray *array1=[NSArray arrayWithObjects:@"104.622"  ,  @"104.270" ,   @"100.635"   , @"103.684"   , @"105.483",    @"105.101" ,   @"105.447" ,   @"104.468",    @"102.064" ,   @"100.319"  ,  @"100.145"  ,  @"100.567", nil];
            //        NSArray *array2=[NSArray arrayWithObjects:@"172.80",
            //                         @"169.55",
            //                         @"134.50",
            //                         @"133.96",
            //                         @"145.31",
            //                         @"154.05",
            //                         @"161.45",
            //                         @"162.57",
            //                         @"165.00",
            //                         @"174.58",
            //                         @"163.70",
            //                         @"169.58", nil];
            //THERE IS PROBLEM WITH ABOVE ARRAY- CHECK PLEASE.
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
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            mWallGraph.delegate=self;
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE], 
                                       nil];
            
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.xTitleStyle=X_TITLES_STYLE2;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            //All with some default colors
            
        }
            break;
        case 7:
        {
            NSArray *keys=[NSArray arrayWithObjects:@"hide", nil];
            NSArray *values=[NSArray arrayWithObjects:[NSNumber numberWithBool:YES], nil];
            xProperty=[NSDictionary dictionaryWithObjects:values forKeys:keys];

            
            
            [self createDataForLongMultipleWall];
            
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
        }
            break;
            
        case 8:
        {
            NSArray *array1=[NSArray arrayWithObjects:@"-40",@"-30",@"-20",@"-10", @"0",@"20",@"23" ,@"25",@"28" ,@"30",@"25",@"40",nil];
            yValuesArray=[[NSArray alloc]initWithObjects:array1,nil];
            
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
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.xTitleStyle=X_TITLES_STYLE1;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            
            
        }
            break;
            
        case 9:
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
            
            
            
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.xTitleStyle=X_TITLES_STYLE2;
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE], 
                                       nil];
            
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            //All with their own anchor styles
            
        }
            break;
            
        case 10:
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
            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            mWallGraph.xTitleStyle=X_TITLES_STYLE2;
            mWallGraph.anchorTypeArray=[NSArray arrayWithObjects:[NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE],
                                       [NSNumber numberWithInt:NONE], 
                                       nil];
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
            //All with some default colors
            
        }
            break;
        case 11:
        {
            
            [self createDataForLongNegativeWall];
            yValuesArray=[NSArray arrayWithArray:dataArrayFromCSV];
            xValuesArray=[NSArray arrayWithArray:xDataArrayFromCSV];
            xTitlesArray=[NSArray arrayWithArray:xDataArrayFromCSV];

            mWallGraph=[[MIMWallGraph alloc]initWithFrame:CGRectMake(5, 20, myTableView.frame.size.width-20, myTableView.frame.size.width * 0.5)];
            mWallGraph.delegate=self;
            mWallGraph.tag=10+indexPath.row;
            [mWallGraph drawMIMWallGraph];
            [cell.contentView addSubview:mWallGraph];
            
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


-(NSDictionary *)xAxisProperties:(id)graph
{
    return xProperty;
}
-(NSDictionary *)yAxisProperties:(id)graph
{
    return yProperty;
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


-(void)createDataForLongSingleWall
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

-(void)createDataForLongMultipleWall
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
    
    

    
    
}

-(void)createDataForLongNegativeWall
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
    
    

    
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    

    [super viewDidLoad];
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

@end
