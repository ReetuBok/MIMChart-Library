/*
 Copyright (C) 2011- 2012  Reetu Raj (reetu.raj@gmail.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 and associated documentation files (the “Software”), to deal in the Software without 
 restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom
 the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or 
 substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
 ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *///
//  2DFragmentedDoughNut.h
//  MIM2D Library
//
//  Created by Reetu Raj on 01/08/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoughtNutFragmentTitle.h"
#import "MIMColor.h"
#import "FragmentedDoughNutDelegate.h"
#import "Constant.h"

@interface MIMFragmentedDoughNut : UIView {
    
    
    NSMutableArray *colorArray;
    
    TINTCOLOR tint;
    CGPoint center;
    BOOL isShadow;
    
    id<FragmentedDoughNutDelegate>delegate;
    
    @private

    
    float innerRadius;
    float outerRadius;
}
@property(nonatomic,retain)id<FragmentedDoughNutDelegate>delegate;

@property(nonatomic,assign) TINTCOLOR tint;
@property(nonatomic,assign) CGPoint center;
@property(nonatomic,assign) BOOL isShadow;

-(void)drawDoughNut;
-(void)drawTitles:(CGFloat)val WithRotation:(CGFloat)angle  WithOffset:(CGFloat)offset  WithTitle:(NSString *)titleVal;
@end
