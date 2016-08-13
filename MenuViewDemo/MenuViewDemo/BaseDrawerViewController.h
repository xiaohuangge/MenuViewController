//
//  BaseDrawerViewController.h
//  MenuViewDemo
//
//  Created by 黄启山 on 16/8/11.
//  Copyright © 2016年 黄启山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseDrawerViewController : UIViewController

// 左侧菜单
@property (nonatomic, strong) UIView *menuView;

// 主窗口页面
@property (nonatomic, strong) UIView *mainView;


@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@property(nonatomic,strong)UITapGestureRecognizer *tap;

- (void)menuViewShow;

- (void)menuViewHidden;

- (void)tapMenu;

- (void)panMenu;

@end
