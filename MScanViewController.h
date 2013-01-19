//
//  MScanViewController.h
//  QRCodeDemo
//
//  Created by Mars on 12-11-25.
//  Copyright (c) 2012年 ?. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"
#import "MBProgressHUD.h"

@interface MScanViewController : UIViewController<ZBarReaderViewDelegate,ZBarReaderDelegate,MBProgressHUDDelegate,UITextFieldDelegate>

///对名片进行标注
@property (retain, nonatomic) UITextField *messageTextField;

///二维码视图
@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;

///显示二维码信息的TextView
@property (nonatomic, retain) UITextView *resultText;

@property (nonatomic, retain) TopBarView *topBar;
@end
