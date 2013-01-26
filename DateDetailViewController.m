//
//  DateDetailViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-21.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DateDetailViewController.h"

@interface DateDetailViewController ()

@end

@implementation DateDetailViewController

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
    
    ///初始化导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"详细日程";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
    CGSize labelSize = [_dateDetailString sizeWithFont:[UIFont boldSystemFontOfSize:18] constrainedToSize:CGSizeMake(300, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 54, labelSize.width, labelSize.height)];
    detail.font = [UIFont systemFontOfSize:18.0f];
    detail.backgroundColor = [UIColor clearColor];
    detail.numberOfLines = 0;
    detail.text = _dateDetailString;
    detail.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:detail];
    [detail release];
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

-(void)dealloc
{
    [_dateDetailString release];
    [super dealloc];
}

@end
