//
//  GaugeGraphTestClass.m
//  MIMChartLib
//
//  Created by Reetu Raj on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GaugeGraphTestClass.h"

@interface GaugeGraphTestClass ()

@end

@implementation GaugeGraphTestClass

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[self.view setBackgroundColor:[UIColor blackColor]];
    
    NSArray *keysArray=[NSArray arrayWithObjects:@"range",@"color", nil];
    NSArray *val1=[NSArray arrayWithObjects:@"0,30",@"1,0,0", nil];
    NSArray *val2=[NSArray arrayWithObjects:@"30,80",@"1,1,0", nil];
    NSArray *val3=[NSArray arrayWithObjects:@"80,100",@"0,1,0", nil];
    
    NSDictionary *a1=[NSDictionary dictionaryWithObjects:val1 forKeys:keysArray];
    NSDictionary *a2=[NSDictionary dictionaryWithObjects:val2 forKeys:keysArray];
    NSDictionary *a3=[NSDictionary dictionaryWithObjects:val3 forKeys:keysArray];
    
    GaugeGraph *graph=[[GaugeGraph alloc]initWithFrame:CGRectMake(50, 50, 250, 250)];
    graph.gaugeValueArray=[NSArray arrayWithObjects:a1,a2,a3,nil];
    graph.currentValue=80; //This should be in terms of percentage
    [self.view addSubview:graph];
    [graph drawGaugeGraph];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

@end
