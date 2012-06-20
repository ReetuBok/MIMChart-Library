//
//  MIMPieChartDelegate.h
//  MIMChartLib
//
//  Created by Mac Mac on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"
#import "MIMColorClass.h"


@protocol MIMPieChartDelegate <NSObject>



@optional

/**User can choose to give his own UI for detail Pop up ***/
-(UIView *)viewForPopUpAtIndex:(int)index;



/************************************************************************************************************************************************/
// PROPERTIES OF PIECHART
/************************************************************************************************************************************************/

-(float)radiusForPie:(id)pieChart;








/************************************************************************************************************************************************/
//  BACKGROUND
/************************************************************************************************************************************************/

//Set background simple Color
-(MIMColorClass *)colorForBackground:(id)pieChart;

//Set background gradient



//Set background UIView



/************************************************************************************************************************************************/
//  VALUES FOR PIECHART
/************************************************************************************************************************************************/

-(NSArray *)valuesForPie:(id)pieChart;


/**********************************************************************************************************************/
//  TITLES FOR PIECHART
/**********************************************************************************************************************/

-(NSArray *)titlesForPie:(id)pieChart;
-(NSArray *)DescriptionForPie:(id)pieChart;
-(NSArray *)IconForPie:(id)pieChart;





/************************************************************************************************************************************************/
// COLORS FOR PIE SECTIONS
/************************************************************************************************************************************************/



//User can give simple color array
-(NSArray *)colorsForPie:(id)pieChart;



//User can give border colors for each pie
//In Future, it will pick up light/dark mode for border colors Automatically.
-(NSArray *)bordercolorsForPie:(id)pieChart;

//User should be able to give an array of gradient CGGradientRef and also how to be applied like line or circular.
//User should be able to give dic of colors and we will create the gradient for them
-(NSArray *)gradientsForPie:(id)pieChart;

/*If this delegate method is not called, it just applies radial gradient */
/*If you pass only single gradient in this, it will apply that gradient to all */
/*If you return same number of elements as number of sections in piechart, it will apply them in clockwise order */
-(NSArray *)gradientsTypeForPie:(id)pieChart; 







/************************************************************************************************************************************************/
//  VALUES FOR PIECHART
/************************************************************************************************************************************************/



/************************************************************************************************************************************************/
// DETAILED VIEW  FOR PIE SECTIONS
/************************************************************************************************************************************************/


-(UIView *)detailedViewForPieSectionAtIndex:(int)index; 



//BY default, Gloss of OFF, you can have gloss effect by returning YES in this 
//delegate method.
-(BOOL)GlossEffect;
-(float)BorderWidth; //it takes default value of 2.0 px
-(UIColor *)BorderColor;
@end


