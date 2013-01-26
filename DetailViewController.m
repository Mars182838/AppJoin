//
//  DetailViewController.m
//  AppProject
//
//  Created by Mars on 12-12-26.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)dealloc
{
    [_messageString release];
    [_imageView release];
    [_topBar   release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"详细介绍";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
    
}

-(void)transferImageUrl:(NSString *)urlString andString:(NSString *)message
{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 240)];
    [_imageView setImageWithURL:[NSURL URLWithString:urlString] refreshCache:YES placeholderImage:[UIImage imageNamed:@"place.png"]];
    [self.view addSubview:_imageView];
    
    _messageString = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 196, self.view.frame.size.width, 146)];
    _messageString.font = [UIFont systemFontOfSize:16];
    _messageString.text = message;
    [self.view addSubview:_messageString];

}

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_messageString resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
