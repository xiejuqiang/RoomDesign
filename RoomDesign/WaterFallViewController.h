//
//  WaterFallViewController.h
//  waterfallDemo
//
//  Created by apple on 13-9-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface WaterFallViewController : UIViewController<EGORefreshTableDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
    
    UIScrollView *mainScrollView;
    UIScrollView *titleScrollView;
    UIButton *cookLabel;
    UILabel *flagLine;
    int tempTag;
    int thirdTime;//三次的加载机会
}

@property (nonatomic,assign) BOOL isForeign;
@property (nonatomic,retain) NSArray *dataArray;

@end
