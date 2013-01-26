//
//  OpinionViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-16.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TopBarView;

@interface OpinionsViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection *coonection;
    NSMutableData *mutableData;
}

///意见框的背景图片
@property (nonatomic, retain) UIImageView *opinionBackImage;

///意见输入框
@property (retain, nonatomic) UITextView *opinionTextView;

///邮箱输入框
@property (retain, nonatomic) UITextField *emailTextField;

///电话输入框
@property (retain, nonatomic) UITextField *phoneTextField;

///显示数字个数
@property (retain, nonatomic) UILabel *numberLabel;

///定制导航栏的图片
@property (nonatomic, retain) TopBarView *topBar;

///导航栏上面右边按钮
@property (nonatomic, retain) UIButton *rightBtn;


@end
