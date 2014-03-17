//
//  WaterFallDetailViewController.h
//  RoomDesign
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class UrlStr;
@class JsonParser;
@class RecordDao;
@class EGOImageView;
@interface WaterFallDetailViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
{
    UrlStr *urlStr;
    JsonParser *jsonParser;
    NSArray *productsData;
    RecordDao *recordDB;
//    EGOImageView *imageViewBig;//大图
    MBProgressHUD *HUD;
    int pageNum;
}

@property (nonatomic,retain)NSArray *urlArray;
@property (nonatomic,assign) int offset_H;
@property (nonatomic,assign) BOOL isForeign;
@property (nonatomic)int cat_id;
@property (nonatomic) BOOL isCollect;

@end
