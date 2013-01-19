//
//  FourViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "FourViewController.h"
#import "InfoViewController.h"
#import "OpinionsViewController.h"
#import "CardViewController.h"
#import "MScanViewController.h"
#import "TopBarView.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"更多";
        _messageArray = [[NSArray alloc] initWithObjects:@"关于",@"二维码名片",@"扫一扫",@"大会官网",@"意见反馈",@"评分",@"版本升级",nil];
    
    }
    return self;
}

#pragma mark - 
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///通过封装导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"更多";
    
    [self.view addSubview:_topBar.navImage];
    [self.view addSubview:_topBar.navLabel];
    
    self.editerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    
    self.editerTableView.delegate   = self;
    self.editerTableView.dataSource = self;
    [self.view addSubview:self.editerTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_editerTableView release];
    [_topBar release];
    [super dealloc];
}

#pragma mark - 
#pragma mark - UITableViewDelegate and UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.text = [_messageArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoViewController *info = [[InfoViewController alloc] init];
    NSString *url = nil;
    if (indexPath.row == 0) {
        
        url = @"http://www.baidu.com";
        info.urlString = url;
        info.navTitle  = @"关于";
        [self.navigationController pushViewController:info animated:YES];
    }
    else if (indexPath.row == 1){
    
        CardViewController *cardController = [[CardViewController alloc] init];
        [self.navigationController pushViewController:cardController animated:YES];
        
        [cardController release];
    }
    else if (indexPath.row == 2){
        MScanViewController *mscanController = [[MScanViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:mscanController animated:YES];
        
    }
    else if (indexPath.row == 3){
        
        url = @"http://www.xiximu.com";
        info.urlString = url;
        info.navTitle  = @"大会官网";
        [self.navigationController pushViewController:info animated:YES];
    }
    else if(indexPath.row == 4)
    {
        
        OpinionsViewController *opinionView = [[OpinionsViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:opinionView animated:YES];
        [opinionView release];
    }
}


@end
