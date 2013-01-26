//
//  MediaViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-21.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MediaViewController.h"

@interface MediaViewController ()

@end

@implementation MediaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"合作媒体";

    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
    if (iPhone5) {
        for (int count = 0; count < 3; count ++) {
            for (int j = 0; j < 2; j++) {
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(20 + 150*j, 80 + 140*count, 130, 130);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ht%d.png",2*count+j+1]]forState:UIControlStateNormal];
                button.tag = 2*count+j+1;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
        }
    }
    else
    {
        for (int count = 0; count < 3; count ++) {
            for (int j = 0; j < 2; j++) {
                
                UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(20 + 150*j, 50 + 120*count, 130, 110);
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ht%d.png",2*count+j+1]] forState:UIControlStateNormal];
                button.tag = 2*count+j+1;
                [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
            }
        }
    }
}

/**bnt.tag 相应的进入媒体官网，
 *1为报林
 *2、为中国经营报
 *3为商界
 *4为全球加盟网
 *5为渠道网
 *6为现代营销
 */
-(void)buttonPress:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bali.qikan.com"]];
            break;
        }
        case 2:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://37.cn.dv37.com"]];
            break;
        }
        case 3:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://media.sj998.com/sj/"]];
            break;
        }
        case 4:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jiameng.com"]];
            break;
        }
        case 5:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hao.qudao.com"]];
            break;
        }
        case 6:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://xdxx.qikan.com"]];
            break;
        }
    }
}

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
