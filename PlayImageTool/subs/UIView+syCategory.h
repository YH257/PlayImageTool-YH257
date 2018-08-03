//
//  UIView+syCategory.h
//  PointRaceStone
//
//  Created by fdinc02 on 2018/5/14.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (syCategory)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

/**
 *  让UIView在父View中水平居中，注意：调用此方法前确保当前view已加入父view中
 */
- (void)setUIViewCenter;

/**
 *  让UIView在父View垂直居中，注意：调用此方法前确保当前view已加入父view中
 */
- (void)setUIViewMiddle;

/**
 *   让view 在父view剧右 注意：调用此方法前确保当前view已加入父view中
 *   paddingX 留间距
 */

- (void)setUIViewRigh:(CGFloat) paddingX;

/**
 *  设置阴影
 *
 *  @param opacityValue     透明度
 *  @param colorInfo 阴影颜色
 
 *  @param radiusValue 阴影区域
 */
-(void)viewShadow:(float)opacityValue colorInfo:(UIColor *)colorInfo radiusValue:(CGFloat)radiusValue;

@end
