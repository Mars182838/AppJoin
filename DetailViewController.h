//
//  DetailViewController.h
//  AppProject
//
//  Created by Mars on 12-12-26.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DetailViewController : UIViewController

/** imageView 显示图片*/
@property (nonatomic, retain) UIImageView *imageView;

/** messageString 用于显示图片下面文字介绍*/
@property (nonatomic, retain) UITextView *messageString;

@end
