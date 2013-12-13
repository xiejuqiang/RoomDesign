//
//  HomePageViewController.m
//  RoomDesign
//
//  Created by apple on 13-12-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HomePageViewController.h"
#import "WaterFallViewController.h"

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
    UIButton *domesticButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 400, 768)];
    domesticButton.backgroundColor = [UIColor clearColor];
    [domesticButton addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:domesticButton];
}

- (void)buttonTap:(UIButton *)btn
{
    WaterFallViewController *waterFallVC = [[WaterFallViewController alloc] init];
    [self.navigationController pushViewController:waterFallVC animated:YES];
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
