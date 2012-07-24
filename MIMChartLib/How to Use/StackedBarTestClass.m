//
//  StackedBarTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StackedBarTestClass.h"

@implementation StackedBarTestClass

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
    return @"Stacked Bar Charts";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    barProperty=nil;
    
    UITableViewCell *cell;// = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil) 
    //{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch (indexPath.row) 
    {
        case 0:
        {
            yValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"10",@"21",@"49",@"20",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"9",@"56",@"9000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"17000", nil],nil];
            
            xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"Quarter 1", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug",@"Quarter 2",  nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", @"Quarter 3", nil], nil];
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Q1",@"Q2" , @"Q3" , nil];

            
            barProperty=[[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithBool:NO],@"shadow" ,nil];

            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.stackedBars=YES;
            myBarChart.tag=10+indexPath.row;
            myBarChart.glossStyle=GLOSS_STYLE_1;
            
            myBarChart.rightMargin=50;
            myBarChart.topMargin=50;
            myBarChart.bottomMargin=40;
            
            myBarChart.xTitleStyle=X_TITLES_STYLE3;
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
            
        case 1:
        {
            yValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"10",@"21",@"49",@"20",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"9",@"56",@"9000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"17000", nil],[NSArray arrayWithObjects:@"10",@"21",@"49",@"20",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"9",@"56",@"9000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"17000", nil],nil];
            
            xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"Quarter 1", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug",@"Quarter 2",  nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", @"Quarter 3", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"Quarter 1", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug",@"Quarter 2",  nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", @"Quarter 3", nil], nil];
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Day 1",@"Day 2" , @"Day 3",@"Day 4",@"Day 5" , @"Day 6",nil];

            
            barProperty=[[NSDictionary alloc]initWithObjectsAndKeys:@"50",@"barwidth",nil];
            
            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.stackedBars=YES;
            myBarChart.isGradient=YES;
            myBarChart.gradientStyle=HORIZONTAL_GRADIENT_STYLE;
            myBarChart.xTitleStyle=X_TITLES_STYLE2;
            myBarChart.glossStyle=GLOSS_NONE;
            
            myBarChart.rightMargin=30;
            
            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
        }
            break;
        case 2:
        {
             yValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"10",@"21",@"49",@"20",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"9",@"56",@"9000", nil],[NSArray arrayWithObjects:@"10",@"17",@"43",@"30",@"17000", nil],[NSArray arrayWithObjects:@"20",@"11",@"39",@"30",@"24000", nil],[NSArray arrayWithObjects:@"15",@"20",@"29",@"36",@"9000", nil],[NSArray arrayWithObjects:@"40",@"17",@"23",@"20",@"17000", nil],[NSArray arrayWithObjects:@"20",@"21",@"39",@"20",@"30000", nil],[NSArray arrayWithObjects:@"50",@"17",@"23",@"10",@"27000", nil],[NSArray arrayWithObjects:@"10",@"37",@"23",@"30",@"37000", nil],nil];
            
            
            
            xValuesArray=[[NSArray alloc]initWithObjects:[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil],[NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr", nil],[NSArray arrayWithObjects:@"May",@"Jun",@"Jul",@"Aug", nil],[NSArray arrayWithObjects: @"Sep",@"Oct",@"Nov",@"Dec", nil], nil];
            
            xTitlesArray=[[NSArray alloc]initWithObjects:@"Q1 2009",@"Q2 2009",@"Q3 2009",@"Q1 2010",@"Q2 2010",@"Q3 2010",@"Q1 2011",@"Q2 2011",@"Q3 2011", nil];
            
            
            barProperty=[[NSDictionary alloc]initWithObjectsAndKeys:@"40",@"barwidth", nil];
            
            myBarChart=[[BarChart alloc]initWithFrame:CGRectMake(50, 20, myTableView.frame.size.width-50, myTableView.frame.size.width * 0.5)];
            myBarChart.delegate=self;
            myBarChart.tag=10+indexPath.row;
            myBarChart.stackedBars=YES;
            myBarChart.isGradient=YES;
            myBarChart.gradientStyle=HORIZONTAL_GRADIENT_STYLE;
            myBarChart.xTitleStyle=X_TITLES_STYLE2;

            [myBarChart drawBarChart];
            [cell.contentView addSubview:myBarChart];
            
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
-(NSDictionary *)barProperties:(id)graph; //barwidth,shadow,horGradient,verticalGradient
{
    return barProperty;
}

-(NSDictionary *)horizontalLinesProperties:(id)graph
{
    if([(BarChart *)graph tag]==10)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"1,2",@"dotted", nil];
    
    if([(BarChart *)graph tag]==11)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"4,1",@"dotted", nil];
    
    if([(BarChart *)graph tag]==12)
        return [NSDictionary dictionaryWithObjectsAndKeys:@"1,4",@"dotted", nil];
    
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

-(NSDictionary *)animationOnBars:(id)graph
{
    if([(BarChart *)graph tag]==11)
        return [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:BAR_ANIMATION_VGROW_STYLE],[NSNumber numberWithFloat:0.2],[NSNumber numberWithFloat:0.5],[NSNumber numberWithBool:YES], nil] forKeys:[NSArray arrayWithObjects:@"type",@"animationDelay",@"animationDuration",@"transparentBg" ,nil] ];
   
    
    return nil;
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
