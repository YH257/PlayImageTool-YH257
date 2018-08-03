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


#pragma mark -  我的
#define XDHomeLogin @"Home.GetLogin"

#define XDUsername @"13959004893"
#define XDPassword @"xd520134"

#define RGB16withAlpha(rgbValue,alphaVal) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaVal]


#define fViewCtrlBgc RGB16withAlpha(0xf5f5f5, 1)

#endif /* RequestUrlCommon_h */


