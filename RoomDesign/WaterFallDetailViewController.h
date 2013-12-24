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
@interface WaterFallDetailViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate>
{
    UrlStr *urlStr;
    JsonParser *jsonParser;
}

@property (nonatomic,retain)NSArray *urlArray;
@property (nonatomic,assign) int offset_H;

@end
