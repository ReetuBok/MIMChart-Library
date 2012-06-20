//
//  ListBiTransPieChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListBiTransPieChart.h"
@interface ListBiTransPieChart()
-(UILabel *)createLabelWithText:(NSString *)text;
@end

@implementation ListBiTransPieChart

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
    return @"Bi-Transparent Pie Charts List";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //Bi-Transparent represents  information in binary way.
    //For example here, we say 60% are asian , and rest(40%) are non-asians.
    //So 60% of entire pie chart is colored with color provided by you.
    
    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            
            
            myPieChart=[[BiTransPieChart alloc]initWithFrame:CGRectMake(5, 5, 330, 330)];
            myPieChart.delegate=self;
            myPieChart.innerRadius=25;
            myPieChart.outerRadius=150;
            myPieChart.percentValue=60.0; 
            myPieChart.centerIcon=[UIImage imageNamed:@"trans_icon.png"];
            myPieChart.mcolor=[MIMColorClass colorWithComponent:@"0.290,0.07,0.552"];
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            UILabel *myLabel=[[UILabel alloc]initWithFrame:CGRectMake(205, 120, 80, 80)];
            myLabel.textColor=[UIColor whiteColor];
            myLabel.numberOfLines=5;
            myLabel.text=@"60% of entire population in the world belongs to Asian countries."; //NOTE : This is a made up text and statistics!
            [myLabel setBackgroundColor:[UIColor clearColor]];
            [myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
            [cell.contentView addSubview:myLabel];


            
            [cell.contentView addSubview:[self createLabelWithText:@"Default Look+User set BgColor"]];
            
            
        }
            break;
            
        case 1:
        {
            //You can define border width too
            myPieChart1=[[BiTransPieChart alloc]initWithFrame:CGRectMake(5, 5, 330, 330)];
            myPieChart1.delegate=self;
            myPieChart1.innerRadius=20;
            myPieChart1.outerRadius=150;
            myPieChart1.percentValue=60.0; 
            myPieChart1.borderWidth=5;
            myPieChart1.centerIcon=[UIImage imageNamed:@"trans_icon.png"];
            myPieChart1.mcolor=[MIMColorClass colorWithComponent:@"0.8,0.9,0.9"];
            [myPieChart1 drawPieChart];
            [cell.contentView addSubview:myPieChart1];
            
            UILabel *myLabel=[[UILabel alloc]initWithFrame:CGRectMake(205, 120, 80, 80)];
            myLabel.textColor=[UIColor whiteColor];
            myLabel.numberOfLines=5;
            myLabel.text=@"60% of entire population in the world belongs to Asian countries."; //NOTE : This is a made up text and statistics!
            [myLabel setBackgroundColor:[UIColor clearColor]];
            [myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
            [cell.contentView addSubview:myLabel];

            
            [cell.contentView addSubview:[self createLabelWithText:@"Border pixel set by user."]];
            
            
        }
            break;
        
            
            
    }
    
    
    return cell;
    
    
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

#pragma mark - DELEGATE METHOD FOR PIE
-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor;
    
    if(pieChart==myPieChart)
        bgColor=[MIMColorClass colorWithComponent:@"0,0,0,0"];
   
    
    return bgColor;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"BI-TRANSPARENT PIE CHARTS";
    [myTableView reloadData];
    
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
