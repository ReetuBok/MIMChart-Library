//
//  InfoBoxStyle2TestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoBoxStyle2TestClass.h"

@implementation InfoBoxStyle2TestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UILabel *)createLabelWithText:(NSString *)text
{
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(5, 220, 310, 20)];
    [a setBackgroundColor:[UIColor clearColor]];
    [a setText:text];
    a.numberOfLines=5;
    [a setTextAlignment:UITextAlignmentCenter];
    [a setTextColor:[UIColor blackColor]];
    [a setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [a setMinimumFontSize:8];
    return a;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 350;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Default Info Box Style 3  For Pie Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  2;
    
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
            
            //How you can set the text properties
            
            myPieChart1=[[BasicPieChart alloc]initWithFrame:CGRectMake(50, 50, 500, 240)];
            myPieChart1.delegate=self;
            myPieChart1.userTouchAllowed=YES;
            
            myPieChart1.showPercentBubbles=YES;
            myPieChart1.bubbleStyle=mPIE_BUBBLE_STYLE1;
            
            
            [cell.contentView addSubview:myPieChart1];
            
            
            [myPieChart1 drawPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Top Alignment of Detail POp up"]];
            
            
            
        }
            break;
        case 1:
        {
            //This shows how to set offset,
            //if you are not happy with your default position of info box.
            myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(50, 50, 500, 240)];
            myPieChart.userTouchAllowed=YES;
            myPieChart.delegate=self;
            
            
            myPieChart.showPercentBubbles=YES;
            myPieChart.bubbleStyle=mPIE_BUBBLE_STYLE1;
            
            
            
        
            [cell.contentView addSubview:myPieChart];
            
            
            [myPieChart drawPieChart];
            //[myPieChart showBubbleAtIndices:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4", nil]];

            
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Right Alignment of Detail POp up"]];
            
            
        }
            break;            
            
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
    
}



#pragma mark - PIECHART Delegate methods

-(float)radiusForPie:(id)pieChart
{
    return 100.0;
}

-(NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;
    
    if(pieChart == myPieChart)
    {
        
        MIMColorClass *color1=[MIMColorClass colorWithComponent:@"137,215,234"];
        MIMColorClass *color2=[MIMColorClass colorWithComponent:@"239,95,100"];
        MIMColorClass *color3=[MIMColorClass colorWithComponent:@"127,186,140"];
        MIMColorClass *color4=[MIMColorClass colorWithComponent:@"247,144,187"];
        MIMColorClass *color5=[MIMColorClass colorWithComponent:@"249,219,122"];
        
        
        
        
        colorsArray=[NSArray arrayWithObjects:color1,color5,color2,color3,color4, nil];
        
    }
    else if(pieChart==myPieChart1)
    {
        MIMColorClass *color1=[MIMColorClass colorWithComponent:@"137,215,234"];
        MIMColorClass *color2=[MIMColorClass colorWithComponent:@"239,95,100"];
        MIMColorClass *color3=[MIMColorClass colorWithComponent:@"127,186,140"];
        MIMColorClass *color4=[MIMColorClass colorWithComponent:@"247,144,187"];
        MIMColorClass *color5=[MIMColorClass colorWithComponent:@"249,219,122"];
        MIMColorClass *color6=[MIMColorClass colorWithComponent:@"144,139,39"];
        MIMColorClass *color7=[MIMColorClass colorWithComponent:@"208,195,135"];
        MIMColorClass *color8=[MIMColorClass colorWithComponent:@"182,119,48"];
        MIMColorClass *color9=[MIMColorClass colorWithComponent:@"183,142,50"];
        MIMColorClass *color10=[MIMColorClass colorWithComponent:@"99,73,56"];
        
        
        colorsArray=[NSArray arrayWithObjects:color1,color5,color2,color3,color4,color6,color7,color8,color9,color10, nil];
    }
    else
        return nil;
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    if(pieChart == myPieChart)
        return [NSArray arrayWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",nil];
    if(pieChart==myPieChart1)
        return [NSArray arrayWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",@"60000",@"18000",@"20000",@"9000",@"12000",nil];
    
    
    return [NSArray arrayWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",nil];
    
}

-(NSArray *)titlesForPie:(id)pieChart
{
    if(pieChart == myPieChart)
        return [NSArray arrayWithObjects:@"Men",@"Women",@"Teens",@"Infants",@"Old",nil];
    
    if(pieChart == myPieChart1)
        return [NSArray arrayWithObjects:@"0-10 Yrs",@"10-20 Yrs",@"20-30 Yrs",@"30-40 Yrs",@"40-50 Yrs",@"50-60 Yrs",@"60-70 Yrs",@"70-80 Yrs",@"80-90 Yrs",@"90-100 Yrs",nil];
    
    
    return [NSArray arrayWithObjects:@"Men",@"Women",@"Teens",@"Infants",@"Old",nil];
    
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
