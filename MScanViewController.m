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
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    _topBar.navLabel.text = @"扫一扫";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];


    readerView.readerDelegate = self;
    readerView.zoom = 0.5;//调整扫描区域
    readerView.trackingColor = [UIColor orangeColor];//扫描框颜色
    [readerView start];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(265, 6, 50, 30);
    [saveBtn setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(editerPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    _messageTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, WIDTH - 60, 30)];
    _messageTextField.keyboardType = UIKeyboardTypeDefault;
    _messageTextField.returnKeyType = UIReturnKeyDone;
    _messageTextField.borderStyle = UITextBorderStyleRoundedRect;
    _messageTextField.delegate = self;
    [self.view addSubview:_messageTextField];
    
    resultText = [[UITextView alloc] initWithFrame:CGRectMake(30,  HEIGHT- 100, 260, 100)];
    resultText.keyboardType = UIKeyboardTypeDefault;
    resultText.scrollEnabled = YES;
    resultText.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    resultText.textColor = [UIColor whiteColor];
    resultText.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:resultText];
}

-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [readerView release];
    [resultText release];
    [_messageTextField release];
    [super dealloc];
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
