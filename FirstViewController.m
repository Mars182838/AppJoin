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
#import "MediaViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
                button.showsTouchWhenHighlighted = YES;
                button.selected = YES;
                button.highlighted = YES;
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
    
    [_backImage         release];
    [_messageController release];
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
            message = [NSString stringWithFormat:@"%@",@"      北京国际连锁加盟展会是北京西西木国际展览有限公司强力打造的一个国际性连锁加盟品牌展。郑州连锁展分会、西安连锁展、温州连锁展分会是西西木策划的二线城市特色连锁加盟展会，与北京连锁加盟展会共享广告宣传资源和行业媒体资源。西西木已成功举办18届连锁加盟展会，展会规模逐年扩大，好评越来越多，在连锁加盟行业赢得良好的口碑。通过这些年的积累，西西木展览公司服务了几千家客户，协助这些企业招商，客户满意度达到80%以上，老客户也能占到40%以上。西西木展览凭借多年的丰厚积淀，2013年以全新的面貌，继续与特许企业精诚合作，共同开创特许经营发展的新时代，组委会期待您的积极参与!                                              联系人：赵先生  15611916870                                                        电  话：010-85789818                                                                                              传  真：010-52096899                                                                                                                              地  址：北京市朝阳区朝阳路69号1号楼1-304                                                          邮  编：100123 "];
            title = @"会议概况";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];            break;
        }
        case 2:
        {
            message = @"         第19届北京国际连锁加盟展览会                                                时间：2013年4月5-6日                                                  地点：北京 全国农业展览馆                               主办：北京西西木国际展览有限公司                            承办：北京西西木国际展览有限公司                            协办：中国经营报、报林、渠道网、现代营销、商界、全球加盟网";
            
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
            MediaViewController *media = [[MediaViewController alloc] init];
            [self.navigationController pushViewController:media animated:YES];
            [media release];
            break;
        }
        case 5:
        {
            message = @"暂时没有相关信息";
            title = @"新闻发布会";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];
            break;
        }
        case 6:
        {
            message = @"暂时没有相关信息";
            title = @"会议论坛";
            [_delegate passMessageToMessageViewController:message andNavigationTitle:title];
            [self.navigationController pushViewController:_messageController animated:YES];
            break;
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
