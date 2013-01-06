//
//  OpinionViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-5.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "OpinionViewController.h"
#import "URLEncode.h"

#define HEIGHT self.view.frame.size.height

#define WIDTH  self.view.frame.size.width


@interface OpinionViewController ()

@end

@implementation OpinionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"意见反馈";
        
    }
    return self;
}
#pragma mark - lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _emailTextField.delegate  = self;
    _opinionTextView.delegate = self;
    _phoneTextField.delegate  = self;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(commiterOpinion:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_opinionTextView release];
    [_emailTextField release];
    [_phoneTextField release];
    [_numberLabel release];
    [super dealloc];
}

#pragma mark - UITextView Delegate Methods
/** 收回键盘的代理方法 如果用户输入换行时，默认是返回键盘 */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/** 计算用户输入多少个文字 */
-(void)textViewDidChange:(UITextView *)textView
{
    int a = 200 - self.opinionTextView.text.length;
    NSNumber *num = [[NSNumber alloc] initWithInt:a];
    self.numberLabel.text = [NSString stringWithFormat:@"还可以输入%@个字",num];
    [num release];
}

#pragma mark - UITextField Delegate Methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"Resize" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, -150, WIDTH, HEIGHT);
    
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect=CGRectMake(0,0,WIDTH,HEIGHT);//上移80个单位，按实际情况设置
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    return YES;
}


/** 点击屏幕的任意位置返回键盘 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.opinionTextView resignFirstResponder];
    [self.emailTextField  resignFirstResponder];
    [self.phoneTextField  resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect=CGRectMake(0,0,WIDTH,HEIGHT);//上移80个单位，按实际情况设置
    self.view.frame = rect;
    [UIView commitAnimations];
   
}

#pragma mark - UIButtonPress Methods
/** 利用正则表达式 判断输入的正不正确 */
- (void)commiterOpinion:(id)sender {
    
    NSRegularExpression *regulare = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z0-9]+@[a-zA-Z0-9]+[\\.[a-zA-Z0-9]+]+" options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [regulare numberOfMatchesInString:self.emailTextField.text options:NSMatchingReportProgress range:NSMakeRange(0, self.emailTextField.text.length)];
    [regulare release];
    
    if (number > 0) {
        NSString *postString = [NSString stringWithFormat:@"act=advise&dev=ios&ver=1.1&email=%@&advise=%@",self.emailTextField.text,[URLEncode encodeUrlStr:self.opinionTextView.text]];
        
        NSURL *url = [NSURL URLWithString:@"http://ibokan.gicp.net/ibokan/map/map.php"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        coonection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if (coonection) {
            mutableData = [[NSMutableData data] retain];
        }
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"感谢您的宝贵意见" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
        [alter release];
    }
    else {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"您输入的邮箱不正确,请输入正确的邮箱" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterView show];
        [alterView release];
    }
}

#pragma mark - NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString * str = [NSString stringWithCString:[mutableData bytes] encoding:NSASCIIStringEncoding];
    NSLog(@"str = %@",str);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"连接超时，请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
@end
