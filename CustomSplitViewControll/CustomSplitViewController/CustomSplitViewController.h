//
//  CustomSplitViewController.h
//  CustomSplitViewControll
//
//  Created by Kireto on 11/15/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomSplitViewControllerPanLeft,
    CustomSplitViewControllerPanRight,
    CustomSplitViewControllerPanNone,
} CustomSplitViewControllerPanDirection;

@interface CustomSplitViewController : UIViewController

@property(nonatomic,strong)UIView *centerView;
@property(nonatomic,strong)UIViewController* centerController;
@property(nonatomic,strong)UIViewController* leftController;
@property(nonatomic,assign)BOOL panningDisabled;

- (id)initWithCenterViewController:(UIViewController*)centerController
                leftViewController:(UIViewController*)leftController;

- (void)setNewCenterViewController:(UIViewController*)centerController;
- (void)setNewLeftViewController:(UIViewController*)leftController;

- (void)setupLeftMenuButtonForController:(UIViewController*)controller;

- (void)toggleLeftView;
- (void)removePanGessture;
- (void)addPanGessture;

@end
