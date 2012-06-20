//
//  DetailViewStyle3.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewStyle3.h"

@implementation DetailViewStyle3

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
    if([indexPath row]==2 || [indexPath row]==3)
        return 450;
    else
        return 250;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return  1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Detail View Style 3 For Pie Charts (Tap on Pie to view pop Up)";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  4;
    
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
            
            myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(5, 5, 220, 240)];
            myPieChart.delegate=self;
            myPieChart.userTouchAllowed=YES;
            myPieChart.arrowDirection=DIRECTION_LEFT;//This is default alignment
            myPieChart.detailPopUpType=mPIE_DETAIL_POPUP_TYPE3;
            myPieChart.detailPopUpRoundedCorner=TRUE;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Default Alignment of Detail POp up Style3"]];
            
            
        }
            break;
        case 1:
        {
            
            myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(305, 5, 220, 240)];
            myPieChart.delegate=self;
            myPieChart.userTouchAllowed=YES;
            myPieChart.detailPopUpType=mPIE_DETAIL_POPUP_TYPE3;
            myPieChart.arrowDirection=DIRECTION_RIGHT;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Right Alignment of Detail POp up Style3"]];
            
            
        }
            break;
        case 2:
        {
            
            myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(5, 225, 220, 240)];
            myPieChart.delegate=self;
            myPieChart.userTouchAllowed=YES;
            myPieChart.detailPopUpType=mPIE_DETAIL_POPUP_TYPE3;
            myPieChart.arrowDirection=DIRECTION_BOTTOM;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Bottom Alignment of Detail POp up Style3"]];
            
            
        }
            break;
        case 3:
        {
            
            myPieChart=[[BasicPieChart alloc]initWithFrame:CGRectMake(305, 5, 220, 240)];
            myPieChart.delegate=self;
            myPieChart.userTouchAllowed=YES;
            myPieChart.detailPopUpType=mPIE_DETAIL_POPUP_TYPE3;
            myPieChart.arrowDirection=DIRECTION_TOP;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            [cell.contentView addSubview:[self createLabelWithText:@"Basic Pie Chart Touch Enabled+ Top Alignment of Detail POp up Style3"]];
            
            
        }
            break;
            
            
    }
    
    
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
    else
        return nil;
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    return [NSArray arrayWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",nil];
    
}

-(NSArray *)titlesForPie:(id)pieChart
{
    return [NSArray arrayWithObjects:@"Men",@"Women",@"Teens",@"Infants",@"Old",nil];
}

-(NSArray *)DescriptionForPie:(id)pieChart
{
    return [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc venenatis placerat faucibus. Sed sit amet nunc vitae nisl vulputate faucibus non ut urna. In auctor purus vitae ligula accumsan semper. Vestibulum ligula nulla, sodales sit amet consequat et, ultricies ut diam. Praesent lectus nulla, tempor et fermentum in, consectetur sed enim. Curabitur ut nibh quam, sit amet vehicula nisi.",@"Women DESCRIPTION:Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc venenatis placerat faucibus. Sed sit amet nunc vitae nisl vulputate faucibus non ut urna. In auctor purus vitae ligula accumsan semper. Vestibulum ligula nulla, sodales sit amet consequat et, ultricies ut diam. Praesent lectus nulla, tempor et fermentum in, consectetur sed enim. Curabitur ut nibh quam, sit amet vehicula nisi.",@"Teens DESCRIPTION:Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc venenatis placerat faucibus. Sed sit amet nunc vitae nisl vulputate faucibus non ut urna. In auctor purus vitae ligula accumsan semper. Vestibulum ligula nulla, sodales sit amet consequat et, ultricies ut diam. Praesent lectus nulla, tempor et fermentum in, consectetur sed enim. Curabitur ut nibh quam, sit amet vehicula nisi.",@"Infants DESCRIPTION:Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc venenatis placerat faucibus. Sed sit amet nunc vitae nisl vulputate faucibus non ut urna. In auctor purus vitae ligula accumsan semper. Vestibulum ligula nulla, sodales sit amet consequat et, ultricies ut diam. Praesent lectus nulla, tempor et fermentum in, consectetur sed enim. Curabitur ut nibh quam, sit amet vehicula nisi.",@"Old DESCRIPTION:Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc venenatis placerat faucibus. Sed sit amet nunc vitae nisl vulputate faucibus non ut urna. In auctor purus vitae ligula accumsan semper. Vestibulum ligula nulla, sodales sit amet consequat et, ultricies ut diam. Praesent lectus nulla, tempor et fermentum in, consectetur sed enim. Curabitur ut nibh quam, sit amet vehicula nisi.",nil];
}

-(NSArray *)IconForPie:(id)pieChart
{
    return [NSArray arrayWithObjects:@"pajarito1.png",@"pajarito2.png",@"pajarito3.png",@"pajarito4.png",@"",nil];
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
