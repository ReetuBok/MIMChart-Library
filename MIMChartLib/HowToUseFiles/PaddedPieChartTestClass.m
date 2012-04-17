//
//  PaddedPieChartTestClass.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaddedPieChartTestClass.h"

@interface PaddedPieChartTestClass ()

@end

@implementation PaddedPieChartTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
}

- (void)viewDidLoad
{
    
    
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 5, 230, 230)];
    //Define all the properties
    myPieChart.delegate=self;
    myPieChart.paddingPixels=2.0;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    
    
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(235, 5, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=2.0;
    myPieChart.glossEffect=YES;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(465, 5, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=8.0;
    myPieChart.glossEffect=YES;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    //border
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 235, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=3.0;
    myPieChart.borderWidth=8.0;
    myPieChart.glossEffect=YES;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    
    
    //border
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(235, 235, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=3.0;
    myPieChart.borderWidth=4.0;
    myPieChart.glossEffect=YES;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(465, 235, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=3.0;
    myPieChart.borderWidth=4.0;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    myPieChart=[[PaddedPieChart alloc]initWithFrame:CGRectMake(5, 465, 230, 230)];
    myPieChart.delegate=self;
    myPieChart.paddingPixels=2.0;
    myPieChart.borderWidth=2.0;
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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

//-(float)BorderWidth
//{
//    return 0.0;
//}
@end
