//
//  HomePageViewController.h
//  RoomDesign
//
//  Created by apple on 13-12-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class JsonParser;
@class UrlStr;
@class RecordDao;
@interface HomePageViewController : UIViewController<MBProgressHUDDelegate>
{
    JsonParser *jsonParser;
    UrlStr *urlStr;
    MBProgressHUD *HUD;
    RecordDao *recordDB;
    NSArray *resultDataArray;
}

@end
