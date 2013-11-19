//
//  LeftMenuViewController.m
//  CustomSplitViewControll
//
//  Created by Kireto on 11/18/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "LeftMenuViewController.h"

#define viewWidth 256.0

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

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
    self.title = NSLocalizedString(@"Left Menu", @"Left Menu");
    [self.view setBackgroundColor:[UIColor purpleColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width = viewWidth;
    self.view.frame = viewFrame;
    
    viewFrame = self.navigationController.navigationBar.frame;
    viewFrame.size.width = viewWidth;
    self.navigationController.navigationBar.frame = viewFrame;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width = viewWidth;
    self.view.frame = viewFrame;
    
    viewFrame = self.navigationController.navigationBar.frame;
    viewFrame.size.width = viewWidth;
    self.navigationController.navigationBar.frame = viewFrame;
}

@end
