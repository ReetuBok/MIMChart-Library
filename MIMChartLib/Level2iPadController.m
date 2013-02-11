//
//  Level2iPadController.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level2iPadController.h"


@implementation Level2iPadController
@synthesize titleString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
        
    }
    return self;
}



#pragma mark - UITableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title=[featureListCellArray objectAtIndex:indexPath.row];

    if([title isEqualToString:@"Basic Pie Charts"])
    {
        ListBasicPieCharts *level3=[[ListBasicPieCharts alloc]initWithNibName:@"ListBasicPieCharts" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    
    }
    else if([title isEqualToString:@"Beveled Pie Charts"])
    {
        ListBevelPieCharts *level3=[[ListBevelPieCharts alloc]initWithNibName:@"ListBevelPieCharts" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Padded Pie Charts"])
    {
        ListPaddedPieCharts *level3=[[ListPaddedPieCharts alloc]initWithNibName:@"ListPaddedPieCharts" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Sectioned Pie Chart"])
    {
        ListSectionedPieCharts *level3=[[ListSectionedPieCharts alloc]initWithNibName:@"ListSectionedPieCharts" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Bi-Transparent Pie Charts"])
    {
        ListBiTransPieChart *level3=[[ListBiTransPieChart alloc]initWithNibName:@"ListBiTransPieChart" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Introduction Animation on Basic Pie Charts"])
    {
        ChartAnimation *level3=[[ChartAnimation alloc]initWithNibName:@"ChartAnimation" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Default Detail View Style"])
    {
        DefaultDetailView *level3=[[DefaultDetailView alloc]initWithNibName:@"DefaultDetailView" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    
    }
    else if([title isEqualToString:@"Detail View Style 2"])
    {
        DetailViewStyle2 *level3=[[DetailViewStyle2 alloc]initWithNibName:@"DetailViewStyle2" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Detail View Style 3"])
    {
        DetailViewStyle3 *level3=[[DetailViewStyle3 alloc]initWithNibName:@"DetailViewStyle3" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Default Info Style"])
    {
        DefaultInfoBoxTestClass *level3=[[DefaultInfoBoxTestClass alloc]initWithNibName:@"DefaultInfoBoxTestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Info Style 1"])
    {
        
        InfoBoxStyle1TestClass *level3=[[InfoBoxStyle1TestClass alloc]initWithNibName:@"InfoBoxStyle1TestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"Info Style 2"])
    {
        
        InfoBoxStyle2TestClass *level3=[[InfoBoxStyle2TestClass alloc]initWithNibName:@"InfoBoxStyle2TestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    else if([title isEqualToString:@"User customized Detail View Style"])
    {
        UserDefinedDetailView *level3=[[UserDefinedDetailView alloc]initWithNibName:@"UserDefinedDetailView" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    
    
    
    /******************************************************************/
    /***************************LINE GRAPHS****************************/
    /******************************************************************/
    
    else if([title isEqualToString:@"Basic Line Charts"])
    {
        TestLineClass *level3=[[TestLineClass alloc]initWithNibName:@"TestLineClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    else if([title isEqualToString:@"Animated Line Charts"])
    {
//        TestLineClass2 *level3=[[TestLineClass2 alloc]initWithNibName:@"TestLineClass2" bundle:nil];
//        [self.navigationController pushViewController:level3 animated:YES];
    }
    
    
    
    /***************************FRAGMENTED DOUGHNUT CHART****************************/
    else if([title isEqualToString:@"Basic Doughnut Charts"])
    {
        TestClassFragmented *level3=[[TestClassFragmented alloc]initWithNibName:@"TestClassFragmented" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    
    
    
    
    /***************************WALL GRAPHS****************************/
    else if([title isEqualToString:@"Basic Wall Graphs"])
    {
        WallTestClass *level3=[[WallTestClass alloc]initWithNibName:@"WallTestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
        
    }
    
    
    
    
    /***************************BAR CHARTS****************************/
    else if([title isEqualToString:@"Basic Bar Charts"])
    {
        BarTestClass *level3=[[BarTestClass alloc]initWithNibName:@"BarTestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    else if([title isEqualToString:@"Basic Grouped Bar Charts"])
    {
        GroupBarTestClass *level3=[[GroupBarTestClass alloc]initWithNibName:@"GroupBarTestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    else if([title isEqualToString:@"Basic Stacked Bar Charts"])
    {
        StackedBarTestClass *level3=[[StackedBarTestClass alloc]initWithNibName:@"StackedBarTestClass" bundle:nil];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    else if([title isEqualToString:@"Basic Bar Views Management"])
    {
//        MultipleBarViews *level3=[[MultipleBarViews alloc]initWithNibName:@"MultipleBarViews" bundle:nil];
//        [self.navigationController pushViewController:level3 animated:YES];
    }
    
    
    /***************************GAUGE GRAPHS****************************/
    
    else if([title isEqualToString:@"Gauge Graphs"])
    {
        GaugeGraphTestClass *level3=[[GaugeGraphTestClass alloc]init];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    
    
    
    ///***************************RANGE GRAPHS****************************/
    else if([title isEqualToString:@"Range Graphs"])
    {
        RangeGraphTestClass *level3=[[RangeGraphTestClass alloc]init];
        [self.navigationController pushViewController:level3 animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return titleString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [featureListCellArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 300, 44)];
    [title setBackgroundColor:[UIColor clearColor]];
    [title setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [title setMinimumFontSize:9];
    title.text=[featureListCellArray objectAtIndex:indexPath.row];
    title.textColor=[UIColor blackColor];
    [cell.contentView addSubview:title];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
    
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
    
    
    /***************************PIE CHARTS****************************/
    if([titleString isEqualToString:@"Overview of all Pie Charts"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Pie Charts",@"Beveled Pie Charts",@"Padded Pie Charts",@"Sectioned Pie Chart",@"Bi-Transparent Pie Charts", nil];
    }
    else if([titleString isEqualToString:@"Introduction Animation on Pie"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Introduction Animation on Basic Pie Charts", nil];
    }
    else if([titleString isEqualToString:@"Detail View Pop Up Styles"])
    {
        //style 3 : pie shutters in and detail view sweeps in.
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Default Detail View Style",@"Detail View Style 2",@"Detail View Style 3",@"User customized Detail View Style", nil];
    }
    else if([titleString isEqualToString:@"Display Information Styles"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Default Info Style",@"Info Style 1",@"Info Style 2", nil];
        //Info Style 2 lines arrowing towards textbox with percentage.
    }
    else if([titleString isEqualToString:@"Other Features"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Please suggest it on blog.", nil];
    }
    /***************************LINE GRAPHS****************************/
    else if([titleString isEqualToString:@"Overview of all Line Charts"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Line Charts", nil];
    }
    else if([titleString isEqualToString:@"Complex Line Charts"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Animated Line Charts", nil];
    }
    
    
    
    
    
    /***************************FRAGMENTED DOUGHNUT CHART****************************/
    else if([titleString isEqualToString:@"Overview of all Doughnut Charts"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Doughnut Charts", nil];
    }
    
    
    
    
    /***************************WALL GRAPHS****************************/
    else if([titleString isEqualToString:@"Overview of all Wall Graphs"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Wall Graphs",nil];
    }
    
    
    
    
    /***************************BAR CHARTS****************************/
    else if([titleString isEqualToString:@"Overview of all Bar Charts"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Bar Charts",@"Basic Grouped Bar Charts",@"Basic Stacked Bar Charts", nil];
    }
    else if([titleString isEqualToString:@"Multiple Bar Views Management"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Basic Bar Views Management", nil];
    }
    
 
    
    
  
    /***************************Gauge GRAPH****************************/
    else if([titleString isEqualToString:@"Overview of Gauge Graphs"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Gauge Graphs", nil];
    }
    
    
    ///***************************RANGE GRAPHS****************************/
    else if([titleString isEqualToString:@"Overview of Range Graphs"])
    {
        featureListCellArray=[[NSArray alloc]initWithObjects:@"Range Graphs", nil];
    }
    
    
    [myTableView reloadData];
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
	return YES;
}

@end
