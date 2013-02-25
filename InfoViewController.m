//
//  InfoViewController.m
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "InfoViewController.h"
#import "TopBarView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    
    _topBar.navLabel.text = self.title;
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    _infoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 49 - 44)];
    _infoWebView.scalesPageToFit = YES;
    _infoWebView.delegate = self;
    [_infoWebView loadRequest:request];
    [self.view addSubview:_infoWebView];
}

#pragma mark - 
#pragma mark - UIWebViewDelegate 

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    _hud.labelText = @"加载中...";
    _hud.delegate = self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_hud hide:YES afterDelay:2.0f];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_hud removeFromSuperview];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = @"数据加载失败";
    hud.delegate = self;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
}

#pragma mark - BackPress

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [_infoWebView release];
    [_urlString   release];
    [super dealloc];
    
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
