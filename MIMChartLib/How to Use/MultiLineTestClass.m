//
//  MultiLineTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MultiLineTestClass.h"

@implementation MultiLineTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - UITableView
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
    return @"Multi Line Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            
            lineGraph=[[MultiLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-70, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE1;
            [lineGraph drawMultiLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All WIthout Anchors
            
        }
            break;
            
        case 1:
        {
            
            lineGraph=[[MultiLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawMultiLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All with their own anchor styles
            
        }
            break;
            
        case 2:
        {
            
            lineGraph=[[MultiLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width*0.5, myTableView.frame.size.width * 0.3)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            lineGraph.xTitleStyle=X_TITLES_STYLE2;
            [lineGraph drawMultiLineGraph];
            [cell.contentView addSubview:lineGraph];
            
            //All with some default colors
            
        }
            break;
        case 3:
        {
            lineGraph=[[MultiLineGraph alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            lineGraph.delegate=self;
            lineGraph.tag=10+indexPath.row;
            [lineGraph drawMultiLineGraph];
            [cell.contentView addSubview:lineGraph];
            
        }
            break;
        
            
    }
    
    
    return cell;
    
    
}




#pragma mark - DELEGATE METHODS
-(NSArray *)valuesForGraph:(id)graph
{
    NSArray *yValuesArray;
    
    if([(MultiLineGraph *)graph tag]>=10 && [(MultiLineGraph *)graph tag]<=12)
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
    }
    else if([(MultiLineGraph *)graph tag] == 13)
        return dataArrayFromCSV;
    return yValuesArray;
    
    
    
}

-(NSArray *)valuesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
    if([(MultiLineGraph *)graph tag]>=10 && [(MultiLineGraph *)graph tag]<=12)
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
    
    else if([(MultiLineGraph *)graph tag] == 13)
        return xDataArrayFromCSV;
    return xValuesArray;
}

-(NSArray *)titlesForXAxis:(id)graph
{
    NSArray *xValuesArray;
    
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
    
    
    return xValuesArray;
    
}
/*You need this method to return YES in order to display the titles on X-Axis*/
-(BOOL)displayTitlesOnXAxis:(id)graph
{
    if([(MultiLineGraph *)graph tag]>=10 && [(MultiLineGraph *)graph tag]<=12)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)displayTitlesOnYAxis:(id)graph
{
    return YES; //Display for all of them
}


-(BOOL)drawHorizontalLines:(id)graph
{
    if([(MultiLineGraph *)graph tag]>=10 && [(MultiLineGraph *)graph tag]<=16)
    {
        return YES;
    }
    
    return NO;
}

-(BOOL)drawVerticalLines:(id)graph
{
    if([(MultiLineGraph *)graph tag]==11)
    {
        return YES;
    }
    
    return NO;
}



//-(NSArray *)ColorsForLineChart:(id)graph
//{
//    
//}
//
//
-(NSArray *)AnchorStylesForLineChart:(id)graph
{
    if([(MultiLineGraph *)graph tag]==11)
    {
        NSNumber *a=    [NSNumber numberWithInt:SQUAREFILLED];
        NSNumber *a1=    [NSNumber numberWithInt:CIRCLEBORDER];
        NSNumber *a2=    [NSNumber numberWithInt:CIRCLEFILLED];
        return [[NSArray alloc]initWithObjects:a,a2,a1, nil];
    }
    return nil;
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





- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
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
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
