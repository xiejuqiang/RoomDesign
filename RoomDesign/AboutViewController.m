//
//  AboutViewController.m
//  RoomDesign
//
//  Created by apple on 13-12-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more.jpg"]];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 33, 50, 50)];
    [backButton setTitle:@"" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
