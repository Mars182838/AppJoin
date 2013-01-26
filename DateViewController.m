//
//  DateViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-11.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "DateViewController.h"
#import "DateDetailViewController.h"
#import "CustomCell.h"

@interface DateViewController ()

@end

@implementation DateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dateArray = [[NSMutableArray alloc] initWithObjects:@"北京站                                      时间：2013年 4月5-6日                                         地点：北京·全国农业展览馆",@"郑州站                                            时间：2013年5月25-26日                                        地点：郑州·中原博览中心",@"西安站                                                         时间：2013年9月份中旬                                   地点：西安·曲江国际会展中心",@"温州站                                         时间：2013年10月份                                                    地点：温州·温州市科技馆",@"北京站                                                         时间：2013年11月份上旬                                          地点：北京·全国农业展览馆", nil];
        _detailArray = [[NSMutableArray alloc] initWithObjects:@"2013年4月4日 上午08:30—下午17:00  参展商报到、布展                                                                            2013年4月5日 上午09:00—下午16:30  专业观众观展，中午不闭                       2013年4月6日 上午09:00—下午15:30  专业观众观展，中午不闭                                    2013年4月6日 下午15:30—下午17:30  展商撤展时间",@"暂时没有详细时间安排，请关注后续更新",@"暂时没有详细时间安排，请关注后续更新",@"暂时没有详细时间安排，请关注后续更新",@"暂时没有详细时间安排，请关注后续更新", nil];
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
}

#pragma mark - UITableView Delegate And DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cellIndentifer";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    
    cell.nameLabel.text = [NSString stringWithFormat:@"第%d届连锁加盟展会 %@",indexPath.row +19,[_dateArray objectAtIndex:indexPath.row]];
    
   return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DateDetailViewController *dateDetail = [[DateDetailViewController alloc] initWithNibName:nil bundle:nil];
    dateDetail.dateDetailString = [self.detailArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:dateDetail animated:YES];
    [dateDetail release];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    CGSize size = [ [self.dateArray objectAtIndex:indexPath.row]  sizeWithFont:font constrainedToSize:CGSizeMake(100, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    return size.height;
}

#pragma mark - BackBtn 

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
