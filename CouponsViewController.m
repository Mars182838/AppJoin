//
//  CouponsViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-23.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "CouponsViewController.h"

@interface CouponsViewController ()

@end

@implementation CouponsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"image.jpg"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        _label.text = @"通过该电子券进场，若丢失，可凭电话号码验证！";
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSMutableData *data = [dictionary objectForKey:@"UserInfo"];
        _imageView.image = [UIImage imageWithData:data];
        [dictionary release];
    }
    else{
        
    _label.text = @"您还没有电子券，请注册个人信息获取，请务必填写联系方式！";

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"我的优惠券";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 260, 40)];
    _label.font = [UIFont systemFontOfSize:18.0f];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, WIDTH-40, HEIGHT - 200)];
    [self.view addSubview:_imageView];
    
}

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [_imageView release];
    [_label     release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
