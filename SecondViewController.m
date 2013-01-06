//
//  SecondViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "SecondViewController.h"
#import "InfoViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"资讯";
        _messageArray = [[NSMutableArray alloc] initWithObjects:@"我们",@"呵呵呵",@"你好",@"你好啊", nil];
    }
    return self;
}
#pragma mark - 
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.infoTableView.delegate   = self;
    self.infoTableView.dataSource = self;
    
    NSURL *url = [NSURL URLWithString:@"http:www.baidu.com"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connect) {
        mutableData = [[NSMutableData alloc] initWithCapacity:0];
    }
    else
    {
        NSLog(@"网络请求失败");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_infoTableView release];
    [super dealloc];
}

#pragma mark -
#pragma mark - UITableViewDataSources and UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cellIndentifer";
    UITableViewCell *cell = [[tableView dequeueReusableCellWithIdentifier:indentifier] autorelease];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier] autorelease];
            cell.textLabel.text = [_messageArray objectAtIndex:indexPath.row];
    }
    return cell;
}
/** 该函数是指点击一个数据的时候，到另一个界面
 * @prama indexPath是指传递数据到下一个界面
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoViewController *info = [[InfoViewController alloc] init];
    NSString *string = [[NSString alloc] initWithFormat:@"%@",@"王俊"];
    info.urlString = string;
    [self.navigationController pushViewController:info animated:YES];
}

#pragma mark - 
#pragma mark - NSURLConnectionDataDelegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"下载中，请稍后";
    expectedLength = [response expectedContentLength];
    currentLength = 0;
    
    [mutableData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    currentLength += [data length];
    _hud.progress = currentLength/(float)expectedLength;
    
    [mutableData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_hud hide:YES afterDelay:1.0f];
    
    /** NSJSONSerialization利用解析Json数据 */
    NSError *error = nil;
    NSDictionary *serial = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"serial----%@",serial);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"下载失败，请查看网络连接状态";
    [hud hide:YES afterDelay:1.0f];
}

@end
