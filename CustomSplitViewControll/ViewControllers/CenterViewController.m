//
//  CenterViewController.m
//  CustomSplitViewControll
//
//  Created by Kireto on 11/18/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "CenterViewController.h"
#import "AppDelegate.h"
#import "CustomSplitViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Center Controller", @"Center Controller");
    [self.view setBackgroundColor:[UIColor orangeColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    else {
        [[AppDelegate instance].customSplitViewController setupLeftMenuButtonForController:self];
    }
}

@end
