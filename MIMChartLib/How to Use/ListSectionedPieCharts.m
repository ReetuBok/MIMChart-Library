//
//  ListSectionedPieCharts.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListSectionedPieCharts.h"

@implementation ListSectionedPieCharts

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, 320, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}


#pragma mark - TABLEVIEW
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
    return @"Sectioned Pie Charts List";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            myPieChart=[[SectionedPieChart alloc]initWithFrame:CGRectMake(5, 5, 500, 350)];
            myPieChart.delegate=self;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Default Look"]];
            
            
        }
            break;
            
        
            
    }
    
    
    return cell;
    
    
}




#pragma mark - DELEGATE METHODS
-(float)radiusForPie:(id)pieChart
{
    return 150.0;
}


-(NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;
    
    MIMColorClass *color1=[MIMColorClass colorWithComponent:@"137,215,234"];
    MIMColorClass *color2=[MIMColorClass colorWithComponent:@"239,95,100"];
    MIMColorClass *color3=[MIMColorClass colorWithComponent:@"127,186,140"];
    MIMColorClass *color4=[MIMColorClass colorWithComponent:@"247,144,187"];
    MIMColorClass *color5=[MIMColorClass colorWithComponent:@"249,219,122"];
    MIMColorClass *color6=[MIMColorClass colorWithComponent:@"144,139,39"];
    MIMColorClass *color7=[MIMColorClass colorWithComponent:@"208,195,135"];
    MIMColorClass *color8=[MIMColorClass colorWithComponent:@"182,119,48"];
    MIMColorClass *color9=[MIMColorClass colorWithComponent:@"183,142,50"];
    
    
    
    colorsArray=[NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6,color7,color8,color9, nil];
    
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    return [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000",@"15000",@"31000",@"14000",@"21000",@"15000",nil],[NSArray arrayWithObjects:@"3000",@"1000",@"4000",@"1500",@"5000",@"3200",@"4800",@"2100",@"1900",nil],nil];  
    
}

-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor=[MIMColorClass colorWithComponent:@"1.0,1.0,1.0,0.0"];

    
    if(pieChart==myPieChart)
        bgColor=[MIMColorClass colorWithComponent:@"1,1,1,1"];
    
    
    return bgColor;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
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
