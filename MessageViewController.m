//
//  MessageViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = self.title;
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
}

/** 对接收到的数据进行图文混排，主要用到Label的自动换行 */
-(void)passMessageToMessageViewController:(NSString *)string andNavigationTitle:(NSString *)titleString
{
    self.title = titleString;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
    
    CGSize labelSize = [string sizeWithFont:[UIFont boldSystemFontOfSize:15] constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    ///ScrollView 要实现的方法
    CGSize newSize = CGSizeMake(labelSize.width, labelSize.height + 44 + 20 + 49);
    [scroll setContentSize:newSize];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, labelSize.width, labelSize.height)];
    label.text = string;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    [scroll addSubview:label];
    [self.view addSubview:scroll];
}

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc
{
    [_topBar release];
    [super dealloc];
}


@end
