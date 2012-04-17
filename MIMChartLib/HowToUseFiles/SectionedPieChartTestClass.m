//
//  SectionedPieChartTestClass.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SectionedPieChartTestClass.h"

@interface SectionedPieChartTestClass ()

@end

@implementation SectionedPieChartTestClass

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
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}

- (void)viewDidLoad
{
    myPieChart=[[SectionedPieChart alloc]initWithFrame:CGRectMake(5, 5, 500, 350)];
    myPieChart.delegate=self;
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
@end
