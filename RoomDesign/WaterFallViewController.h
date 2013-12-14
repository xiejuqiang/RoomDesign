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
    
    UIScrollView *mScrollView;
}

@property (nonatomic,assign) BOOL isForeign;

@end
