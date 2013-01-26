//
//  SecondViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "SecondViewController.h"
#import "InfoViewController.h"
#import "DownLoadString.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _messageArray = [[NSMutableArray alloc] init];
    }
    return self;
}
#pragma mark - 
#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///通过封装出导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _topBar.navLabel.text = @"资讯";
    [self.view addSubview:_topBar.navImage];
    [self.view addSubview:_topBar.navLabel];
    
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT -44) style:UITableViewStylePlain];
    _infoTableView.delegate   = self;
    _infoTableView.dataSource = self;
    [self.view addSubview:_infoTableView];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.infoTableView.bounds.size.height, self.view.frame.size.width, self.infoTableView.bounds.size.height)];
		view.delegate = self;
		[self.infoTableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];

    _downLoad = [[DownLoadString alloc] initWithShareTarget:NSStringWithUrlFirst];
    _downLoad.delegate = self;
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    [self.infoTableView reloadData];
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.infoTableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [_infoTableView release];
    [_messageArray  release];
    [_downLoad      release];
    [super dealloc];
}

#pragma mark - DownLoad Delegate

-(void)downLoadFinished:(NSDictionary *)info
{
    NSDictionary *dic = info;
    self.messageArray = [dic objectForKey:@"posts"];
    [self.infoTableView reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier] ;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier] autorelease];
        cell.textLabel.text = [[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"发布于：%@",[[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"modified"]];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
/** 该函数是指点击一个数据的时候，到另一个界面
 * @prama indexPath是指传递数据到下一个界面
 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoViewController *info = [[InfoViewController alloc] init];
    info.title = @"资讯详细";
    info.urlString = [[self.messageArray objectAtIndex:indexPath.row] objectForKey:@"url"];
    [self.navigationController pushViewController:info animated:YES];
    [info release];
}

@end
