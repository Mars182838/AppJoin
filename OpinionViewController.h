//
//  OpinionViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-5.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,NSURLConnectionDataDelegate>
{
    NSURLConnection *coonection;
    NSMutableData *mutableData;
}

///意见输入框
@property (retain, nonatomic) IBOutlet UITextView *opinionTextView;
///邮箱输入框
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
///电话输入框
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;

@property (retain, nonatomic) IBOutlet UILabel *numberLabel;

@end
