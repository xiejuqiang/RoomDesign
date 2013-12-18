//
//  UrlStr.m
//  RoomDesign
//
//  Created by apple on 13-12-18.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "UrlStr.h"

@implementation UrlStr

- (NSString *)returnURL:(int)urlId Obj:(GetObj *)obj
{
    NSString *returnStr = nil;
    
    switch (urlId) {
        case 1:
            returnStr = [[NSString alloc]initWithFormat:@""];
            NSLog(@"获取Layout:%@",returnStr);
            return returnStr;
            break;
    }
    return nil;
}

@end
