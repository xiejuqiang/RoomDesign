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
    NSMutableArray *imgViewTempArray;//保存大图的数组
    NSMutableArray *imgURLArray;//保存大图的URL
}

@property (nonatomic,retain)NSArray *urlArray;
@property (nonatomic,assign) int offset_H;
@property (nonatomic,assign) BOOL isForeign;
@property (nonatomic)int cat_id;
@property (nonatomic) BOOL isCollect;

@end
