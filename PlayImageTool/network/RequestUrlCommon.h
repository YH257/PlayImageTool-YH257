//
//  RequestUrlCommon.h
//  PointRaceStone
//
//  Created by fdinc01 on 2018/5/11.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#ifndef RequestUrlCommon_h
#define RequestUrlCommon_h


//正式服务器
#define XDAppCommentUrl @"http://myapp.kecoo.com.cn/public"

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#pragma mark -  我的
#define XDHomeLogin @"Home.GetLogin"

#define screen_With [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

#define XDUsername @"13959004893"
#define XDPassword @"xd520134"

#define RGB16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define RGB16withAlpha(rgbValue,alphaVal) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaVal]
#define UIImageNameStr(str) [UIImage imageNamed:str]
#define UIFont_size(size) [UIFont systemFontOfSize:size]

#define LQKeyWindow [[[UIApplication sharedApplication] delegate] window]

//主色调
#define fMainColor RGB16withAlpha(0xff9000, 1)
//主背景颜色
#define fViewCtrlBgc RGB16withAlpha(0xf5f5f5, 1)
//字体主深色
#define fFontMainDeepColor RGB16(0x333333)
//字体主浅色
#define fFontMainShallowColor RGB16(0x666666)
//字体主弱灰色
#define fFontMainWeakColor RGB16(0x999999)
//线的主色
#define fLineColor RGB16(0xe6e6e6)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define APPKey @"5b63f358b27b0a140500002e"


#endif /* RequestUrlCommon_h */


