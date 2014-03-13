//
//  HomePageViewController.h
//  RoomDesign
//
//  Created by apple on 13-12-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PSCollectionView.h"
@class JsonParser;
@class UrlStr;
@class RecordDao;
@class PSCollectionView;
@interface HomePageViewController : UIViewController<MBProgressHUDDelegate,UIScrollViewDelegate,PSCollectionViewDelegate,PSCollectionViewDataSource>
{
    JsonParser *jsonParser;
    UrlStr *urlStr;
    MBProgressHUD *HUD;
    RecordDao *recordDB;
    NSArray *resultDataArray;
    PSCollectionView *collectionView;
}

@end
