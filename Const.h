//
//  Const.h
//  AppJoin
//
//  Created by Mars on 13-1-7.
//  Copyright (c) 2013年 Mars. All rights reserved.
//

/** 屏幕的宽度 */
#define WIDTH  self.view.frame.size.width

/** 屏幕的高度 */
#define HEIGHT self.view.frame.size.height

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
