//
//  CardViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-6.
//  Copyright (c) 2013年 Mars. All rights reserved.
//  http://42.121.237.116/customapp/ticket.php?phone=18810562517&name=oab&email=ripny@163.com&job=manager&company=cn&addr=2

#import "CardViewController.h"
#import "MBProgressHUD.h"
#import "QRCodeGenerator.h"
#import "CouponsViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CardNumber 10

@interface CardViewController ()

@end

@implementation CardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"个人名片";
        _cardArray = [[NSArray alloc] init];
        
        ///初始化TextField上面的文字默认是空
        _cardArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Card" ofType:@"plist"];
        ///获取项目的根路径
        NSDictionary *cardDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        _cardArray = [cardDictionary objectForKey:@"Card"];
    }
    return self;
}

///界面一出现时就从plist文件中获取数据
-(void)viewWillAppear:(BOOL)animated
{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        self.cardArr = [dictionary objectForKey:@"UserInfo"];
        [dictionary release];
    }
}

-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    return [documentPath stringByAppendingFormat:@"/card.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT - 49 - 44) style:UITableViewStyleGrouped];
    _cardTableView.delegate   = self;
    _cardTableView.dataSource = self;
    _cardTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cardTableView];

    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    
    _topBar.navLabel.text = @"二维码名片";
    
    [_topBar.backBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topBar];
   
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(265, 6, 50, 30);
    [_rightBtn setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(saveCardByQrcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBtn];
}

#pragma mark - SaveQRcode Methods

-(void)saveCardByQrcode:(id)sender
{
    CATransition *animation =[CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = @"cube";
    animation.subtype = @"fromRight";
    animation.removedOnCompletion = NO;
    
    ///创建字符串
    [self creatCardByPutMessage];
    
   _qrView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, HEIGHT-20)];
    
    _qrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, WIDTH , HEIGHT - 100)];
    
    NSString *appStr = [[NSString alloc] init];
    
    ///获取名片的内容
    for (int i = 0; i < 8; i++) {
        
        ///采用字符串拼接的方法
        appStr = [appStr stringByAppendingFormat:@"%@ \n",[self.cardArr objectAtIndex:i]];
       
    }
    
     _qrImage.image = [QRCodeGenerator qrImageForString:appStr imageSize:self.qrImage.bounds.size.width];
    
    ///保存图片到相册
    UIImageWriteToSavedPhotosAlbum(self.qrImage.image, self, nil, nil);
    
    UILabel *qrLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    qrLabel.text = @"该图片为个人二维码名片";
    qrLabel.font = [UIFont systemFontOfSize:20.0f];
    qrLabel.textColor = [UIColor redColor];
    qrLabel.backgroundColor = [UIColor clearColor];
    qrLabel.textAlignment = NSTextAlignmentCenter;
    
    [_cardTableView removeFromSuperview];
    [_qrView addSubview:qrLabel];
    [_qrView addSubview:_qrImage];
    [self.view addSubview:_qrView];
    
    [_rightBtn removeFromSuperview];
    _editerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editerBtn.frame = CGRectMake(265, 6, 50, 30);
    [_editerBtn setImage:[UIImage imageNamed:@"editer.png"] forState:UIControlStateNormal];
    
    [_editerBtn addTarget:self action:@selector(scanCard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_editerBtn];
    

    [self.view.layer addAnimation:animation forKey:@"animation"];
    
    [qrLabel  release];
}
//http://42.121.237.116/customapp/ticket.php?phone=18810562517&name=oab&email=ripny@163.com&job=manager&company=cn&addr=2

-(void)creatCardByPutMessage
{
 
    ///判断是否输入正确的电话号码
    NSString *postString = [NSString stringWithFormat:@"&m=reg&phone=%@&name=%@&email=%@&job=%@&company=%@&addr=%@",[self.cardArr objectAtIndex:4],[self.cardArr objectAtIndex:0],[self.cardArr objectAtIndex:6],[self.cardArr objectAtIndex:1],[self.cardArr objectAtIndex:2],[self.cardArr objectAtIndex:3]];
    
    ///网服务器传数据
    NSURL *url = [NSURL URLWithString:@"http://42.121.237.116/customapp/ticket.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    coonection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (coonection) {
        mutableData = [[NSMutableData data] retain];
    }
    
}


-(void)scanCard:(id)sender
{
    CATransition *animation =[CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = @"cube";
    animation.subtype = @"fromLeft";
    animation.removedOnCompletion = NO;
    
    
    ///要从界面上移除
    [_qrImage removeFromSuperview];
        
    ///返回到个人名片设置界面
    [self.view addSubview:_cardTableView];
    
    [_editerBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(265, 6, 50, 30);
    [_rightBtn setImage:[UIImage imageNamed:@"finish.png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(saveCardByQrcode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightBtn];
    
    ///这个是动画必不可少的一步
    [self.view.layer addAnimation:animation forKey:@"animation"];
}

-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

#pragma mark - UITableView Delegate And Datasoure Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cellIndetifer";
    ///手动去掉重用，不去掉的话，数据会有重复；这里的cell数据量不多，没有必要用到重用
    UITableViewCell *cell = nil;
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(95, 11, 260, 30)];
        _textField.delegate = self;
        _textField.tag = indexPath.row;
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:18.0f];
        _textField.textColor = [UIColor grayColor];
        _textField.text = [self.cardArr objectAtIndex:indexPath.row];
        [cell.contentView addSubview:_textField];
    }
    
    cell.textLabel.text = [_cardArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (textField.tag >= 4) {
       
        if (iPhone5) {
            CGRect rect = CGRectMake(0, -120,WIDTH,HEIGHT);//上移80个单位，按实际情况设置
            _cardTableView.frame = rect;
        }
    else{
        CGRect rect = CGRectMake(0, -140, WIDTH, HEIGHT-30);
        _cardTableView.frame = rect;
    }
   }

    [UIView commitAnimations];

    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0, 44,WIDTH,HEIGHT);//上移80个单位，按实际情况设置
    
    _cardTableView.frame = rect;
   [UIView commitAnimations];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 0: {
            
            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
            [self.cardArr replaceObjectAtIndex:0 withObject:textField.text];
            break;
        }
        case 1: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
             [self.cardArr replaceObjectAtIndex:1 withObject:textField.text];
            break;
        }
        case 2: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
             [self.cardArr replaceObjectAtIndex:2 withObject:textField.text];
            break;
        }
        case 3: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
             [self.cardArr replaceObjectAtIndex:3 withObject:textField.text];
            break;
        }
        case 4: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
                        
            NSRegularExpression *phoneRegulare = [[NSRegularExpression alloc] initWithPattern:@"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)" options:NSRegularExpressionCaseInsensitive error:nil];
            
            phoneNumber = [phoneRegulare numberOfMatchesInString:textField.text options:NSMatchingReportProgress range:NSMakeRange(0, textField.text.length)];
            if (phoneNumber > 0) {
                [self.cardArr replaceObjectAtIndex:4 withObject:textField.text];
            }
            else{
            
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的电话号码格式不正确,请重新输入！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alterView show];
                [alterView release];
            }
            [phoneRegulare release];
            
            break;
        }
        case 5: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
            [self.cardArr replaceObjectAtIndex:5 withObject:textField.text];
            break;
        }
        case 6: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
            NSRegularExpression *regulare = [[NSRegularExpression alloc] initWithPattern:@"[a-zA-Z0-9]+@[a-zA-Z0-9]+[\\.[a-zA-Z0-9]+]+" options:NSRegularExpressionCaseInsensitive error:nil];
            
            number = [regulare numberOfMatchesInString:textField.text options:NSMatchingReportProgress range:NSMakeRange(0, textField.text.length)];
            
            if (number > 0) {
                
                [self.cardArr replaceObjectAtIndex:6 withObject:textField.text];

            }
            else{
                
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的邮箱格式不正确，请重新输入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alterView show];
                [alterView release];

            }
            [regulare release];
            break;
        }
        case 7: {

            if ([textField.text isEqualToString:@""]) {
                textField.text = @"";
            }
            
           [self.cardArr replaceObjectAtIndex:7 withObject:textField.text];
            break;
        }
    }
        
    NSString *filePath = [self dataFilePath];
    NSMutableDictionary *dictinoary = [[NSMutableDictionary alloc] init];
    [dictinoary setObject:self.cardArr forKey:@"UserInfo"];
    [dictinoary writeToFile:filePath atomically:YES];
    [dictinoary release];
    return YES;
};

#pragma mark - NSURLConnection Delegate 

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:mutableData];
    if (image == nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"您已经生成优惠券，到我的优惠券查看";
        hud.mode = MBProgressHUDModeText;
        hud.delegate = self;
        hud.margin = 10.0f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    else{
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [path stringByAppendingPathComponent:@"image.jpg"];
        
        NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
        NSMutableDictionary *dictinoary = [[NSMutableDictionary alloc] init];
        [dictinoary setObject:dataObj forKey:@"UserInfo"];
        [dictinoary writeToFile:filePath atomically:YES];
        [dictinoary release];
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功" message:@"您已将照片存储于图片库中，打开照片程序即可查看。"
            delegate:self cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
        [alert show];
        [alert release];
        }
    
}

/**回到上一个界面的按钮*/
-(void)backPress:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_cardArr   release];
    [_cardArray release];
    [_cardTableView release];
    [_qrImage   release];
    [_qrView    release];
    [super dealloc];
}



@end
