//
//  PaddedPieCharts.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//




#import "ListPaddedPieCharts.h"

@interface ListPaddedPieCharts()
-(UILabel *)createLabelWithText:(NSString *)text;
@end

@implementation ListPaddedPieCharts

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
    return @"Padded Pie Charts List";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  7;
    
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
            
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=2.0;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Default Look"]];
            
            
        }
            break;
            
        case 1:
        {
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=2.0;
            myPieChart.glossEffect=YES;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Gloss Effect"]];
            
            
        }
            break;
        case 2:
        {
            
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=8.0;
            myPieChart.glossEffect=YES;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Padding Pixels increased."]];
            
        }
            break;
        case 3:
        {
            
            //border
            //NOTE: Border colors are fixed for now.
            //Code should be able to pick the dark/light color by itself.
            
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=3.0;
            myPieChart.borderWidth=8.0;
            myPieChart.glossEffect=YES;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Gloss Effect+ Border(fat in this case :P)"]];
            
            
        }
            break;
        case 4:
        {
            //border
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=3.0;
            myPieChart.borderWidth=4.0;
            myPieChart.glossEffect=YES;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Gloss Effect+ Normal Border"]];
            
            
        }
            break;
        case 5:
        {
            myPieChart1=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart1.delegate=self;
            myPieChart1.paddingPixels=3.0;
            myPieChart1.borderWidth=4.0;
            [myPieChart1 drawPieChart];
            [cell.contentView addSubview:myPieChart1];
            
            
            [cell.contentView addSubview:[self createLabelWithText:@"DefaultLook+Border+BgColor by user"]];
            
        }
            break;
        case 6:
        {
            myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
            myPieChart.delegate=self;
            myPieChart.paddingPixels=2.0;
            myPieChart.borderWidth=2.0;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Default Look + Border(Pencil thin :P)"]];
        }
            break;
        
    }
    
    
    return cell;
    
    
}




-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, 230, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}

#pragma mark - PIECHART Delegate methods

-(float)radiusForPie:(id)pieChart
{
    return 100.0;
}


-(NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;
    
    MIMColorClass *color1=[MIMColorClass colorWithComponent:@"137,215,234"];
    MIMColorClass *color2=[MIMColorClass colorWithComponent:@"239,95,100"];
    MIMColorClass *color3=[MIMColorClass colorWithComponent:@"127,186,140"];
    MIMColorClass *color4=[MIMColorClass colorWithComponent:@"247,144,187"];
    MIMColorClass *color5=[MIMColorClass colorWithComponent:@"249,219,122"];
    
    colorsArray=[NSArray arrayWithObjects:color1,color2,color3,color4,color5, nil];
    
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    return [NSArray arrayWithObjects:@"10000",@"21000",@"24000",@"11000",@"5000",nil];  
    
}

-(NSArray *)bordercolorsForPie:(id)pieChart
{

    NSArray *bcolorsArray;
    
    MIMColorClass *color1=[MIMColorClass colorWithComponent:@"108,178,205"];
    MIMColorClass *color2=[MIMColorClass colorWithComponent:@"206,69,90"];
    MIMColorClass *color3=[MIMColorClass colorWithComponent:@"107,160,124"];
    MIMColorClass *color4=[MIMColorClass colorWithComponent:@"229,128,168"];
    MIMColorClass *color5=[MIMColorClass colorWithComponent:@"226,198,90"];
    
    bcolorsArray=[NSArray arrayWithObjects:color1,color2,color3,color4,color5, nil];
    
    return bcolorsArray;
    
}

-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor=[MIMColorClass colorWithComponent:@"1.0,1.0,1.0,0.0"];

    
    if(pieChart==myPieChart1)
        bgColor=[MIMColorClass colorWithComponent:@"1.0,1.0,1.0"];

    
    return bgColor;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title=@"PADDED PIE CHARTS";
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
