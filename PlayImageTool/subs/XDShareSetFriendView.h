//
//  XDShareSetFriendView.h
//  PointRaceStone
//
//  Created by fdinc01 on 2018/6/11.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XDShareSetFriendButtonBlock)(NSInteger index);

@interface XDShareSetFriendView : UIView

@property (nonatomic, copy) XDShareSetFriendButtonBlock selectIndexBlock;

-(instancetype)initWithSelecetButtonBlock:(XDShareSetFriendButtonBlock)block;

-(void)showPopView;

-(void)hidePopView;


@end
