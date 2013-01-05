//
//  FourViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *editerTableView;
@property (nonatomic, retain) NSArray *messageArray;



@end
