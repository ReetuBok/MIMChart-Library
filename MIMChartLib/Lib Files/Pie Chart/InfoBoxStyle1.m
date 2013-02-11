//
//  InfoBoxStyle1.m
//  MIMChartLib
//
//  Created by Reetu Raj on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoBoxStyle1.h"
#import <QuartzCore/QuartzCore.h>


@implementation InfoBoxStyle1
@synthesize fontName;
@synthesize fontColor;
@synthesize shadowBehindBoxes;
@synthesize infoBoxSmoothenCorners;
@synthesize centerOfPie;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        fontName=[UIFont fontWithName:@"Helvetica" size:12];
        fontColor=[MIMColorClass colorWithRed:0 Green:0 Blue:0 Alpha:1];
        
    }
    return self;
}


-(void)initInfoBoxWithTitles:(NSArray *)titles withSquareColor:(NSArray *)sqColor //If titles include % value, show it.
{
    float defaultSize =20;
    
    infoScrollView=[[ScrollViewSubClass alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    infoScrollView.tag=836913;
    [infoScrollView setBackgroundColor:[UIColor clearColor]];
    
    for (int i=0; i<[titles count]; i++) 
    {
        UILabel *titleSQ=[[UILabel alloc]initWithFrame:CGRectMake(5, i*defaultSize+10,10, 10)];
        titleSQ.tag=100+i;
        MIMColorClass *scolor=[sqColor objectAtIndex:i];
        [titleSQ setBackgroundColor:[UIColor colorWithRed:scolor.red green:scolor.green blue:scolor.blue alpha:scolor.alpha]];
        
        
        //Its not working right for some reason.
        if(shadowBehindBoxes)
        {
            [titleSQ.layer setShadowRadius:5.0];
            [titleSQ.layer setShadowColor:[UIColor redColor].CGColor];
            [titleSQ.layer setShadowOffset:CGSizeMake(3, 0)];
            [titleSQ.layer setShadowOpacity:0.5];
            
        }
        
        if(infoBoxSmoothenCorners)
            titleSQ.layer.cornerRadius=3.0;
        
        
        [infoScrollView addSubview:titleSQ];
        
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, i*defaultSize, CGRectGetWidth(self.frame)-25, defaultSize)];
        titleLabel.tag=100+i;
        
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:fontName];
        [titleLabel setTextColor:[UIColor colorWithRed:fontColor.red green:fontColor.green blue:fontColor.blue alpha:fontColor.alpha]];
        [titleLabel setText:[titles objectAtIndex:i]];
        [infoScrollView addSubview:titleLabel];
        

        
    }
    
    [self addSubview:infoScrollView];
    [infoScrollView setContentSize:CGSizeMake(CGRectGetWidth(self.frame), 30*[titles count])];
    contentHeight=30*[titles count];
    
    if(30*[titles count]>CGRectGetHeight(infoScrollView.frame))
    {    
        [self performSelector:@selector(showScrollBar) withObject:nil afterDelay:0.5];
    }
    
}

-(void)showScrollBar
{
    [infoScrollView setContentOffset:CGPointMake(0,-0.05) animated:YES];
    [infoScrollView flashScrollIndicators];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Fading Effect Implementation ??
}

-(void)LabelTapped:(int)touchedViewTag
{
  
        NSLog(@"touchedViewTag=%i",touchedViewTag);
        float yOffset=(CGRectGetMinY(self.frame)+ 30*touchedViewTag)-self.centerOfPie;
        yOffset+=15;
        [infoScrollView setContentOffset:CGPointMake(0,yOffset) animated:YES];
    
        //Call BasicPieChart the superview
        //send the index and tell it to rotate the pie
        [(BasicPieChart *)self.superview rotatePieToIndex:touchedViewTag whichDirection:1];

}

@end
