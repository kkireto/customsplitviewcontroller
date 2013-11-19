//
//  CustomSplitViewController.m
//  CustomSplitViewControll
//
//  Created by Kireto on 11/15/13.
//  Copyright (c) 2013 No Name. All rights reserved.
//

#import "CustomSplitViewController.h"
#import "LeftMenuButton.h"

#define shadowOffset 9.0
#define leftControllerWidth 256.0
#define centerControllerWidth 768.0

@interface CustomSplitViewController ()

@property(nonatomic,assign)CGFloat touchOffset;
@property(nonatomic,assign)CGFloat topOffset;
@property(nonatomic,assign)BOOL isLeftControllerVisible;
@property(nonatomic,strong)UIPanGestureRecognizer *panGesture;
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,assign)CustomSplitViewControllerPanDirection panDirection;

@end

@implementation CustomSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCenterViewController:(UIViewController*)centerController
                leftViewController:(UIViewController*)leftController
{
    self = [super init];
    if (self) {
        // Custom initialization
        _centerController = centerController;
        _leftController = leftController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:38.0/255.0 blue:42.0/255.0 alpha:1.0];
    self.navigationController.navigationBarHidden = YES;
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _topOffset = 0.0;
    
    [self createCenterView];
    [self setupView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self removePanGessture];
    _isLeftControllerVisible = NO;
    if ((toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) {
        
    }
    else {
        [self addPanGessture];
    }
    if (_centerController) {
        [_centerView setFrame:CGRectMake(self.view.frame.size.width - centerControllerWidth - shadowOffset, _topOffset - shadowOffset, centerControllerWidth + 2*shadowOffset, self.view.frame.size.height + 2*shadowOffset)];
        _centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [_centerController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
    if (_leftController) {
        [_leftController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (_centerController) {
        [_centerController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
    if (_leftController) {
        [_leftController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

#pragma mark - setup view
- (void)setupView {
    
    if (_centerController) {
        [_centerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _centerView.frame.size.width - 2*shadowOffset, _centerView.frame.size.height - 2*shadowOffset)];
        _centerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _centerController.view.layer.cornerRadius = 4.0;
        _centerController.view.layer.masksToBounds = YES;
        [_centerView addSubview:_centerController.view];
        
        if (_leftController) {
            [_leftController.view setFrame:CGRectMake(0.0, _topOffset, leftControllerWidth, self.view.frame.size.height)];
            _leftController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            _leftController.view.layer.cornerRadius = 4.0;
            _leftController.view.layer.masksToBounds = YES;
            [self.view insertSubview:_leftController.view belowSubview:_centerView];
        }
    }
}

- (void)createCenterView {
    
    if (_centerView) {
        [_centerView removeFromSuperview];
        _centerView = nil;
    }
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - centerControllerWidth - shadowOffset, _topOffset - shadowOffset, centerControllerWidth + 2*shadowOffset, self.view.frame.size.height + 2*shadowOffset)];
    _centerView.backgroundColor = [UIColor clearColor];
    _centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_centerView];
    
    UIImage *shadowImage = [[UIImage imageNamed:@"drawerShadow"]stretchableImageWithLeftCapWidth:30.0 topCapHeight:30.0];
    UIImageView *shadowBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _centerView.frame.size.width, _centerView.frame.size.height)];
    shadowBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [shadowBgView setImage:shadowImage];
    shadowBgView.backgroundColor = [UIColor clearColor];
    shadowBgView.userInteractionEnabled = YES;
    [_centerView addSubview:shadowBgView];
    
    [_centerView addGestureRecognizer:_panGesture];
}

#pragma mark - left menu button
- (void)setupLeftMenuButtonForController:(UIViewController*)controller {
    
    LeftMenuButton *leftMenuButton = [LeftMenuButton buttonWithType:UIButtonTypeCustom];
    [leftMenuButton addTarget:self action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
	UIBarButtonItem *leftMenuBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
	controller.navigationItem.leftBarButtonItem = leftMenuBarButton;
}

#pragma mark - public methods
- (void)setNewCenterViewController:(UIViewController*)centerController {
    
    self.view.userInteractionEnabled = NO;
    if (_centerController) {
        [_centerController.view removeFromSuperview];
        _centerController = nil;
    }
    
    _centerController = centerController;
    [_centerController.view setFrame:CGRectMake(shadowOffset, shadowOffset, _centerView.frame.size.width - 2*shadowOffset, _centerView.frame.size.height - 2*shadowOffset)];
    _centerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _centerController.view.layer.cornerRadius = 4.0;
    _centerController.view.layer.masksToBounds = YES;
    [_centerView addSubview:_centerController.view];
    
    [self resetViewFrames];
}

- (void)setNewLeftViewController:(UIViewController*)leftController {
    
    if (_leftController) {
        [_leftController.view removeFromSuperview];
        _leftController = nil;
    }
    _leftController = leftController;
    [_leftController.view setFrame:CGRectMake(0.0, _topOffset, leftControllerWidth, self.view.frame.size.height)];
    _leftController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _leftController.view.layer.cornerRadius = 4.0;
    _leftController.view.layer.masksToBounds = YES;
    [self.view insertSubview:_leftController.view belowSubview:_centerView];
}

- (void)toggleLeftView {
    
    _isLeftControllerVisible = !_isLeftControllerVisible;
    [self animateCenterView];
}

- (void)removePanGessture {
    if (_centerController) {
        [_centerView removeGestureRecognizer:_panGesture];
    }
}

- (void)addPanGessture {
    if (_centerController) {
        [_centerView addGestureRecognizer:_panGesture];
    }
}

#pragma mark -
#pragma mark - pan gesture
- (void)handlePanGesture:(UIPanGestureRecognizer*)panGesture {
    
    CGPoint location = [panGesture locationInView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        
        _touchOffset = location.x;
        
        if (_isLeftControllerVisible) {
            _panDirection = CustomSplitViewControllerPanLeft;
        }
        else {
            _panDirection = CustomSplitViewControllerPanRight;
        }
    }
    else if (panGesture.state == UIGestureRecognizerStateCancelled || panGesture.state == UIGestureRecognizerStateEnded) {
        [self panningEnded];
    }
    else {
        CGFloat positionX = location.x - _touchOffset;
        if (_panDirection == CustomSplitViewControllerPanLeft) {
            positionX += leftControllerWidth;
            if (positionX < -shadowOffset) {
                positionX = -shadowOffset;
            }
            else if (positionX > leftControllerWidth - shadowOffset) {
                positionX = leftControllerWidth - shadowOffset;
            }
        }
        else if (_panDirection == CustomSplitViewControllerPanRight) {
            if (positionX < -shadowOffset) {
                positionX = -shadowOffset;
            }
            else if (positionX > (leftControllerWidth - shadowOffset)) {
                positionX = leftControllerWidth - shadowOffset;
            }
        }
        
        [_centerView setFrame:CGRectMake(positionX, _topOffset - shadowOffset, centerControllerWidth + 2*shadowOffset, self.view.frame.size.height + 2*shadowOffset)];
        _centerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
}

- (void)panningEnded {
    
    _isLeftControllerVisible = NO;
    if (_centerView.frame.origin.x > leftControllerWidth/2) {
        _isLeftControllerVisible = YES;
    }
    [self animateCenterView];
}

#pragma mark - mask view
- (void)addCenterMaskView {
    
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, _centerController.view.frame.size.width, _centerController.view.frame.size.height)];
    _maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _maskView.backgroundColor = [UIColor clearColor];
    [_centerController.view addSubview:_maskView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetViewFrames)];
    [_maskView addGestureRecognizer:tapGesture];
}

#pragma mark - change subview frames
- (void)resetViewFrames {
    
    _isLeftControllerVisible = NO;
    [self animateCenterView];
}

- (void)animateCenterView {
    
    if (_maskView) {
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
    CGFloat positionX = self.view.frame.size.width - centerControllerWidth - shadowOffset;
    if (_isLeftControllerVisible) {
        positionX = self.view.frame.size.width - centerControllerWidth - shadowOffset + leftControllerWidth;
    }
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         if (_centerController) {
                             [_centerView setFrame:CGRectMake(positionX, _topOffset - shadowOffset, centerControllerWidth + 2*shadowOffset, self.view.frame.size.height + 2*shadowOffset)];
                             _centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             if (_maskView) {
                                 [_maskView removeFromSuperview];
                                 _maskView = nil;
                             }
                             if (_isLeftControllerVisible) {
                                 [self addCenterMaskView];
                             }
                             [_centerView setFrame:CGRectMake(positionX, _topOffset - shadowOffset, centerControllerWidth + 2*shadowOffset, self.view.frame.size.height + 2*shadowOffset)];
                             _centerView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
                         }
                     }];
}

@end
