//
//  ThirdViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "ThirdViewController.h"
#import "InfoViewController.h"
#import "Place.h"
#import "QRcodeData.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
        ///初始化展商数组
        _myDateArray = [[NSMutableArray alloc] init];
        
        ///初始化名片数组
        _qrArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isEditer = YES;
    
    ///通过封装导航栏的视图
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _topBar.navLabel.text = @"服务";
    [self.view addSubview:_topBar.navImage];
    [self.view addSubview:_topBar.navLabel];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(265, 6, 50, 30);
    [_rightBtn setImage:[UIImage imageNamed:@"editer.png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(deleteMethods:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_rightBtn];
    
    _dateTableView.delegate   = self;
    _dateTableView.dataSource = self;
    
    _downLoad = [[DownLoadString alloc] initWithShareTarget:NSStringWithUrlSecond];
    _downLoad.delegate = self;
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.dateTableView.bounds.size.height, self.view.frame.size.width, self.dateTableView.bounds.size.height)];
		view.delegate = self;
		[self.dateTableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}

-(void)downLoadFinished:(NSDictionary *)info
{
    NSDictionary *dic = info;
    self.myDateArray = [dic objectForKey:@"posts"];
    [self.dateTableView reloadData];
}

//当前位置信息
-(void)optionalPlace
{
    place = [[Place alloc] initWithCoordinates:ShareApp.location];
    [self.myMapView setRegion:ShareApp.theRegion animated:YES];
    
    _location = [[CLLocation alloc] initWithLatitude:ShareApp.location.latitude  longitude:ShareApp.location.longitude];
    
    //反向解析当前位置的数据
    CLGeocoder *geocoder = [[[CLGeocoder alloc] init] autorelease];
    [geocoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemark,NSError *error)
     {
         CLPlacemark *Mark = [placemark objectAtIndex:0];
         place.title = @"没有当前位置的详细信息";
         place.subTitle = @"详细信息请点击‘附近’查看";
         place.title = [NSString stringWithFormat:@"%@%@",Mark.subLocality,Mark.thoroughfare];//获取title信息
         place.subTitle = [NSString stringWithFormat:@"%@",Mark.name];//获取subtitle的信息
         [self.myMapView selectAnnotation:place animated:YES];
     }];
    [self.myMapView addAnnotation:place];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_dateTableView release];
    [_topBar        release];
    [_downLoad      release];
    [_rightBtn      release];
    [_qrArray       release];
    [_qrTableView   release];
    [_myDateArray   release];
    [_myMapView     release];
    [_label         release];
    [super dealloc];
}

- (IBAction)segmentActive:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    ///用segment选择视图显示之前，先把其他的视图从主视图移除，然后从新创建
    [_label         removeFromSuperview];
    [_dateTableView removeFromSuperview];
    [_myMapView     removeFromSuperview];
    [_qrTableView   removeFromSuperview];

    switch ([segmentControl selectedSegmentIndex]) {
            
        case 0:{
            
            _rightBtn.alpha = 1.0;
            _dateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, WIDTH, HEIGHT) style:UITableViewStylePlain];
            _dateTableView.delegate = self;
            _dateTableView.dataSource = self;
            [self.view addSubview:_dateTableView];
            [self.dateTableView reloadData];
            break;
        }
        case 1:{
        
            _rightBtn.alpha = 0.0;
            
            _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 84, WIDTH - 10, HEIGHT- 100)];
            _label.text = @"               全国农业展览馆交通位置                                                                                                                    农展馆地址：北京市朝阳区东三环北路16号                                    全国农业展览馆周边公交线路如下:                  运通107（广顺南大街北口 — 马家堡路北口）：农展馆                                                                   113路（民族园路 — 大北窑）：长虹桥西            115路（康家沟 — 东黄城根北口）：长虹桥西  117路（红庙 — 五路居）：长虹桥西                 夜班207路（慧中里 — 四惠站）：农展馆             300路（十里河桥北—十里河桥南）：亮马桥     300快（大钟寺—大钟寺）：亮马桥                              302路（巴沟村 — 辛庄）：亮马桥                             350路（东大桥 — 曹各庄）：长虹桥南              402路（四惠站 — 南皋）：农展馆                405路（四惠站 — 孙河东站）：农展馆            416路（来广营 — 来广营）：亮马桥            ";
            _label.lineBreakMode = NSLineBreakByWordWrapping;
            _label.numberOfLines = 0;
            _label.font = [UIFont systemFontOfSize:15];
            
            [self.view addSubview:_label];

            break;
        }
        case 2:{
            
            _rightBtn.alpha = 0.0;
            _myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 84, WIDTH, HEIGHT - 40)];
            _myMapView.delegate = self;
            [self performSelector:@selector(optionalPlace)];
            [self.view addSubview:_myMapView];
            break;
        }
        case 3:
        {
            _rightBtn.alpha = 1.0;
            
            NSMutableArray *array = [QRcodeData findAllMessage];
            self.qrArray = array;
    
            _qrTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 84, WIDTH, HEIGHT - 40) style:UITableViewStylePlain];
            _qrTableView.delegate   = self;
            _qrTableView.dataSource = self;
            
            [self.view addSubview:_qrTableView];
            
            [self.qrTableView reloadData];
            break;
        }
    }
}

#pragma mark - 
#pragma mark - UITableViewDelegate Methods

/** 如果是tableView是_dateTableView则返回的是_myDateArray.count，
 *否则返回的是_qrArray.count
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_dateTableView]) {
        return _myDateArray.count;
    }
    else{
        ///这个其实应该是_qrArray
        return _qrArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_qrTableView]) {
        
        UIFont *font = [UIFont systemFontOfSize:17.0f];
        
        ///这个其实应该是_qrArray
        QRcodeData *qrMessage = (QRcodeData *)[self.qrArray objectAtIndex:indexPath.row];
        CGSize size = [qrMessage.message  sizeWithFont:font constrainedToSize:CGSizeMake(100, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        return size.height + 10;
    }
    else
    {
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifer] autorelease];
    }
    if ([tableView isEqual:_qrTableView]) {
        
        QRcodeData *qrMessage = (QRcodeData *)[self.qrArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = qrMessage.name;
        ///这里面的_myDateArray其实应该是_qrArray
        cell.detailTextLabel.text = qrMessage.message;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    else{
        cell.textLabel.text = [[_myDateArray objectAtIndex:indexPath.row] objectForKey:@"title"];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _dateTableView) {
       
        InfoViewController *info = [[InfoViewController alloc] init];
        info.title = @"展商详情";
        info.urlString = [[self.myDateArray objectAtIndex:indexPath.row] objectForKey:@"url"];
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (tableView == _dateTableView) {
            [self.myDateArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.dateTableView reloadData];
        }
        else{
            QRcodeData *data = [self.qrArray objectAtIndex:indexPath.row];
            [QRcodeData deleteMessageID:data.ID];
            [self.qrArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationLeft];
            [self.qrTableView reloadData];
        }
    }
}

#pragma mark -
#pragma mark MapViewDelegate Methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *defauntPinID = @"annotationID";
    pinView = (MKPinAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:defauntPinID];
    if (pinView == nil) {
        MKPinAnnotationView *customPinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defauntPinID] autorelease];
        customPinView.pinColor = MKPinAnnotationColorPurple;
        customPinView.canShowCallout = YES;
        customPinView.animatesDrop = YES;
        
        return customPinView;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}

-(void)deleteMethods:(id)sender
{
    if (isEditer) {
    
        [self.dateTableView setEditing:YES animated:YES];
        [self.qrTableView setEditing:YES animated:YES];
        [_rightBtn setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
        isEditer = NO;
    }
    else{
        [self.dateTableView setEditing:NO animated:YES];
        [self.qrTableView setEditing:NO animated:YES];
         [_rightBtn setImage:[UIImage imageNamed:@"editer.png"] forState:UIControlStateNormal];
        isEditer = YES;
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    [self.dateTableView reloadData];
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.dateTableView];
	
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

/**
 *当数据在加载的时候，返回_reloading
 */
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
}

/**返回更新的时间，以及日期
 *@prama NSDate 实例
 */
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
