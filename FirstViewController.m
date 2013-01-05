//
//  FirstViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "FirstViewController.h"
#import "MessageViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)buttonPress:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSString *message = nil;
    NSString *title = nil;
    _messageController = [[MessageViewController alloc] init];
    self.delegate = (id)_messageController;
    switch (button.tag) {
        case 10:
        {
            message = [NSString stringWithFormat:@"%@",@"我们都是好孩子"];
            title = @"会议概况";
            break;
        }
        case 20:
        {
            message = @"移动触屏的产生，同时也带来了各种手势的配搭。这些手势的应用，相比于键盘、鼠标，能更加快速做出响应，并且降低学习成本，更加直观地进行人机交流。但触摸相比鼠标，却无法达到高度的精准，也无法出现像网页中的鼠标hover、悬停等的效果。东西方人的指尖触碰面积略有不同，但通常，它们合适的点击区域是在44-44px的范围里屏幕的限制:移动触屏的产生，同时也带来了各种手势的配搭。这些手势的应用，相比于键盘、鼠标，能更加快速做出响应，并且降低学习成本，更加直观地进行人机交流。但触摸相比鼠标，却无法达到高度的精准，也无法出现像网页中的鼠标hover、悬停等的效果。东西方人的指尖触碰面积略有不同，但通常，它们合适的点击区域是在44-44px的范围里屏幕的限制：我们说移动平台的设计，其实就像是带着枷锁跳舞，这个枷锁不仅是来自各个平台系统的控件规范，还有最大的问题就是屏幕空间的有限，加之前面说过的44-44px的点击区域，更是需要我们的APP设计，在单个界面的展示，简洁再扼要，交互轻量再轻量，层级浅显再浅显。如何在有限的屏幕中展现更多的信息。有三个要素：a.巧妙地利用工具栏与toolbar的隐藏与浮出，最大程度地展示主题，同时快速的做出交互动b.合理放置控件布局：尽量把最重要的交互按钮和信息，放置在第一屏中，这点相信在PC端网页设计中也同样适用。c.有针对性的移植：现在有越来越多的客户端应用，都来自于成熟的网站产品的转移，但网页所能承载的信息与交互，远远大于客户端。于是我们应该高度解理产品的核心功能与精神理念，提取最重要的信息模块，进行客户端的转化移植。";
            
            title = @"组织单位";

            break;
        }
        case 30:
        {
            message = @"我们都是好孩子";
            title = @"会议日程表";
            break;
        }
        case 40:
        {
            message = @"好孩子";
            title = @"合作媒体";
            break;
        }
        case 50:
        {
            message = @"好孩子";
            title = @"新闻发布会";

            break;
        }
        case 60:
        {
            message = @"好孩子";
            title = @"会议论坛";
            break;
        }
    }
     [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
     [self.navigationController pushViewController:_messageController animated:YES];
}

@end
