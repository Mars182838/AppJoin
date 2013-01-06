//
//  CardViewController.m
//  AppJoin
//
//  Created by Mars on 13-1-6.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import "CardViewController.h"
#import "MBProgressHUD.h"

#define HEIGHT self.view.frame.size.height

#define WIDTH  self.view.frame.size.width

@interface CardViewController ()

@end

@implementation CardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _cardArray = [[NSArray alloc] init];
        
        ///获取项目的根路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Card" ofType:@"plist"];
        NSDictionary *cardDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        _cardArray = [cardDictionary objectForKey:@"Card"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _cardTableView.delegate   = self;
    _cardTableView.dataSource = self;
    _cardTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cardTableView];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(saveCardByQrcode:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
}

-(void)saveCardByQrcode:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.delegate = self;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"二维码已保存到相册";
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    [hud hide:YES afterDelay:2.0f];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifer] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(95, 13, 260, 30)];
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.font = [UIFont systemFontOfSize:16];
        textField.textColor = [UIColor grayColor];
        [cell.contentView addSubview:textField];
    }
    cell.textLabel.text = [_cardArray objectAtIndex:indexPath.row];
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
