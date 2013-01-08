//
//  MScanViewController.m
//  QRCodeDemo
//
//  Created by Mars on 12-11-25.
//  Copyright (c) 2012年 ?. All rights reserved.
//

#import "MScanViewController.h"

@implementation MScanViewController

@synthesize readerView, resultText;

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [readerView start];

    readerView.readerDelegate = self;
    readerView.zoom = 0.5;//调整扫描区域
    readerView.trackingColor = [UIColor orangeColor];//扫描框颜色
    
    UIBarButtonItem *editerBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(editerPress:)];
    self.navigationItem.rightBarButtonItem = editerBtn;
    [editerBtn release];
}

//启动扫描视图
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    
    ZBarReaderController * reader = [[ZBarReaderController alloc] init];
    reader.allowsEditing = YES;//是否可以对二维码图片进行编辑
    reader.readerDelegate = self;
    
    //UIImagePickerController默认sourceType就是PhotoLibrary，但ZBarReaderController继承他后把sourceType改成Camera，所以在这需要我们手动设置，否则在真机上会打开摄象头而不是相册
    reader.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//从相册中获取二维码图片
    
    [reader.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];//配置解码器
    
    [self presentViewController:reader animated:YES completion:nil];
    [reader release];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for (symbol in results) {
        
        break;
    }
    
    ///取出二维码中封装的数据
    NSString *qrString = symbol.data;
    
    ///很多二维码是日本人开发，所以会用到日文编写，因此要解决乱码问题
    if ([qrString canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
        NSString *newString = [NSString stringWithCString:[symbol.data cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        
        ///判断是否转码有效
        if (newString != nil) {
            qrString = newString;
        }
    }
    resultText.text = qrString;
    
    ///获得编辑过的图片
    if (picker.allowsEditing == YES) {
        self.qrImage.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    else {
        self.qrImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.readerView = nil;
    self.resultText = nil;
}

- (void)dealloc
{
    [readerView release];
    [resultText release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
