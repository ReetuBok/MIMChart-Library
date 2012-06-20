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
//  Anchor.h
//  MIM2D Library
//
//  Created by Reetu Raj on 07/07/11.
//  Copyright (c) 2012 __MIM 2D__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorDelegate.h"

typedef enum{

    SQUAREFILLED=1,
    SQUAREBORDER=2,
    CIRCLEFILLED=3,
    CIRCLEBORDER=4,
    NONE=5,
    DEFAULT=6,
    
}ANCHORTYPE;

@interface Anchor : UIView {
    
    id<AnchorDelegate> delegate;
    long int idTag;
    ANCHORTYPE type;
    BOOL highlightOn;
    BOOL moveOn;
    UIColor *color;
    BOOL enabled;
    BOOL isShadow;

}
@property(nonatomic,strong)id <AnchorDelegate>delegate;
@property(nonatomic,assign)    ANCHORTYPE type;
@property(nonatomic,assign)long int idTag;
@property(nonatomic,assign)BOOL highlightOn;
@property(nonatomic,assign)BOOL moveOn;
@property(nonatomic,retain)UIColor *color;
@property(nonatomic,assign)BOOL enabled;
@property(nonatomic,assign)BOOL isShadow;

-(void)drawAnchor;
@end
