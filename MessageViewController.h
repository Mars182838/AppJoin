//
//  MessageViewController.h
//  AppJoin
//
//  Created by Mars on 13-1-2.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@interface MessageViewController : UIViewController<MessageViewControllerDelegate>

/** label显示文字信息 */
@property (nonatomic, retain) UITextView *label;

/** 接收从FirstViewController类传递过来的数据 */
@property (nonatomic, copy) NSString *infoString;

@property (nonatomic, retain) TopBarView *topBar;

@end
