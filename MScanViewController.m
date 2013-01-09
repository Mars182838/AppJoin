//
//  MScanViewController.m
//  QRCodeDemo
//
//  Created by Mars on 12-11-25.
//  Copyright (c) 2012年 ?. All rights reserved.
//

#import "MScanViewController.h"
#import "MBProgressHUD.h"
#import "QRcodeData.h"

@implementation MScanViewController

@synthesize readerView, resultText;

#pragma mark - lifeCycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [readerView start];

    readerView.readerDelegate = self;
    readerView.zoom = 0.5;//调整扫描区域
    readerView.trackingColor = [UIColor orangeColor];//扫描框颜色
    
    UIBarButtonItem *editerBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonSystemItemDone target:self action:@selector(editerPress:)];
    self.navigationItem.rightBarButtonItem = editerBtn;
    [editerBtn release];
    
    _messageTextField.delegate = self;
}

- (void)dealloc
{
    [readerView release];
    [resultText release];
    [_messageTextField release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)readerView:(ZBarReaderView*)view didReadSymbols:(ZBarSymbolSet*)syms  fromImage: (UIImage*) img
{
    for(ZBarSymbol *sym in syms) {
        
        resultText.text = sym.data;
        break;
    }
    
    ///停止扫描
    [readerView stop];

}

#pragma mark - UIPickImage Delegate Methods

/** 从相册中获取二维码 */
-(void)editerPress:(id)sender
{
    if ([_messageTextField.text isEqualToString:@""]) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你没有输入任何信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alterView show];
        [alterView release];
    }else{
        
        ///往数据库里面添加数据
        [QRcodeData addMessageWithName:_messageTextField.text andMessage:resultText.text];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"名片保存成功";
        hud.delegate = self;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0f];
    }
}

#pragma mark - MBProgressHUD Delegate Methods

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_messageTextField resignFirstResponder];
    return YES;
}

///点击屏幕的人一个位置返回键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_messageTextField resignFirstResponder];
    [resultText resignFirstResponder];
}


@end
