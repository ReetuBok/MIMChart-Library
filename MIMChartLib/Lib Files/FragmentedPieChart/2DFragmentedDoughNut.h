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
//  2DFragmentedDoughNut.h
//  MIM3D
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoughtNutFragmentTitle.h"
#import "MIMColor.h"


typedef enum
{
    REDTINT,
    GREENTINT,
    BEIGETINT
    
    
}TINTCOLOR;

@interface _DFragmentedDoughNut : UIView {
    
    NSArray *valuesArray;
    NSArray *titleArray;
    NSMutableArray *colorArray;
    float innerRadius;
    float outerRadius;
    TINTCOLOR tint;
    CGPoint center;
    BOOL isShadow;
}

@property(nonatomic,retain)NSArray *valuesArray;
@property(nonatomic,retain)NSArray *titleArray;
@property(nonatomic,assign) TINTCOLOR tint;
@property(nonatomic,assign) CGPoint center;
@property(nonatomic,assign) BOOL isShadow;

-(void)setOutRadius:(float)ORadius AndInnerRadius:(float)IRadius;
-(void)drawTitles:(CGFloat)val WithRotation:(CGFloat)angle  WithOffset:(CGFloat)offset  WithTitle:(NSString *)titleVal;
@end
