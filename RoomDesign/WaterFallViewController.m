//
//  WaterFallViewController.m
//  waterfallDemo
//
//  Created by apple on 13-9-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "WaterFallViewController.h"
#import "TMQuiltView.h"
#import "EGOImageView.h"

#import "TMPhotoQuiltViewCell.h"

#import "SVPullToRefresh.h"
#import "WaterFallDetailViewController.h"
#import "UIImage+thumUIImage.h"
#import "UIView+UIViewEx.h"

@interface WaterFallViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate>
{
	TMQuiltView *qtmquitView;
    NSArray *imageArr;
}
@property (nonatomic, retain) NSMutableArray *images;
@end

@implementation WaterFallViewController
@synthesize images = _images;
@synthesize isForeign;
@synthesize dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        thirdTime = 2;
        imageArr = [[NSArray alloc] initWithObjects:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=c839e1304936acaf59e091fc48e18c10/9825bc315c6034a85d091a88c9134954082376cb.jpg",
                                                    @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=5ac7acca3887e9504217f46c24005243/37d12f2eb9389b50a305435b8735e5dde6116ec5.jpg",
                                                    @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=7d423bfa7b310a55c424d9f4837d42a9/a8014c086e061d95800f963179f40ad162d9ca6a.jpg",
                                                    @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=8214425457fbb2fb342b5f127b7221a4/37d3d539b6003af3e17d9669372ac65c1138b6f0.jpg",
                                                    @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=599484b51c178a82ce3c78a0c23b728d/63d9f2d3572c11df725ec15a612762d0f703c238.jpg",
                                                    @"http://h.hiphotos.baidu.com/image/w%3D2048/sign=64e12999f503918fd7d13aca65052797/242dd42a2834349b04fd10fccbea15ce37d3becb.jpg",
                                                    @"http://f.hiphotos.baidu.com/image/w%3D2048/sign=7ae833780855b3199cf9857577918326/4d086e061d950a7bd72331bd08d162d9f2d3c9b1.jpg",
                    @"http://g.hiphotos.baidu.com/image/w%3D2048/sign=b1cd9fb1a2ec08fa260014a76dd63c6d/2934349b033b5bb58f241bf034d3d539b700bcc8.jpg",
                    @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=436dd70dca95d143da76e32347c88302/dbb44aed2e738bd4b2d6893fa38b87d6267ff9cc.jpg",
                    @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=5148d1a32934349b74066985fdd214ce/2fdda3cc7cd98d10758c3c88203fb80e7bec902a.jpg",
                    @"http://c.hiphotos.baidu.com/image/w%3D2048/sign=11b2f576f01fbe091c5ec4145f580d33/64380cd7912397ddcb3d52045b82b2b7d0a2876e.jpg",
                    @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=9f704512d60735fa91f049b9aa690eb3/f703738da977391287736268fa198618367ae266.jpg",
                    @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=65cc1e8e0d2442a7ae0efaa5e57bac4b/f9198618367adab4b1703f4e89d4b31c8701e41f.jpg",
                    @"http://b.hiphotos.baidu.com/image/w%3D2048/sign=08f233a1f403738dde4a0b228723b151/a8ec8a13632762d046f0e8bea2ec08fa503dc6e1.jpg",
                    @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=8736bc2f9113b07ebdbd570838ef9023/e61190ef76c6a7efb2df9328fffaaf51f2de66c6.jpg",nil];
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createTopView];
    [self createScrollView];
    TMQuiltView *qtmView = (TMQuiltView *)[mainScrollView viewWithTag:100];
    [self createHeaderView:qtmView];
    [self getNextPageView:qtmView];
    
    
}

- (void)createScrollView
{
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 1024, 668)];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.tag = 1000;
    mainScrollView.contentSize = CGSizeMake(1024*3, 668);
    [self.view addSubview:mainScrollView];
    for (int i = 0; i<3; i++) {
      TMQuiltView  *qtmView = [[TMQuiltView alloc] initWithFrame:CGRectMake(60+1024*i, 0, 1024-120, 768-100)];
        qtmView.delegate = self;
        qtmView.dataSource = self;
        qtmView.tag = i+100;
        
        //	qtmquitView.backgroundColor = [UIColor grayColor];
        [mainScrollView addSubview:qtmView];
        
        if (i == 0) {
            tempTag = qtmView.tag;
        }
        
        
        
        
        //    [qtmquitView addInfiniteScrollingWithActionHandler:^{
        //        [self insertRowAtBottom];
        //    }];
        
        
    }
}

- (void)createTopView
{
//    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 1024, 500)];
    
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(445, 30, 50, 30)];
    titleLabel1.text = @"设计";
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_stone@2x.png"]];
    imgView.frame = CGRectMake(titleLabel1.right-10, 10, 50, 50);
    
    
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(425+30+65, 30, 50, 30)];
    titleLabel2.text = @"帮手";
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    titleLabel2.textColor = [UIColor blackColor];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 90, 1024-120, 2)];
    lineLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineLabel];
    
    //解析数据
    NSDictionary *dic = [dataArray objectAtIndex:0];
    
    cookLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, lineLabel.top-30, 50, 30)];
    cookLabel.text = [dic objectForKey:@"cname"];
    cookLabel.textAlignment = NSTextAlignmentCenter;
    cookLabel.textColor = [UIColor blackColor];
    
    houseLabel = [[UILabel alloc] initWithFrame:CGRectMake(425+60, lineLabel.top-30, 50, 30)];
    houseLabel.text = [[dataArray objectAtIndex:1] objectForKey:@"cname"];
    houseLabel.textAlignment = NSTextAlignmentCenter;
    houseLabel.textColor = [UIColor blackColor];
    
    officeLabel = [[UILabel alloc] initWithFrame:CGRectMake(904-40, lineLabel.top-30, 70, 30)];
    officeLabel.right = 1024-90;
    officeLabel.text =[[dataArray objectAtIndex:2] objectForKey:@"cname"];
    officeLabel.textAlignment = NSTextAlignmentCenter;
    officeLabel.textColor = [UIColor blackColor];
    if (isForeign == YES) {
        titleLabel1.text = @"Design";
        titleLabel2.text = @"assistant";
        cookLabel.text = @"food and beverage";
        houseLabel.text = @"household";
        officeLabel.text = @"office";
        
        
        titleLabel1.frame = CGRectMake(445, 30, 60, 30);
        imgView.frame = CGRectMake(titleLabel1.right-10, 10, 50, 50);
        titleLabel2.frame = CGRectMake(titleLabel1.right-10+40, 30, 70, 30);
        cookLabel.frame = CGRectMake(90, lineLabel.top-30, 150, 30);
        houseLabel.frame = CGRectMake(425+60, lineLabel.top-30, 80, 30);
        
    }
    
    [self.view addSubview:titleLabel1];
    [self.view addSubview:titleLabel2];
    [self.view addSubview:cookLabel];
    [self.view addSubview:houseLabel];
    [self.view addSubview:officeLabel];
    [self.view addSubview:imgView];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView:(TMQuiltView *)qtmView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - qtmView.bounds.size.height,
                                     qtmView.frame.size.width, qtmView.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[qtmView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)testFinishedLoadData:(TMQuiltView *)qtmView{
	
    [self finishReloadingData:qtmView];
    [self setFooterView:qtmView];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData:(TMQuiltView *)qtmView{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmView];
        [self setFooterView:qtmView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)setFooterView:(TMQuiltView *)qtmView{
	//    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(qtmView.contentSize.height, qtmView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              qtmView.frame.size.width,
                                              qtmView.bounds.size.height);
    }else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         qtmView.frame.size.width, qtmView.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [qtmView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos qtmViewScrollView:(UIScrollView *)scrollView{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    int flag = scrollView.tag;
    TMQuiltView *qtmView = (TMQuiltView *)[mainScrollView viewWithTag:flag];
    if (aRefreshPos == EGORefreshHeader)
	{
        // pull down to refresh data
        
        [self performSelector:@selector(refreshView:) withObject:qtmView afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        // pull up to load more data
        [self performSelector:@selector(getNextPageView:) withObject:qtmView afterDelay:2.0];
    }
	
	// overide, the actual loading data operation is done in the subclass
}

//刷新调用的方法
-(void)refreshView:(TMQuiltView *)qtmView
{
	NSLog(@"刷新完成");
    [self testFinishedLoadData:qtmView];
	
}

#pragma mark -
#pragma mark EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos targetscrollView:(UIScrollView *)scrollView
{
	if (scrollView.tag == 1000) {
        
    }
    else
    {
        [self beginToReloadData:aRefreshPos qtmViewScrollView:scrollView];
    }
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)reloadImageData:(TMQuiltView *)qtView
{
    [qtView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData:qtView];
}

- (void)insertRowAtBottom:(TMQuiltView *)qtView
{
    [self getNextPageView:qtView];
    [self performSelector:@selector(reloadImageData:) withObject:qtmquitView afterDelay:2.5];
    
}

//加载调用的方法
-(void)getNextPageView:(TMQuiltView *)qtView
{
//	for(int i = 0; i < 10; i++) {
//		[_images addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
//	}
//    [qtmquitView.infiniteScrollingView stopAnimating];
    if (qtView.tag != tempTag) {
        [_images removeAllObjects];
        tempTag = qtView.tag;
    }
    [_images addObjectsFromArray:imageArr];
	[qtView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData:qtView];
   
}

- (NSMutableArray *)images
{
    if (!_images)
	{
        _images = [[NSMutableArray alloc] initWithArray:imageArr];
    }
    return _images;
}

- (UIImageView *)imageAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row>[self.images count]-1) {
        return nil;
    }
    NSString *imagePath = [[NSString alloc] initWithFormat:@"%@",[self.images objectAtIndex:indexPath.row]];
    NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath1 = [[[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy] stringByAppendingPathComponent:[NSString stringWithFormat:@"EGOImageLoader-%u", [[imagePath description] hash]]];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imagePath1]];
    UIImage *img =  [imgView.image thumbWithWidth:imgView.image.size.width height:imgView.image.size.height];
    imgView.frame = CGRectMake(0, 0, img.size.width,img.size.height);
    return imgView;
}

//- (CGSize)imageAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSURL *url = [[NSURL alloc] initWithString:[self.images objectAtIndex:indexPath.row]];
//    
//   return  [self getImageSizeWithURL:url];
//}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.images count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"] autorelease];
    }
    
//    cell.photoView.image = [self imageAtIndexPath:indexPath];
    NSString *strImg = [self.images objectAtIndex:indexPath.row];
    NSURL *url = [[NSURL alloc ] initWithString:strImg];
    cell.photoView.imageURL = url;
    if ([quiltView heightForCellAtIndexPath:indexPath]>50)
    {
        cell.titleLabel.hidden = NO;
        cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    }
    else
    {
        cell.titleLabel.hidden = YES;
    }
    
    return cell;
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
	
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
	{
        return 3;
    } else {
        return 5;
    }
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%f",[self imageAtIndexPath:indexPath].size.height);
    NSLog(@"Page:%d",indexPath.row);
    return [self imageAtIndexPath:indexPath].frame.size.height+40;
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"index:%d",indexPath.row);
    WaterFallDetailViewController *waterFallDetailVC = [[WaterFallDetailViewController alloc] init];
    waterFallDetailVC.offset_H = indexPath.row;
    waterFallDetailVC.urlArray = imageArr;
    
    [self.navigationController pushViewController:waterFallDetailVC animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.tag == 1000)
    {
        
    }
    else
    {

        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }

        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
        }
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag == 1000)
    {
        if (decelerate) {
            
        }
        
        
    }
    else{
        if (_refreshHeaderView)
        {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
        
        if (_refreshFooterView)
        {
            [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000)
    {
        
            int flag = scrollView.contentOffset.x/1024;
            NSLog(@"%d",flag);
        switch (flag) {
            case 0:
            {
                cookLabel.text = [[dataArray objectAtIndex:0] objectForKey:@"cname"];
                houseLabel.text = [[dataArray objectAtIndex:1] objectForKey:@"cname"];
                officeLabel.text = [[dataArray objectAtIndex:2] objectForKey:@"cname"];
            }
                
                break;
                
            case 1:
            {
                cookLabel.text = [[dataArray objectAtIndex:3] objectForKey:@"cname"];
                houseLabel.text = @"";
                officeLabel.text = [[dataArray objectAtIndex:4] objectForKey:@"cname"];
            }
                
                break;
            case 2:
            {
                cookLabel.text = [[dataArray objectAtIndex:5] objectForKey:@"cname"];
                houseLabel.text = @"";
                officeLabel.text = [[dataArray objectAtIndex:6] objectForKey:@"cname"];
            }
                
                break;
            default:
                break;
        }
        if (thirdTime) {
            TMQuiltView *qtmView = (TMQuiltView *)[mainScrollView viewWithTag:100+flag];
            [self createHeaderView:qtmView];
            [self getNextPageView:qtmView];
//            if (thirdTime == flag) {
//                thirdTime = 0;
//            }
        }
            
        
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end

