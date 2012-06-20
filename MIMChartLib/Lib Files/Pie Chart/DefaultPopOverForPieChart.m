//
//  DefaultPopOverForPieChart.m
//  MIMChartLib
//
//  Created by Reetu Raj on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DefaultPopOverForPieChart.h"

@implementation DefaultPopOverForPieChart
@synthesize  ptitle;
@synthesize  icon;
@synthesize  summary;
@synthesize  detail;


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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.contentSizeForViewInPopover=CGSizeMake(200, 150);
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(45, 2, 160, 40)];    
    titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(45, 2, 160, 40)];
    titleLabelBg=[[UILabel alloc]initWithFrame:CGRectMake(3, 40, 200-6, 1)];
    descriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 42, 190, 110)];
    
  
    
    
    [titleLabelBg setBackgroundColor:[UIColor lightGrayColor]];
    [titleLabelBg setAlpha:0.5];
    [self.view addSubview:titleLabelBg];
    
    [titleLabel setText:ptitle];
    [titleLabel setTextColor:[UIColor blackColor]];
    titleLabel.numberOfLines=2;
    titleLabel.lineBreakMode=UILineBreakModeWordWrap;
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [self.view addSubview:titleLabel];
    
    
    [descriptionLabel setText:summary];
    [descriptionLabel setTextColor:[UIColor blackColor]];
    descriptionLabel.numberOfLines=5;
    descriptionLabel.baselineAdjustment=TRUE;
    descriptionLabel.lineBreakMode=UILineBreakModeWordWrap;
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [self.view addSubview:descriptionLabel];

    
    [super viewDidLoad];
}
#pragma mark - CLASS METHODS

-(void)createTheView
{
    
    
    

    if(![icon isEqualToString:@""])
    {
        [iconImg setHidden:NO];
        UIImage *im=[UIImage imageNamed:icon];
        [iconImg setImage:im];
        iconImg.frame=CGRectMake(1, 1, im.size.width, im.size.height);
        [self.view addSubview:iconImg];
        
        titleLabel.frame=CGRectMake(im.size.width+5, 2, 160, 40);
        titleLabelBg.frame=CGRectMake(3, im.size.height+5, 200-6, 1);
        descriptionLabel.frame=CGRectMake(5, im.size.height+5, 190, 110);
        
    }
    else
    {
        [iconImg setHidden:YES];
        titleLabel.frame=CGRectMake(45, 2, 160, 40);
        titleLabelBg.frame=CGRectMake(3, 40, 200-6, 1);
        descriptionLabel.frame=CGRectMake(5, 42, 190, 110);
    }
    
    
    [titleLabel setText:ptitle];

    
    
    
    [descriptionLabel setText:summary];
 
    
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
