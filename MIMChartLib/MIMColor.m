/*
 Copyright (C) 2011  Reetu Raj (reetu.raj@gmail.com)
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *///
//  MIMColor.m
//  MIMChartLib
//
//  Created by Reetu Raj on 11/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MIMColor.h"

/*
 
 Note: we will be writing all static methods here. (with + in the beginnning)
 And don't  forget to declare them in .h after writing them here.
 
 For plain color, you can simply make dictionary first and
 then keep adding them in array called colorValues.
 You can refer to +(void)nonAdjacentPlainColors
 if you have any confusion.
 
 
 For Gradient Colors, Right now we only support 2 gradients only.
 You will make dictionary of dark component of Gradient first
 and add it to array called colorValues.
 Then you will dictionary of light component of Gradient
 and add it to the same array
 You can refer to +(void)InitFragmentedBarColors
 if you have any confusion.
 
 */

static NSMutableArray *colorValues;

@implementation MIMColor


+(NSDictionary *)GetColorAtIndex:(int)index
{
    return [colorValues objectAtIndex:index];
}

+(void)InitGreenTintColors
{
    colorValues=[[NSMutableArray alloc]init];

  
    
    NSDictionary *newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.88f",@"0.84f",@"0.84f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:newColor];
    
   
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.56f",@"0.737f",@"0.749", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];

    [colorValues addObject:newColor];
    

    
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.58f",@"0.74f",@"0.553f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];

    [colorValues addObject:newColor];
    
  
    
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.749f",@"0.764f",@"0.678f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];

    [colorValues addObject:newColor];
    

    
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.168f",@"0.486f",@"0.356f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:newColor];
    
    

    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.196f",@"0.439f",@"0.164f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:newColor];
    
  
    
    
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.25f",@"0.474f",@"0.411f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:newColor];
    

    
    newColor=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.29f",@"0.517f",@"0.223f", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:newColor];
    
    
}

+(void)InitColors
{
    
    colorValues=[[NSMutableArray alloc]init];
    
    NSDictionary *color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.56",@"0.678",@"0.63", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.815",@"0.913",@"0.839", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.894",@"0.937",@"0.913", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.815",@"0.843",@"0.709", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.733",@"0.8",@"0.525", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.596",@"0.721",@"0.427", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.133",@"0.270",@"0.247", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.211",@"0.325",@"0.458", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.603",@"0.733",@"0.854", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.882",@"0.925",@"0.941", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.851",@"0.858",@"0.905", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.909",@"0.729",@"0.839", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.654",@"0.431",@"0.749", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.133",@"0.109",@"0.36", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.392",@"0.521",@"0.65", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    //-- brown tint
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.709",@"0.776",@"0.839", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.921",@"0.827",@"0.882", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.941",@"0.847",@"0.807", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.941",@"0.713",@"0.666", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.780",@"0.407",@"0.423", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.639",@"0.149",@"0.125", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.423",@"0.176",@"0.207", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    //----
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.529",@"0.251",@"0.180", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.835",@"0.494",@"0.317", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.823",@"0.623",@"0.439", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.89",@"0.682",@"0.47", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.87",@"0.756",@"0.521", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.949",@"0.905",@"0.729", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.945",@"0.882",@"0.541", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.894",@"0.792",@"0.223", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.882",@"0.733",@"0.454", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.839",@"0.709",@"0.635", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.796",@"0.721",@"0.666", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.874",@"0.811",@"0.721", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.921",@"0.882",@"0.843", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.89",@"0.866",@"0.913", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.843",@"0.815",@"0.847", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    //--
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.741",@"0.705",@"0.717", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.615",@"0.576",@"0.607", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.505",@"0.454",@"0.494", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.262",@"0.251",@"0.286", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.027",@"0.003",@"0.011", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    NSLog(@"colorValues count=%i",colorValues.count);
    
}

/*Gradient Color Array*/
+(void)InitFragmentedBarColors
{
    
    colorValues=[[NSMutableArray alloc]init];
    
    
    
    NSDictionary *color;

    //---blue : dark of gradient
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.04",@"0.04",@"0.81", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    //---blue : light of gradient
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.4",@"0.4",@"1.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];

    
    
    //---ocean blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.0",@"0.5",@"0.5", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.0",@"0.9",@"0.9", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];

        
    //shade of purple
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.4",@"0",@"0.4", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.929",@"0.011",@"0.929", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
   
    
    //shade of green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.019",@"0.301",@"0.011", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.384",@"0.568",@"0.364", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];

   
    //----shade of crimson
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.352",@"0",@"0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.976",@"0.086",@"0.384", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    //---orange
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.827",@"0.403",@"0.007", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.976",@"0.756",@"0.431", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    ///shade of green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.537",@"0.537",@"0.227", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"1.0",@"0.701", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    // shade of purple
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.290",@"0.07",@"0.552", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.696",@"0.554",@"0.8", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    
    
    //shade of green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.149",@"0.282",@"0.121", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.509",@"0.858",@"0.443", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    
    
    //---green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.298",@"0.556",@"0.141", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.698",@"0.890",@"0.439", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    

    
 
    //shade of orange
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.886",@"0.321",@"0.117", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.972",@"0.674",@"0.254", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    
    
    
    //---red
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.541",@"0.062",@"0.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.921",@"0.490",@"0.384", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    //shade of maroon
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.207",@"0.098",@"0.097", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.592",@"0.458",@"0.454", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    //---shade of red
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.639",@"0.149",@"0.125", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"0.0",@"0.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
   
}

/*Gradient Color Array*/
+(void)nonAdjacentGradient
{
    
    colorValues=[[NSMutableArray alloc]init];

    
    
   
    NSDictionary *color;

    //---red
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.541",@"0.062",@"0.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.921",@"0.490",@"0.384", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    //---green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.298",@"0.556",@"0.141", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.698",@"0.890",@"0.439", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    //---orange
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.827",@"0.403",@"0.007", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.976",@"0.756",@"0.431", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
        
    //---ocean blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.0",@"0.5",@"0.5", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.0",@"0.9",@"0.9", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    
     //---blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.04",@"0.04",@"0.81", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.4",@"0.4",@"1.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    

    
    
    //shade of purple
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.4",@"0",@"0.4", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.929",@"0.011",@"0.929", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
}

/*Non-Gradient Color Array*/
+(void)nonAdjacentPlainColors
{
    
    colorValues=[[NSMutableArray alloc]init];
    
    
    
    
    NSDictionary *color;
    
    
    
    
    //---red
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.541",@"0.062",@"0.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    
    //---green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.298",@"0.556",@"0.141", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    //---orange
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.827",@"0.403",@"0.007", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    //---ocean blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.0",@"0.5",@"0.5", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];

    
    
    
    //---blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.04",@"0.04",@"0.81", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
   
    
    
    //shade of green
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.537",@"0.537",@"0.227", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
}

/*Gradient Color Array*/
+(void)lightGradients
{

    colorValues=[[NSMutableArray alloc]init];

    
    //green shade    
    NSDictionary *color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.564",@"0.727",@"0.621", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.792",@"0.823",@"0.764", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    //shade of blue
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.286",@"0.713",@"0.945", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.8",@"0.913",@"0.984", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    //shade of pink
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.921",@"0.776",@"0.807", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"0.917",@"0.936", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    //shade of brown
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.607",@"0.380",@"0.0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.866",@"0.788",@"0.650", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];

    
    
    //shade of orange
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"0.933",@"0.666",@"0", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"1.0",@"0.858", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    

    
    
    
    //shade of yellow
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"1.0",@"0.011", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    color=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"1.0",@"1.0",@"0.725", nil] forKeys:[NSArray arrayWithObjects:@"red",@"green",@"blue", nil]];
    [colorValues addObject:color];
    
    
    
}




+(NSInteger)sizeOfColorArray
{
    return [colorValues count];
}

@end
