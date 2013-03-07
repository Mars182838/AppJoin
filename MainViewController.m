//
//  MainViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "TopBarView.h"
#import "DownLoadString.h"
#import "Harpy.h"

#define ITEM_SPACING 200

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize carousel = _carousel;
@synthesize detailController = _detailController;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _mainDic = [[NSDictionary alloc] init];
       
        _selectImageArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(void)dealloc
{
    //注销网络连接状态的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    
    self.carousel = nil;
    [_carousel release];
    [_topBar   release];
    [_label    release];
    [_downLoad release];
    [_mainDic  release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///通过封装导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _topBar.navLabel.text = @"主页";
    [self.view addSubview:_topBar.navImage];
    [self.view addSubview:_topBar.navLabel];
    
    _carousel = [[iCarousel alloc] init];
    _carousel.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeCoverFlow;
    [self.view addSubview:_carousel];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, 44, 320, 50);
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"西西木特许加盟展会";
    _label.font = [UIFont systemFontOfSize:22];
    [self.view addSubview:_label];
    
    _detailLabel = [[UILabel alloc] init];
    if (iPhone5) {
        _detailLabel.frame = CGRectMake(0, HEIGHT - 130, 320, 60);
    }
    else{
        _detailLabel.frame = CGRectMake(0, HEIGHT - 100, 320, 40);

    }

    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.font = [UIFont systemFontOfSize:18];
    _detailLabel.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:_detailLabel];
    
    ///注册一个通知，为了检测单前用户的网络连接状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [[Reachability reachabilityWithHostname:@"http://baidu.com"] retain];
    ///开始通知
    [hostReach startNotifier];
    
    _downLoad = [[DownLoadString alloc] initWithShareTarget:NSStringWithUrlMain];
    _downLoad.delegate = self;
    
    Harpy *hap = [[Harpy alloc] init];
//    [hap release];
    
}

#pragma mark - 
#pragma mark - ReachabilityNotification Methods

-(void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus curStatus = [curReach currentReachabilityStatus];
    NSString *strMessage;
    if (curStatus == NotReachable) {
        strMessage = @"没有检测可用网络,请检查下网络";
        
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.delegate = self;
        hud.labelText = strMessage;
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:2.0f];
    }
}

#pragma mark - 
#pragma mark - MBProgressHUD delegate Methods

- (void)hudWasHidden:(MBProgressHUD *)HUD {
	// Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
	hud = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - iCarousel.h delegate and dateSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 6;
}

/** 创建图片的显示视图，图片以Cover flow形式呈现，并且显示图片的文字描述
 * @prama  carousel是指的iCarousel的代理方法
 * @prama  index 是指的通过索引区别
 * @return UIView 这表明该函数返回的是一个View
 */

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index 
{
    UIView *view = _imageView;
    
    if (self.selectImageArray.count > 0) {
        NSURL *url = [NSURL URLWithString:[[self.selectImageArray objectAtIndex:index] objectForKey:@"src"]];
        
        [_imageView setImageWithURL:url refreshCache:YES placeholderImage:[UIImage imageNamed:@"place.png"]];
    }
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"place.png"]];
    
    if (iPhone5) {
        view.frame = CGRectMake(20, 40, 260, HEIGHT - 180);
    }
    else{
        view.frame = CGRectMake(20, 20, 260, HEIGHT - 150);
        
    }
    return view;
}

/////根据滑动到哪个图片，下面会有文字变化
-(void)carouselDidScroll:(iCarousel *)carousel
{
    if (self.selectImageArray.count >0) {
        _detailLabel.text = [[[[self.selectImageArray objectAtIndex:carousel.currentItemIndex] objectForKey:@"text"] componentsSeparatedByString:@","] objectAtIndex:0];
        
    }
    else{
        _detailLabel.text = @"";
    }
    
}

- (CATransform3D)carousel:(iCarousel *)carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    //implement 'flip3D' style carousel
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);

    return CATransform3DTranslate(transform, 100.0, 200.0, offset *_carousel.itemWidth);
}

-(NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 6;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return ITEM_SPACING;
}

/** 该方法是点击之后会进入DetailViewController界面，显示点击的图片，并且附带图片的介绍
 *case0： case1：case2：case3：case4：case5：分别进入第一、二、三、四、五、六张图及其介绍
 *
 * @prama carousel 表示是iCarousel的代理方法
 * @prama index 表示根据点击的index可以相应的内容
 */
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    _detailController = [[DetailViewController alloc] init];
    
    self.delegate = (id)_detailController;
    
    [delegate transferImageUrl:[[self.selectImageArray objectAtIndex:index] objectForKey:@"src"] andString:[[self.selectImageArray objectAtIndex:index] objectForKey:@"text"]];
    [self.navigationController pushViewController:_detailController animated:YES];
}

#pragma mark - DownLoadDelegate 

-(void)downLoadFinished:(NSDictionary *)info
{
    _mainDic = info;
    self.selectImageArray = [[[_mainDic objectForKey:@"posts"] objectAtIndex:0] objectForKey:@"content"];
    [self.carousel reloadData];
}

@end