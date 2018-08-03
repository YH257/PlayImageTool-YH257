//
//  XDNavigationCtrl.m
//  PlayImageTool
//
//  Created by fdinc01 on 2018/8/3.
//  Copyright © 2018年 fdinc01. All rights reserved.
//

#import "XDNavigationCtrl.h"
#import "RequestUrlCommon.h"

@interface XDNavigationCtrl ()

@end

@implementation XDNavigationCtrl

#pragma mark - 懒加载设置导航栏文字颜色
+(void)initialize {
    [super initialize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(WeakSelf);
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = WeakSelf;
        self.delegate = WeakSelf;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

    // 解决左滑返回失效并卡住的问题
    if (viewController == self.childViewControllers[0]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
