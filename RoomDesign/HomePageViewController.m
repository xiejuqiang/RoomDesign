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
#import "UrlStr.h"
#import "JsonParser.h"
#import "CollectViewController.h"
#import "RecordDao.h"
//#import "PSCollectionView.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        HUD = [[MBProgressHUD alloc] init];
        urlStr = [[UrlStr alloc] init];
        jsonParser = [[JsonParser alloc] init];
        resultDataArray = [[NSArray alloc] init];
        //数据库
        recordDB = [[RecordDao alloc]init];
        [recordDB createDB:DATABASE_NAME];
    }
    return self;
}

- (void)getData
{
    [self showWithLoding];
    NSString *categoryUrl = [urlStr returnURL:1 Obj:nil];
    [jsonParser parse:categoryUrl withDelegate:self onComplete:@selector(connectionSuccess:) onErrorComplete:@selector(connectionError) onNullComplete:@selector(connectionNull)];
    
}

- (void)connectionSuccess:(JsonParser *)jsonP
{
    NSArray *resultData = [jsonP getItems];
    resultDataArray = resultData;
    NSLog(@"%@",resultData);
    [HUD hide:YES];
}

- (void)connectionError
{
    [self showWithTime:@"连接出错,请检查网络"];
}

- (void)connectionNull
{
    [self showWithTime:@"无内容"];
}

#pragma mark showHud

- (void)showWithTime:(NSString *)lable
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = lable;
    [HUD showWhileExecutingT:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)showWithLoding
{
    [self.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"加载中...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)myTask {
	// Do something usefull in here instead of sleeping ...
    //	sleep(1);
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
    
    UIButton *collectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    collectButton.bottom = 768-10;
    collectButton.right = 1024-15;
    [collectButton addTarget:self action:@selector(collectTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectButton];
    
    [self getData];
    
//    collectionView = [[PSCollectionView alloc] initWithFrame:CGRectZero];
//    collectionView.delegate = self; // This is for UIScrollViewDelegate
//    collectionView.collectionViewDelegate = self;
//    collectionView.collectionViewDataSource = self;
//    collectionView.backgroundColor = [UIColor clearColor];
//    collectionView.autoresizingMask = ~UIViewAutoresizingNone;
//    collectionView.numColsLandscape = 4;
//    [collectionView reloadData];

}

#pragma mark -
#pragma mark PS Delegate and DataSource

- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index {
    return [PSCollectionViewCell class];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return 1;
}


- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    return 100.0;
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    PSCollectionViewCell *cell = [[PSCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)buttonTap:(UIButton *)btn
{
    WaterFallViewController *waterFallVC = [[WaterFallViewController alloc] init];
    waterFallVC.dataArray = resultDataArray;
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

- (void)collectTap
{
    NSArray *resultItem = [recordDB resultSet:COLLECT_TABLENAME Order:nil LimitCount:0];
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    collectVC.imageArr = resultItem;
    [self.navigationController pushViewController:collectVC animated:YES];
    
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
