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
#import "CollectViewController.h"
#import "RecordDao.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CollectDBItem.h"


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
@synthesize isForeign;
@synthesize cat_id = _cat_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        urlStr = [[UrlStr alloc] init];
        jsonParser = [[JsonParser alloc] init];
        
        //数据库
        recordDB = [[RecordDao alloc]init];
        [recordDB createDB:DATABASE_NAME];
    }
    return self;
}

- (void)getData
{
    GetObj *getObj = [[GetObj alloc] init];
    getObj.catID = [NSString stringWithFormat:@"%d",_cat_id];
    getObj.page = @"1";
    NSString *productListURL = [urlStr returnURL:2 Obj: getObj];
    [jsonParser parse:productListURL withDelegate:self onComplete:@selector(onConnectionSuccess:) onErrorComplete:@selector(onConnectionError) onNullComplete:@selector(onConnectionNull)];
}

- (void)onConnectionSuccess:(JsonParser *)jsonP
{
    NSDictionary *resultDicData = [jsonP getItems];
    productsData = [[NSArray alloc] initWithArray:[resultDicData objectForKey:@"productLists"]];
    [self createView:offset_H];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self getData];
    [self createTopView];

    
    
}

- (void)createTopView
{

    
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(445, 30, 50, 30)];
    titleLabel1.text = @"设计";
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png.png"]];
    imgView.frame = CGRectMake(titleLabel1.right-10, 20, 40, 40);
    
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(425+30+65, 30, 50, 30)];
    titleLabel2.text = @"帮手";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.textColor = [UIColor blackColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 90, 1024-120, 2)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel];
    
//    UILabel *cookLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, lineLabel.top-30, 90, 30)];
//    cookLabel.text = @"现代风格";
//    cookLabel.textAlignment = NSTextAlignmentCenter;
//    cookLabel.textColor = [UIColor blackColor];
//    
//    UILabel *houseLabel = [[UILabel alloc] initWithFrame:CGRectMake(425+60, lineLabel.top-30, 90, 30)];
//    houseLabel.text = @"欧式风格";
//    houseLabel.textAlignment = NSTextAlignmentCenter;
//    houseLabel.textColor = [UIColor blackColor];
//    
//    UILabel *officeLabel = [[UILabel alloc] initWithFrame:CGRectMake(904-90, lineLabel.top-30, 90, 30)];
//    officeLabel.text = @"田园风格";
//    officeLabel.textAlignment = NSTextAlignmentCenter;
//    officeLabel.textColor = [UIColor blackColor];
    
    if (isForeign) {
        titleLabel1.text = @"Design";
        titleLabel2.text = @"Assistant";
//        cookLabel.text = @"Smartness";
//        houseLabel.text = @"European";
//        officeLabel.text = @"Rural";
        
        titleLabel1.frame = CGRectMake(445, 30, 60, 30);
        imgView.frame = CGRectMake(titleLabel1.right-10, 10, 50, 50);
        titleLabel2.frame = CGRectMake(titleLabel1.right-10+40, 30, 70, 30);
    }
    
    [self.view addSubview:titleLabel1];
    [self.view addSubview:titleLabel2];
//    [self.view addSubview:cookLabel];
//    [self.view addSubview:houseLabel];
//    [self.view addSubview:officeLabel];
    [self.view addSubview:imgView];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UIButton *collectButton = [[UIButton alloc] initWithFrame:CGRectMake(1024-70, 30, 60, 30)];
    [collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectButton];
    
    if (isForeign) {
        [backButton setTitle:@"back" forState:UIControlStateNormal];
        [collectButton setTitle:@"collect" forState:UIControlStateNormal];
    }
}

- (void)createView:(int)nId
{
    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(60, 120, 720, 600)];
    leftScrollView.tag = 100;
    leftScrollView.delegate = self;
    leftScrollView.pagingEnabled = YES;
    [self.view addSubview:leftScrollView];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(790, 120, 768-585, 600)];
    rightScrollView.tag = 200;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    
    bgTileView = [[UIView alloc] initWithFrame:CGRectMake(0, 166.5*offset_H, 183, 180)];
    bgTileView.backgroundColor = [UIColor grayColor];
    [rightScrollView addSubview:bgTileView];
    
    int offsetH = 0;
    int left_offsetH = 0;
    for (int i = 0; i<[productsData count]; i++)
    {
        //        NSString *imagePath = [[NSString alloc] initWithFormat:@"%@",[urlArray objectAtIndex:i]];
        //        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //        NSString *imagePath1 = [[[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy] stringByAppendingPathComponent:[NSString stringWithFormat:@"EGOImageLoader-%u", [[imagePath description] hash]]];
        //        NSLog(@"%u",[[imagePath description] hash]);
        EGOImageView *imageView = [[EGOImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(5+10, 13.5+(162+4.5)*i, 161-8, 161-8);
        imageView.imageURL = [[NSURL alloc] initWithString:[[productsData objectAtIndex:i] objectForKey:@"image1"]];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.backgroundColor = [UIColor whiteColor];
        [rightScrollView addSubview:imageView];
        offsetH = imageView.frame.origin.y;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg:)];
        [imageView addGestureRecognizer:tap];
        tap.view.tag = 100+i;
        
    }
    
    NSArray *imagesArray = [[productsData objectAtIndex:offset_H] objectForKey:@"image_array"];
    NSMutableArray *imgArr = [[NSMutableArray alloc] init];
    for (NSString *str in imagesArray) {
        if ([str isEqualToString:@""] == NO) {
            [imgArr addObject:str];
        }
    }
    
    for (int j = 0; j <[imgArr count]; j++) {
        imageViewBig = [[EGOImageView alloc] init];
        imageViewBig.userInteractionEnabled = YES;
        imageViewBig.clipsToBounds = YES;
        imageViewBig.contentMode = UIViewContentModeScaleAspectFill;
        imageViewBig.frame = CGRectMake(0, 600*j, 720, 600);
        imageViewBig.imageURL = [[NSURL alloc] initWithString:[imgArr objectAtIndex:j]];
        
        
        imageViewBig.contentMode = UIViewContentModeScaleToFill;
        [leftScrollView addSubview:imageViewBig];
        left_offsetH = imageViewBig.frame.origin.y;
    }
    
    rightScrollView.contentSize = CGSizeMake(183, offsetH+161);
    if ([productsData count]<4) {
        rightScrollView.contentOffset = CGPointMake(0, 0);
    }
    else
    {
        rightScrollView.contentOffset = CGPointMake(0, 162*offset_H);
    }
    
    leftScrollView.contentSize = CGSizeMake(720, left_offsetH+600);
    leftScrollView.contentOffset = CGPointMake(0, 0);
    
}

//点击图片移动背景
- (void)tapBg:(UITapGestureRecognizer *)recongnizer
{
    int tag = recongnizer.view.tag-100;
    int left_offsetH = 0;
    [leftScrollView removeAllSubviews];
    bgTileView.frame = CGRectMake(0, 166.5*tag, 183, 180);
    NSArray *imagesArray = [[productsData objectAtIndex:tag] objectForKey:@"image_array"];
    for (int i = 0; i<[imagesArray count]; i++) {
        imageViewBig = [[EGOImageView alloc] init];
        imageViewBig.userInteractionEnabled = YES;
        imageViewBig.clipsToBounds = YES;
        imageViewBig.contentMode = UIViewContentModeScaleAspectFill;
        imageViewBig.frame = CGRectMake(0, 600*i, 720, 600);
        if ([[imagesArray objectAtIndex:i] isEqualToString:@""]==NO) {
            imageViewBig.imageURL = [[NSURL alloc] initWithString:[imagesArray objectAtIndex:i]];
        }
        
        imageViewBig.contentMode = UIViewContentModeScaleToFill;
        [leftScrollView addSubview:imageViewBig];
        left_offsetH = imageViewBig.frame.origin.y;
    }
    leftScrollView.contentSize = CGSizeMake(720, left_offsetH+600);
}

//收藏点击事件
- (void)collectItem:(UIButton *)btn
{
    
   

    
    NSArray *collectClosArray = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",offset_H], [urlArray objectAtIndex:offset_H],nil];
    [recordDB insertAtTable:COLLECT_TABLENAME Clos:collectClosArray];
    NSArray *resultItem = [recordDB resultSet:COLLECT_TABLENAME Order:nil LimitCount:0];
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    collectVC.imageArr = resultItem;
    [self.navigationController pushViewController:collectVC animated:YES];
    CollectDBItem *item = [resultItem objectAtIndex:0];
    NSString *imagePath =item.thumb;
    NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath1 = [[[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy] stringByAppendingPathComponent:[NSString stringWithFormat:@"EGOImageLoader-%u", [[imagePath description] hash]]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:[imgView.image CGImage] orientation:(ALAssetOrientation)[imgView.image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
        if (error) {
            // TODO: error handling
        } else {
            // TODO: success handling
            NSLog(@"SUCCESS");
        }
    }];
    
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
//        int offsetY = scrollView.contentOffset.y/600;
//        bgTileView.frame = CGRectMake(0, 166.5*offsetY, 183, 180);
//        rightScrollView.contentOffset = CGPointMake(0, 162*offsetY);
        
    }
    else if (scrollView.tag == 200)
    {
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
