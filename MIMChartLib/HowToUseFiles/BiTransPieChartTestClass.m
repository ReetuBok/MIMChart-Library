//
//  BiTransPieChartTestClass.m
//  MIMChartLib
//
//  Created by Mac Mac on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BiTransPieChartTestClass.h"

@interface BiTransPieChartTestClass ()

@end

@implementation BiTransPieChartTestClass

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
    //default border width
    BiTransPieChart *myPieChart=[[BiTransPieChart alloc]initWithFrame:CGRectMake(5, 5, 330, 330)];
    myPieChart.innerRadius=25;
    myPieChart.outerRadius=150;
    myPieChart.percentValue=60.0;
    myPieChart.centerIcon=[UIImage imageNamed:@"trans_icon.png"];
    myPieChart.mcolor=[MIMColorClass colorWithComponent:@"0.290,0.07,0.552"];
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    UILabel *myLabel=[[UILabel alloc]initWithFrame:CGRectMake(205, 120, 80, 80)];
    myLabel.textColor=[UIColor whiteColor];
    myLabel.numberOfLines=5;
    myLabel.text=@"60% of entire population in the world belongs to Asian countries."; //NOTE : This is a made up text and statistics!
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    [self.view addSubview:myLabel];
    
    
    
    //You can define border width too
    myPieChart=[[BiTransPieChart alloc]initWithFrame:CGRectMake(5, 335, 330, 330)];
    myPieChart.innerRadius=20;
    myPieChart.outerRadius=150;
    myPieChart.percentValue=60.0;
    myPieChart.borderWidth=5;
    myPieChart.centerIcon=[UIImage imageNamed:@"trans_icon.png"];
    myPieChart.mcolor=[MIMColorClass colorWithComponent:@"0.290,0.07,0.552"];
    [myPieChart drawPieChart];
    [self.view addSubview:myPieChart];
    
    myLabel=[[UILabel alloc]initWithFrame:CGRectMake(205, 450, 80, 80)];
    myLabel.textColor=[UIColor whiteColor];
    myLabel.numberOfLines=5;
    myLabel.text=@"60% of entire population in the world belongs to Asian countries."; //NOTE : This is a made up text and statistics!
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    [self.view addSubview:myLabel];
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



#pragma mark - Pie Chart Delegate Methods
//NO delegate methods are relevant for this pie chart

@end
