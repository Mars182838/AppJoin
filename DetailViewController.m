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
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [_messageString release];
    [_imageView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

-(void)transferImage:(UIImage *)image andString:(NSString *)message
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 240)];
    _imageView.image = image;
    [self.view addSubview:_imageView];
    
    _messageString = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 240, self.view.frame.size.width, 143)];
    _messageString.text = message;
    _messageString.textColor = [UIColor redColor];
    [self.view addSubview:_messageString];

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
