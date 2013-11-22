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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableAttributedString *)getAttributedString
{
    NSMutableAttributedString *attriString = [[[NSMutableAttributedString alloc] initWithString:@"this is test!"] autorelease];
    
    //把this的字体颜色变为红色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)[UIColor redColor].CGColor
                        range:NSMakeRange(0, 4)];
    //把is变为黄色
    [attriString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)[UIColor yellowColor].CGColor
                        range:NSMakeRange(5, 2)];
    //改变this的字体，value必须是一个CTFontRef
    [attriString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:14].fontName,
                                                       14,
                                                       NULL)
                        range:NSMakeRange(0, 4)];
    //给this加上下划线，value可以在指定的枚举中选择
    [attriString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:kCTUnderlineStyleDouble]
                        range:NSMakeRange(0, 4)];

    return attriString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    UITextView *textView= [[UITextView alloc] initWithFrame:CGRectMake(300, 10, 300, 200)];
    textView.allowsEditingTextAttributes = YES;
    
//    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Visual Guide for NSAttributedString" attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Noteworthy-Bold" size:16], NSUnderlineStyleAttributeName : @1 , NSStrokeColorAttributeName : [UIColor blackColor]}];
    
    textView.attributedText = [self getAttributedString];
    
    [self.view addSubview:textView];
   
    
    leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(150, 50, 550, 600)];
    leftScrollView.tag = 100;
    leftScrollView.delegate = self;
    [self.view addSubview:leftScrollView];
    
    rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(705, 50, 768-605, 600)];
    rightScrollView.tag = 200;
    rightScrollView.delegate = self;
    [self.view addSubview:rightScrollView];
    
    bgTileView = [[UIView alloc] initWithFrame:CGRectMake(0, 162*offset_H, 163, 163)];
    bgTileView.backgroundColor = [UIColor redColor];
    [rightScrollView addSubview:bgTileView];
    
    int offsetH = 0;
    int left_offsetH = 0;
    for (int i = 0; i<[urlArray count]; i++)
    {
        NSString *imagePath = [[NSString alloc] initWithFormat:@"%@",[urlArray objectAtIndex:i]];
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imagePath1 = [[[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy] stringByAppendingPathComponent:[NSString stringWithFormat:@"EGOImageLoader-%u", [[imagePath description] hash]]];
        NSLog(@"%u",[[imagePath description] hash]);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(1, 1+162*i, 161, 161);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        [rightScrollView addSubview:imageView];
        offsetH = imageView.frame.origin.y;
        
        UIImageView *imageViewBig = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
        imageViewBig.userInteractionEnabled = YES;
        imageViewBig.frame = CGRectMake(0, 600*i, 550, 600);
        imageViewBig.contentMode = UIViewContentModeScaleAspectFit;
        [leftScrollView addSubview:imageViewBig];
        left_offsetH = imageViewBig.frame.origin.y;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBg:)];
        [imageView addGestureRecognizer:tap];
        tap.view.tag = 100+i;
        
    }
    rightScrollView.contentSize = CGSizeMake(161, offsetH+161);
    rightScrollView.contentOffset = CGPointMake(0, 162*offset_H);
    leftScrollView.contentSize = CGSizeMake(550, left_offsetH+600);
    leftScrollView.contentOffset = CGPointMake(0, 600*offset_H);
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backButton.frame = CGRectMake(5, 5, 100, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
}

//点击图片移动背景
- (void)tapBg:(UITapGestureRecognizer *)recongnizer
{
    int tag = recongnizer.view.tag-100;
    bgTileView.frame = CGRectMake(0, 162*tag, 163, 163);
    leftScrollView.contentOffset = CGPointMake(0, 600*tag);
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
        int offsetY = scrollView.contentOffset.y/600;
        bgTileView.frame = CGRectMake(0, 162*offsetY, 163, 163);
        
    }
    else if (scrollView.tag == 200)
    {
        
    }
}

@end
