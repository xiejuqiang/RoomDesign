//
//  HomePageViewController.m
//  RoomDesign
//
//  Created by apple on 13-12-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HomePageViewController.h"
#import "WaterFallViewController.h"
#import "UIView+UIViewEx.h"
#import "AboutViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.jpg"]];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    UIButton *domesticButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 400, 668)];
    domesticButton.backgroundColor = [UIColor clearColor];
    domesticButton.tag = 100;
    [domesticButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:domesticButton];
    
    UIButton *foreignButton = [[UIButton alloc] initWithFrame:CGRectMake(600, 0, 400, 668)];
    foreignButton.backgroundColor = [UIColor clearColor];
    foreignButton.tag = 101;
    [foreignButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:foreignButton];
    
    UIButton *aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    aboutButton.bottom = 768-10;
    aboutButton.backgroundColor = [UIColor clearColor];
    [aboutButton addTarget:self action:@selector(aboutTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutButton];
    
}

- (void)buttonTap:(UIButton *)btn
{
    WaterFallViewController *waterFallVC = [[WaterFallViewController alloc] init];
    if (btn.tag == 100) {
        waterFallVC.isForeign = NO;
    }
    else
    {
        waterFallVC.isForeign = YES;
    }
    [self.navigationController pushViewController:waterFallVC animated:YES];
}

- (void)aboutTap
{
    AboutViewController *aboutVC = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
