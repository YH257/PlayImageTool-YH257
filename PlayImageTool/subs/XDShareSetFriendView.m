//
//  XDShareSetFriendView.m
//  PointRaceStone
//
//  Created by fdinc01 on 2018/6/11.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import "XDShareSetFriendView.h"
#import "RequestUrlCommon.h"
#import "UIView+syCategory.h"

@interface XDShareSetFriendView(){
    UIView     * alertSheetView;
}

@property(nonatomic,strong)UIView *backView;

@end


@implementation XDShareSetFriendView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = SCREEN_BOUNDS;
    }
    return self;
}

-(instancetype)initWithSelecetButtonBlock:(XDShareSetFriendButtonBlock)block{
    self = [self init];
    if (self) {
        _selectIndexBlock = block;
        [self initContentViews];
    }
    return self;
}

-(void)initContentViews {
    
    self.backView = [[UIView alloc] initWithFrame:self.frame];
    self.backView.backgroundColor = RGB16withAlpha(0x000000, 0.5);
    self.backView.alpha = 0.0f;
    [self addSubview:self.backView];
    
    alertSheetView = [[UIView alloc] initWithFrame:CGRectMake(0,self.height - 130, self.width, 130)];
    [self addSubview:alertSheetView];
    alertSheetView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 2, 16)];
    lineView.backgroundColor = fMainColor;
    [alertSheetView addSubview:lineView];
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(27, 15, 100, 16)];
    titleLab.text = @"分享";
    titleLab.textColor = fFontMainShallowColor;
    titleLab.font = UIFont_size(15);
    [alertSheetView addSubview:titleLab];
    
    
    NSArray *titleArr = @[@"微信好友",@"朋友圈",@"微博",@"QQ",@"QQ空间"];
    NSArray *imgArr = @[@"ic_share_wechat",@"ic_share_moments",@"ic_share_sina",@"ic_share_qq",@"ic_share_qqzone"];
    CGFloat width = (screen_With - 20)/5;
    CGFloat higth = 75;
    CGFloat img_hight = 35;
    CGFloat padd = (width - img_hight)/2;
    
    for (int i = 0; i<5; i++) {
        UIButton *resetbtn=[[UIButton alloc]initWithFrame:CGRectMake(10 + width*i, 35, width, higth)];
        resetbtn.backgroundColor = [UIColor whiteColor];
        resetbtn.tag = i;
        [resetbtn addTarget:self action:@selector(didSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake( padd, 15, img_hight, img_hight)];
        headImg.image = UIImageNameStr(imgArr[i]);
        headImg.userInteractionEnabled = YES;
        headImg.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        [headImg addGestureRecognizer:tap];
        
        [resetbtn addSubview:headImg];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, higth - 20, width, 20)];
        titleLab.text = titleArr[i];
        titleLab.textColor = fFontMainShallowColor;
        titleLab.font = UIFont_size(14);
        titleLab.textAlignment = NSTextAlignmentCenter;
        [resetbtn addSubview:titleLab];
        [alertSheetView addSubview:resetbtn];
    }

}


- (void)tap:(UITapGestureRecognizer*)gesture{
    UIImageView *img = (UIImageView *)[gesture view];
    if (self.selectIndexBlock) {
        self.selectIndexBlock(img.tag);
    }
    [self hidePopView];
}

-(void)didSelectAction:(UIButton *)btn {
    if (self.selectIndexBlock) {
        self.selectIndexBlock(btn.tag);
    }
    [self hidePopView];
}


-(void)showPopView{
    WS(weakSelf);
    [UIView animateWithDuration:0.1f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        [LQKeyWindow addSubview:weakSelf];
        weakSelf.backView.alpha = 1.0;
    } completion:NULL];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.backView];
    if (!CGRectContainsPoint([alertSheetView frame], point)) {
        [self hidePopView];
    }
}

-(void)hidePopView{
    WS(weakSelf);
    [UIView animateWithDuration:0.0f delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionLayoutSubviews animations:^{
        weakSelf.backView.alpha = 0.0;
        weakSelf.frame = CGRectMake(0, CGRectGetHeight(weakSelf.frame), CGRectGetWidth(weakSelf.frame), weakSelf.height);
        
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
}




@end
