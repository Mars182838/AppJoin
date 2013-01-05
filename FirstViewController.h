//
//  FirstViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageViewController;

@protocol MessageViewControllerDelegate <NSObject>

/** 这是代理方法，传递两个值到MessageViewController类中
 *string 是指的文字信息
 *titleString 是指的导航栏上面的文字
 */
-(void)passMessageToMessageViewController:(NSString *)string andNavigationTitle:(NSString *)titleString;

@end

@interface FirstViewController : UIViewController

///详细信息类属性
@property (nonatomic, retain) MessageViewController *messageController;

///代理属性
@property (nonatomic, assign) id<MessageViewControllerDelegate>delegate;

- (IBAction)buttonPress:(id)sender;

@end
