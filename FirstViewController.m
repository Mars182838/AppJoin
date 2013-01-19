//
//  FirstViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "FirstViewController.h"
#import "MessageViewController.h"
#import "DateViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            self.title = @"看展会";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///通过封装导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _topBar.navLabel.text = @"看展会";
    [self.view addSubview:_topBar.navImage];
    [self.view addSubview:_topBar.navLabel];
    
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT)];
    if (iPhone5) {
        
        self.backImage.image = [UIImage imageNamed:@"background-568h@2x.png"];
        [self.view addSubview:self.backImage];
        
        for (int count = 0; count < 3; count ++) {
            for (int j = 0; j < 2; j++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(20 + 150*j, 80 + 140*count, 130, 100);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn%d-568h@2x.png",2*count+j+1]]forState:UIControlStateNormal];
                button.tag = 2*count+j+1;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
        }

    }
    else
    {
        self.backImage.image = [UIImage imageNamed:@"background.png"];
        [self.view addSubview:self.backImage];
        
        for (int count = 0; count < 3; count ++) {
            for (int j = 0; j < 2; j++) {
                
               UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(20 + 150*j, 65 + 120*count, 130, 80);
                 [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn%d.png",2*count+j+1]] forState:UIControlStateNormal];
                button.tag = 2*count+j+1;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)dealloc {
    [_backImage release];
    [_topBar release];
    [super dealloc];
}

- (void)buttonPress:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *message = nil;
    NSString *title = nil;
    _messageController = [[MessageViewController alloc] init];
    self.delegate = (id)_messageController;
    switch (button.tag) {
        case 1:
        {
            message = [NSString stringWithFormat:@"%@",@"我们都是好孩子"];
            title = @"会议概况";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];            break;
        }
        case 2:
        {
            message = @"移动触屏的产生，同时也带来了各种手势的配搭。这些手势的应用，相比于键盘、鼠标，能更加快速做出响应，并且降低学习成本，更加直观地进行人机交流。但触摸相比鼠标，却无法达到高度的精准，也无法出现像网页中的鼠标hover、悬停等的效果。东西方人的指尖触碰面积略有不同，但通常，它们合适的点击区域是在44-44px的范围里屏幕的限制:但通常，它们合适的点击区域是在44-44px的范围里屏幕的限制：我们说移动平台的设计，其实就像是带着枷锁跳舞，这个枷锁不仅是来自各个平台系统的控件规范，还有最大的问题就是屏幕空间的有限，加之前面说过的44-44px的点击区域，更是需要我们的APP设计，在单个界面的展示，简洁再扼要，交互轻量再轻量，层级浅显再浅显。如何在有限的屏幕中展现更多的信息。有三个要素：a.巧妙地利用工具栏与toolbar的隐藏与浮出，最大程度地展示主题，同时快速的做出交互动b.合理放置控件布局：尽量把最重要的交互按钮和信息，放置在第一屏中，这点相信在PC端网页设计中也同样适用。c.有针对性的移植：现在有越来越多的客户端应用，都来自于成熟的网站产品的转移，但网页所能承载的信息与交互，远远大于客户端。于是我们应该高度解理产品的核心功能与精神理念，提取最重要的信息模块，进行客户端的转化移植。";
            
            title = @"组织单位";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];

            break;
        }
        case 3:
        {
            DateViewController *dateController = [[DateViewController alloc] init];
            [self.navigationController pushViewController:dateController animated:YES];
            [dateController release];
            
            break;
        }
        case 4:
        {
            message = @"好孩子";
            title = @"合作媒体";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];
            break;
        }
        case 5:
        {
            message = @"好孩子";
            title = @"新闻发布会";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];
            break;
        }
        case 6:
        {
            message = @"好孩子";
            title = @"会议论坛";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];
            break;
        }
    }
     
}

@end
