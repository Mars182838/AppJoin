//
//  FourViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "FourViewController.h"
#import "InfoViewController.h"
#import "OpinionViewController.h"
#import "CardViewController.h"
#import "MScanViewController.h"

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
    
    self.editerTableView.delegate   = self;
    self.editerTableView.dataSource = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_editerTableView release];
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
        [self.navigationController pushViewController:info animated:YES];
    }
    else if(indexPath.row == 4)
    {
        
        OpinionViewController *opinionView = [[OpinionViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:opinionView animated:YES];
        [opinionView release];
    }
}


@end
