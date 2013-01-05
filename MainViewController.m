//
//  MainViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
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
        
    }
    return self;
}

-(void)dealloc
{
    self.carousel = nil;
    [_carousel release];
    [_label release];
    [super dealloc];
}

#pragma mark -
#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主页";
    wrap = YES;
    
    _carousel = [[iCarousel alloc] init];
    _carousel.frame = CGRectMake(0, -60, self.view.frame.size.width, self.view.frame.size.height);
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeCoverFlow;
    
    [self.view addSubview:_carousel];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, 0, 320, 60);
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"CHIC展会历程";
    _label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_label];
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
    UIView *view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"huan%d.jpg",index+1]]] autorelease];
    
    view.frame = CGRectMake(20, 20, 260, 240);
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, 220, 320, 100);
    _label.textAlignment = NSTextAlignmentLeft;
    _label.font = [UIFont systemFontOfSize:20];
    
    switch (index) {
        case 0:
        {
            _label.text = @"2008年展会";
            break;
        }
        case 1:
        {
            _label.text = @"2009年";
            break;
        }
        case 2:
        {
            _label.text = @"2010年";
            break;
        }
        case 3:
        {
            _label.text = @"2011年";
            break;
        }
        case 4:
        {
            _label.text = @"2012年";
            break;
        }
        case 5:
        {
            _label.text = @"2013年";
            break;
        }
    }
    
    [view addSubview:_label];
    
    return view;
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

/** 是否支持循环查看图片 */
-(BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return wrap;
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
    NSString *str = [NSString stringWithFormat:@"%@",@"石青峰表示，中国海监飞机在东海巡航是由中国海监固定飞机执行的，主要承担中国东海南部、东海东部海域的国家海洋监测和维权巡航监视等任务，兼顾浙江省岛屿保护巡查、赤潮检测。航线覆盖舟山群岛、春晓油气田的南部海域等地，最南到达北纬27°，距钓鱼岛150公里。　中新网北京12月27日电 (董冠洋)针对近日日本战机干扰中国海监飞机在东海春晓油气田没有争议的中国海域巡航一事，中国国家海洋局办公室主任石青峰27日回应称，日方使用军机对中国公务机在没有争议的中国空域正常巡航进行干扰，是有意识升级事态的无理行为，后果由日方承担。"];
    self.delegate = (id)_detailController;
    switch (index) {
        case 0:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan1.jpg"] andString:str];
            break;
        }
        case 1:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan2.jpg"] andString:str];
            break;
        }
        case 2:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan3.jpg"] andString:str];
            break;
        }
        case 3:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan4.jpg"] andString:str];
            break;
        }
        case 4:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan5.jpg"] andString:str];
            break;
        }
        case 5:{
            
            [delegate transferImage:[UIImage imageNamed:@"huan4.jpg"] andString:str];
            break;
        }
    }
    [self.navigationController pushViewController:_detailController animated:YES];
}

@end