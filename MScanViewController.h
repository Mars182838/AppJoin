//
//  MScanViewController.h
//  QRCodeDemo
//
//  Created by Mars on 12-11-25.
//  Copyright (c) 2012年 ?. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface MScanViewController : UIViewController<ZBarReaderViewDelegate,ZBarReaderDelegate>

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;

@property (nonatomic, retain) IBOutlet UITextView *resultText;

@property (nonatomic, retain) UIImageView *qrImage;

@end
