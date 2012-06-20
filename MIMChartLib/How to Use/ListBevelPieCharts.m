//
//  ListBevelPieCharts.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListBevelPieCharts.h"

@interface ListBevelPieCharts()
-(UILabel *)createLabelWithText:(NSString *)text;
@end

@implementation ListBevelPieCharts

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
    return @"Bevel Pie Charts List";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  10;
    
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
           
            
            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=BEIGETINT;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Beige Tint"]];
            
            
        }
            break;
            
        case 1:
        {
      
            
            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=REDTINT;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            
            [cell.contentView addSubview:[self createLabelWithText:@"Red Tint"]];
            
            
        }
            break;
        case 2:
        {
            
  
            
            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=GREENTINT;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Green Tint"]];
            
        }
            break;
        case 3:
        {
            //Colors are defined by delegate method
            //-(NSArray *)colorsForPie:(id)pieChart
          
            myPieChart1=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart1.delegate=self;  
            [myPieChart1 drawPieChart];
            [cell.contentView addSubview:myPieChart1];
            
            [cell.contentView addSubview:[self createLabelWithText:@"User defined colors+ BgColor"]];
            
            
        }
            break;
        case 4:
        {
            
            //Bevel Pie Chart with Gradient
            //See the Delegate method -(NSArray *)gradientsForPie:(id)pieChart
            
            myPieChart3=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5,230 , 220)];
            myPieChart3.delegate=self;  
            [myPieChart3 drawPieChart];
            [cell.contentView addSubview:myPieChart3];
            
            [cell.contentView addSubview:[self createLabelWithText:@"With Gradient Colors"]];
            
            
        }
            break;
        case 5:
        {
            //BEIGE TINT WITH BORDERS
            
            
            
            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=BEIGETINT;
            myPieChart.drawBorders=YES;
            [myPieChart drawPieChart];
            [cell.contentView addSubview:myPieChart];
            
            
            [cell.contentView addSubview:[self createLabelWithText:@"Inbuilt BEIGE tint+ Border"]];
            
        }
            break;
        case 6:
        {
            //RED TINT WITH BORDERS
            
            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5,230 , 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=REDTINT;
            myPieChart.drawBorders=YES;
            [myPieChart drawPieChart];
            
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Inbuilt RED tint+ Border"]];
        }
            break;
        case 7:
        {
            
            //GREEN TINT WITH BORDERS

            myPieChart=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart.delegate=self;  
            myPieChart.tint=GREENTINT;
            myPieChart.drawBorders=YES;
            [myPieChart drawPieChart];
            
            [cell.contentView addSubview:myPieChart];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Inbuilt GREEN tint+ Border"]];
        }
            break;
        case 8:
        {
            
            //User defined colors with delegate method
            //With borders
            
            myPieChart1=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart1.delegate=self;  
            myPieChart1.drawBorders=YES;
            [myPieChart1 drawPieChart];
            [self.view addSubview:myPieChart1];
            
            [cell.contentView addSubview:myPieChart1];
            
            [cell.contentView addSubview:[self createLabelWithText:@"User defined Colors+BgColor+Border"]];
            
            
        }
            break;
        case 9:
        {
            //What happens if you gave gradient as well as border.
            //For gradients given, borders will not work. As it messes up the shadow.
            //Gradients priorize over border for now.
            
            myPieChart3=[[BevelPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 220)];
            myPieChart3.delegate=self;  
            myPieChart3.drawBorders=YES;
            [myPieChart3 drawPieChart];
            
            [cell.contentView addSubview:myPieChart3];
            
            [cell.contentView addSubview:[self createLabelWithText:@"Gradients >> Border"]];
            
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
///http://www.onlinewatchmovieslink.net/2012/03/london-paris-york-2012-hindi-movie-watch-online.html

-(NSArray *)colorsForPie:(id)pieChart
{
    NSArray *colorsArray;

    if(pieChart==myPieChart1)
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
    else if(pieChart == myPieChart2)
    {
        
        MIMColorClass *color1=[MIMColorClass colorWithComponent:@"144,139,39"];
        MIMColorClass *color2=[MIMColorClass colorWithComponent:@"208,195,135"];
        MIMColorClass *color3=[MIMColorClass colorWithComponent:@"182,119,48"];
        MIMColorClass *color4=[MIMColorClass colorWithComponent:@"183,142,50"];
        MIMColorClass *color5=[MIMColorClass colorWithComponent:@"99,73,56"];
        
        
        
        colorsArray=[NSArray arrayWithObjects:color1,color5,color2,color3,color4, nil];
        
    }
    else
        return nil;
    
    return colorsArray;
    
}


-(NSArray *)valuesForPie:(id)pieChart
{    
    
    
    
    return [NSArray arrayWithObjects:@"40000",@"21000",@"24000",@"11000",@"15000",@"10000",@"25000",@"14000",@"19000",@"35000",nil];  
    
}



//GRADIENT  DELEGATE METHOD

-(NSArray *)gradientsForPie:(id)pieChart
{
    
    
    if (pieChart==myPieChart3) 
    {
        
        CGFloat BGLocations[2] = { 0.0, 1.0 };
        CGFloat BgComponents[12] = { 0.564,0.727,0.621 , 1.0,  // Start color
            0.792, 0.823, 0.764 , 1.0}; // End color
        CGColorSpaceRef BgRGBColorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient1 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents, BGLocations, 2);
        
        
        
        CGFloat BGLocations2[2] = { 0.0, 1.0 };
        CGFloat BgComponents2[12] = {0.286,0.713,0.945 , 1.0,  // Start color
            0.8,0.913,0.984, 1.0}; // End color
        CGGradientRef gradient2 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents2, BGLocations2, 2);
        
        
        
        
        
        CGFloat BGLocations3[2] = { 0.0, 1.0 };
        CGFloat BgComponents3[12] = {0.290,0.07,0.552 , 1.0,  // Start color
            0.696,0.554,0.8 , 1.0}; // End color
        CGGradientRef gradient3 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents3, BGLocations3, 2);
        
        
        CGFloat BGLocations4[2] = { 0.0, 1.0 };
        CGFloat BgComponents4[12] = {0.607,0.380,0.0 , 1.0,  // Start color
            0.866,0.788,0.650, 1.0}; // End color
        CGGradientRef gradient4 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents4, BGLocations4, 2);
        
        
        
        CGFloat BGLocations5[2] = { 0.0, 1.0 };
        CGFloat BgComponents5[12] = { 0.933,0.666,0 , 1.0,  // Start color
            1.0,1.0,0.858, 1.0}; // End color
        CGGradientRef gradient5 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents5, BGLocations5, 2);
        
        CGFloat BGLocations6[2] = { 0.0, 1.0 };
        CGFloat BgComponents6[12] = {0.921,0.776,0.807 , 1.0,  // Start color
            1.0,0.917,0.936 , 1.0}; // End color
        CGGradientRef gradient6 = CGGradientCreateWithColorComponents(BgRGBColorspace, BgComponents6, BGLocations6, 2);
        
        
        
        NSArray *g=[NSArray arrayWithObjects:(__bridge id)gradient1,gradient2,gradient3,gradient4,gradient5,gradient6,gradient4,gradient2,gradient1,gradient3,nil];
        
        return g;
        
    }
    
    return nil;
    
}

-(MIMColorClass *)colorForBackground:(id)pieChart
{
    MIMColorClass *bgColor;
    
    if(pieChart==myPieChart1)
        bgColor=[MIMColorClass colorWithComponent:@"1.0,1.0,1.0"];
    
    
    return bgColor;
}



#pragma mark - View lifecycle

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


- (void)viewDidLoad
{
    self.title=@"BEVELED PIE CHARTS";
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
