//
//  DateViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-11.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DateViewController.h"
#import "DatePlan.h"

@interface DateViewController ()

@end

@implementation DateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dateArray = [[NSMutableArray alloc] initWithObjects:@"北京",@"杭州",@"上海",@"深圳", nil];
        self.detailArray = [[NSMutableArray alloc] initWithObjects:@"2013年 4月5-6日",@"2013年 6月7-8日",@"2013年 9月7-8日",@"2013年 10月7-8日",nil];
//        self.dateArray = [[NSMutableArray alloc] initWithCapacity:0];
//        self.detailArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isEditer = YES;
    
    ///初始化导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"日程表";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
    _dateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, WIDTH, HEIGHT-44-49) style:UITableViewStylePlain];
    _dateTableView.delegate   = self;
    _dateTableView.dataSource = self;
    [self.view addSubview:_dateTableView];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(265, 6, 50, 30);
    [_rightBtn setImage:[UIImage imageNamed:@"editer.png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(deleteMethods:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_rightBtn];
    
    
    NSURL *url = [NSURL URLWithString:@"http://baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connect) {
        messageData = [[NSMutableData alloc] initWithCapacity:0];
    }
    
}

#pragma mark - UITableView Delegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier = [NSString stringWithFormat:@"cell%d%d",[indexPath section],[indexPath row]];
    UITableViewCell *cell = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        }

    cell.textLabel.text = [_dateArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_detailArray objectAtIndex:indexPath.row];

    return cell;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sdgdsgd");
}

#pragma mark - NSURLConnection Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"下载中，请稍后";
    expectedLength = [response expectedContentLength];
    currentLength = 0;
    
    [messageData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    currentLength += [data length];
    _hud.progress = currentLength/(float)expectedLength;
    
    [messageData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_hud hide:YES afterDelay:1.0f];
    
//    /** NSJSONSerialization利用解析Json数据 */
//    NSError *error = nil;
//    NSDictionary *serial = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableLeaves error:&error];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"下载失败，请查看网络连接状态";
    [hud hide:YES afterDelay:1.0f];
}
#pragma mark - BackBtn 

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteMethods:(id)sender
{
    if (isEditer) {
        
        [self.dateTableView setEditing:YES animated:YES];
        [_rightBtn setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
        isEditer = NO;
    }
    else{
        [self.dateTableView setEditing:NO animated:YES];
        [_rightBtn setImage:[UIImage imageNamed:@"editer.png"] forState:UIControlStateNormal];
        isEditer = YES;
    }
}

-(void)dealloc
{
    [_dateTableView release];
    [_dateArray     release];
    [_detailArray   release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
