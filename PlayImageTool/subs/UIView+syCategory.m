//
//  UIView+syCategory.m
//  PointRaceStone
//
//  Created by fdinc02 on 2018/5/14.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import "UIView+syCategory.h"

@implementation UIView (syCategory)

#pragma mark - frame操作
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

#pragma mark 让view在父View中水平居中
- (void)setUIViewCenter{
    self.x=(self.superview.frame.size.width-self.frame.size.width)/2;
}

#pragma mark 让view在父View中垂直居中
- (void)setUIViewMiddle{
    self.y=(self.superview.frame.size.height-self.frame.size.height)/2;
}

#pragma mark 让view 在父view剧右

- (void)setUIViewRigh:(CGFloat) paddingX{
    self.x=self.superview.frame.size.width-self.frame.size.width-paddingX;
}

//设置阴影
-(void)viewShadow:(float)opacityValue colorInfo:(UIColor *)colorInfo radiusValue:(CGFloat)radiusValue{
    
    self.layer.shadowOpacity = opacityValue;// 阴影透明度
    
    self.layer.shadowColor = colorInfo.CGColor;// 阴影的颜色
    
    self.layer.shadowRadius = radiusValue;// 阴影扩散的范围控制
    
    self.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    
}

@end
