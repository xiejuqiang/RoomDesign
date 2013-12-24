//
//  WaterFallDetailViewController.m
//  RoomDesign
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "WaterFallDetailViewController.h"
#import "EGOImageView.h"
#import "UIImage+thumUIImage.h"
#import <CoreText/CoreText.h>
#import "UIView+UIViewEx.h"
#import "UrlStr.h"
#import "JsonParser.h"
#import "GetObj.h"

@interface WaterFallDetailViewController ()
{
    UIView *bgTileView;
    UIScrollView *leftScrollView;
    UIScrollView *rightScrollView;
}

@end

@implementation WaterFallDetailViewController
@synthesize urlArray;
@synthesize offset_H;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        urlStr = [[UrlStr alloc] init];
        jsonParser = [[JsonParser alloc] init];
    }
    return self;
}

- (void)getData
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createTopView];

    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(150, 100, 550, 600)];
    leftScrollView.tag = 100;
    leftScrollView.delegate = self;
    [self.view addSubview:leftScrollView];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(705, 100, 768-605, 600)];
    rightScrollView.tag = 200;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    
    bgTileView = [[UIView alloc] initWithFrame:CGRectMake(0, 162*offset_H, 163, 163)];
    bgTileView.backgroundColor = [UIColor redColor];
    [rightScrollView addSubview:bgTileView];
    
    int offsetH = 0;
    int left_offsetH = 0;
    for (int i = 0; i<[urlArray count]; i++)
    {
        NSString *imagePath = [[NSString alloc] initWithFormat:@"%@",[urlArray objectAtIndex:i]];
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imagePath1 = [[[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy] stringByAppendingPathComponent:[NSString stringWithFormat:@"EGOImageLoader-%u", [[imagePath description] hash]]];
        NSLog(@"%u",[[imagePath description] hash]);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(1, 1+162*i, 161, 161);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        [rightScrollView addSubview:imageView];
        offsetH = imageView.frame.origin.y;
        
        UIImageView *imageViewBig = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
        imageViewBig.userInteractionEnabled = YES;
        imageViewBig.frame = CGRectMake(0, 600*i, 550, 600);
        imageViewBig.contentMode = UIViewContentModeScaleAspectFit;
        [leftScrollView addSubview:imageViewBig];
        left_offsetH = imageViewBig.frame.origin.y;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg:)];
        [imageView addGestureRecognizer:tap];
        tap.view.tag = 100+i;
        
    }
    rightScrollView.contentSize = CGSizeMake(161, offsetH+161);
    rightScrollView.contentOffset = CGPointMake(0, 162*offset_H);
    leftScrollView.contentSize = CGSizeMake(550, left_offsetH+600);
    leftScrollView.contentOffset = CGPointMake(0, 600*offset_H);
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

- (void)createTopView
{

    
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(445, 30, 50, 30)];
    titleLabel1.text = @"设计";
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_stone@2x.png"]];
    imgView.frame = CGRectMake(titleLabel1.right-10, 10, 50, 50);
    
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(425+30+65, 30, 50, 30)];
    titleLabel2.text = @"帮手";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.textColor = [UIColor blackColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 90, 1024-120, 2)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel];
    
    UILabel *cookLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, lineLabel.top-30, 90, 30)];
    cookLabel.text = @"现代风格";
    cookLabel.textAlignment = NSTextAlignmentCenter;
    cookLabel.textColor = [UIColor blackColor];
    
    UILabel *houseLabel = [[UILabel alloc] initWithFrame:CGRectMake(425+60, lineLabel.top-30, 90, 30)];
    houseLabel.text = @"欧式风格";
    houseLabel.textAlignment = NSTextAlignmentCenter;
    houseLabel.textColor = [UIColor blackColor];
    
    UILabel *officeLabel = [[UILabel alloc] initWithFrame:CGRectMake(904-90, lineLabel.top-30, 90, 30)];
    officeLabel.text = @"田园风格";
    officeLabel.textAlignment = NSTextAlignmentCenter;
    officeLabel.textColor = [UIColor blackColor];
    
    [self.view addSubview:titleLabel1];
    [self.view addSubview:titleLabel2];
    [self.view addSubview:cookLabel];
    [self.view addSubview:houseLabel];
    [self.view addSubview:officeLabel];
    [self.view addSubview:imgView];
    
}


//点击图片移动背景
- (void)tapBg:(UITapGestureRecognizer *)recongnizer
{
    int tag = recongnizer.view.tag-100;
    bgTileView.frame = CGRectMake(0, 162*tag, 163, 163);
    leftScrollView.contentOffset = CGPointMake(0, 600*tag);
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

#pragma mark -
#pragma UIScrollView Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 100)
    {
        int offsetY = scrollView.contentOffset.y/600;
        bgTileView.frame = CGRectMake(0, 162*offsetY, 163, 163);
        
    }
    else if (scrollView.tag == 200)
    {
        
    }
}

@end
