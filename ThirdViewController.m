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
    
        self.title = @"收藏";
        ///初始化日程数组
        _myDateArray = [[NSMutableArray alloc] initWithObjects:@"10即消息上下的空间，可自由调整 ",@" 确定单元格高度。最关键的长度不一的消息所需的高度已经确定，下面只要加上上所需固定空间即可以确定单元格高度，完整代码 ",@"size即返回的完全显示消息实际需要的空间 ",@"size即返回的完全显示消息实际需要的空间 ",@"size即返回的完全",@"首先要确定一条消息所占的宽度，这个一般都是固定的，然后根据这个宽度来计算一段文字在这个宽度，某个字体下需要多少高度", nil];
        
        ///初始化名片数组
        self.qrArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dateTableView.delegate   = self;
    _dateTableView.dataSource = self;
    
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

            _dateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT) style:UITableViewStylePlain];
            _dateTableView.delegate = self;
            _dateTableView.dataSource = self;
            [self.view addSubview:_dateTableView];
            break;
        }
        case 1:{
            
            _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, WIDTH, HEIGHT)];
            _label.text =[[NSString alloc]
                          initWithFormat:@"%@",@"where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you? where are you?"];             
            _label.lineBreakMode = NSLineBreakByWordWrapping;
            _label.numberOfLines = 0;
            _label.font = [UIFont systemFontOfSize:13];
            
            [self.view addSubview:_label];

            break;
        }
        case 2:{
            
            _myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT - 40)];
            _myMapView.delegate = self;
            [self performSelector:@selector(optionalPlace)];
            [self.view addSubview:_myMapView];
            break;
        }
        case 3:
        {
            NSMutableArray *array = [QRcodeData findAllMessage];
            
            self.qrArray = array;
//            NSLog(@"数组：%@",array);
//            
//            for (int count = 0; count < [array count]; count++) {
//                QRcodeData *message = (QRcodeData *)[array objectAtIndex:count];
//                [self.qrArray insertObject:message atIndex:0];
//            }
            
            _qrTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT - 40) style:UITableViewStylePlain];
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

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([tableView isEqual:_qrTableView]) {
//        
//        UIFont *font = [UIFont systemFontOfSize:17.0f];
//        
//        ///这个其实应该是_qrArray
//        QRcodeData *qrMessage = (QRcodeData *)[self.qrArray objectAtIndex:indexPath.row];
//        CGSize size = [qrMessage.message  sizeWithFont:font constrainedToSize:CGSizeMake(100, 1000) lineBreakMode:NSLineBreakByCharWrapping];
//        return size.height + 10;
//    }
//    else
//    {
//        return 44;
//    }
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifer] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([tableView isEqual:_qrTableView]) {
        
        QRcodeData *qrMessage = (QRcodeData *)[self.qrArray objectAtIndex:indexPath.row];

        ///这里面的_myDateArray其实应该是_qrArray
        cell.detailTextLabel.text = qrMessage.message;
        cell.textLabel.text = qrMessage.name;
//        cell.detailTextLabel.numberOfLines = 0;
//        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    else{
        cell.textLabel.text = [_myDateArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [_myDateArray objectAtIndex:indexPath.row];
    }
    return cell;
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
        
//        //右按钮 推出下一个页面
//        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightBtn.frame = CGRectMake(0, 0, 40, 30);
//        rightBtn.tag = 1;
//        UIImage *image = [UIImage imageNamed:@"Arrow-Icon.png"];
//        [rightBtn setBackgroundImage:image forState:UIControlStateNormal];
//        [rightBtn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
//        customPinView.rightCalloutAccessoryView = rightBtn;
        
//        //左按钮 显示周边信息
//        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        leftBtn.frame = CGRectMake(0, 0, 53, 30);
//        UIImage *imageView =[UIImage imageNamed:@"附近.png"];
//        [leftBtn setBackgroundImage:imageView forState:UIControlStateNormal];
//        [leftBtn addTarget:self action:@selector(removeTabelView) forControlEvents:UIControlEventTouchUpInside];
//        customPinView.leftCalloutAccessoryView = leftBtn;
        return customPinView;
    }
    else {
        pinView.annotation = annotation;
    }
    return pinView;
}


@end
