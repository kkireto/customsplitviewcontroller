//
//  LeftMenuButton.m
//  CustomSplitViewControll
//
//  Created by Kireto on 9/20/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "LeftMenuButton.h"
#import "Globals.h"

@implementation LeftMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"menuButtonHighlighted"] forState:UIControlStateSelected];
        [self setBackgroundImage:[UIImage imageNamed:@"menuButtonHighlighted"] forState:UIControlStateHighlighted];
        [self setFrame:CGRectMake(0.0, 0.0, 50.0, 44.0)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIEdgeInsets)alignmentRectInsets {
    UIEdgeInsets insets;
    if ([Globals isOSVerionGreaterThanOrEqualTo:7.0]) {
        insets = UIEdgeInsetsMake(0, 11, 0, 0);
    } else {
        insets = UIEdgeInsetsZero;
    }
    
    return insets;
}

@end
