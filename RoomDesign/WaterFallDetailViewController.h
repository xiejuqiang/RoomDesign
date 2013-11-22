//
//  WaterFallDetailViewController.h
//  RoomDesign
//
//  Created by apple on 13-11-14.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallDetailViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)NSArray *urlArray;
@property (nonatomic,assign) int offset_H;

@end
