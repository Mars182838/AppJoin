//
//  MainViewController.h
//  AppJoin
//
//  Created by Mars on 12-12-29.
//  Copyright (c) 2012年 Mars. All rights reserved.
//

#import "iCarousel.h"
#import "MBProgressHUD.h"
@class DetailViewController;
@class Reachability;

@protocol DetailViewDelegate <NSObject>

-(void)transferImage:(UIImage *)image andString:(NSString *)message;

@end

@interface MainViewController : UIViewController<UIWebViewDelegate,iCarouselDataSource,iCarouselDelegate,MBProgressHUDDelegate>
{
    
    id <DetailViewDelegate> delegate;
    /** wrap 当wrap是YES时，图片可以循环显示
     *  当wrap 是NO的时候图片不可以循环显示
     */
    BOOL wrap;
    MBProgressHUD *hud;
    ///检测是否联网
    Reachability *hostReach;
}

/** casousel 第三方库用于实现Cover flow 效果，
 *如上实现iCarouselDataSource，iCarouselDelegate 这两个协议
 */
@property (nonatomic, retain) iCarousel *carousel;

/// detailController 显示点击图片之后显示详细的介绍
@property (nonatomic, retain) DetailViewController *detailController;

/** delegate DetailViewController 设置为 MainViewController的代理
 *用于传递图片和详细的文字介绍
 */
@property (nonatomic, assign) id <DetailViewDelegate> delegate;

///label 显示图片下面的文字介绍
@property (nonatomic, retain) UILabel *label;


@end
