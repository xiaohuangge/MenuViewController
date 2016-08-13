//
//  BaseDrawerViewController.m
//  MenuViewDemo
//
//  Created by 黄启山 on 16/8/11.
//  Copyright © 2016年 黄启山. All rights reserved.
//

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height


#import "BaseDrawerViewController.h"

@interface BaseDrawerViewController ()<UIGestureRecognizerDelegate>
@end

@implementation BaseDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildView];
    
    [self setupGestureRecognizer];
}

- (void)setupGestureRecognizer {
    
    // 创建pan手势
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMenu)];
    // 添加pan手势
    [self.mainView addGestureRecognizer:self.pan];
    
    // 创建tap手势
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu)];
    self.tap.delegate = self;
}


- (void)setupChildView{
    
    // 添加菜单栏
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(-ScreenW * 0.3, 0, ScreenW * 0.8, ScreenH)];
    self.menuView = menuView;
    [self.view addSubview:menuView];
    
    // 添加主窗口
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView = mainView;
    [self.view addSubview:mainView];
    
}

- (void)menuViewShow {
    NSLog(@"menuViewShow");
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        self.menuView.frame = CGRectMake(0, 0, ScreenW * 0.8, ScreenH);
        self.mainView.frame = CGRectMake(ScreenW * 0.8, 0, ScreenW, ScreenH);
        
        //_mainView.userInteractionEnabled = NO;
        [weakSelf.mainView addGestureRecognizer:weakSelf.tap];
        [weakSelf.mainView endEditing:YES];//当左边菜单栏出现的时候,把右边的点击禁掉
    }];
}

- (void)menuViewHidden {
    
    NSLog(@"menuViewHidden");
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        self.menuView.frame = CGRectMake(-ScreenW * 0.5, 0, ScreenW * 0.8, ScreenH);
        self.mainView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        
        //_mainView.userInteractionEnabled = YES;
        [weakSelf.mainView removeGestureRecognizer:weakSelf.tap];
    }];
}

#pragma mark -手势方法
- (void)panMenu{
    
    // 获取手势移动的位置
    CGPoint translation = [self.pan translationInView:self.mainView];
    
    // 获取x轴上的偏移量
    CGFloat offsetX = translation.x;
    
    // 禁止左滑
    if(_mainView.frame.origin.x <= 0 && offsetX < 0) {
        return;
    }
    
    // 如果mainView已经滑动到右边的制定位置了, 就禁止右滑
    if(_mainView.frame.origin.x > ScreenW * 0.8 && offsetX > 0) {//超过0.8,就固定
        self.menuView.frame = CGRectMake(0, 0, ScreenW * 0.8, ScreenH);
        self.mainView.frame = CGRectMake(ScreenW * 0.8, 0, ScreenW, ScreenH);
    }
//    if(_menuView.frame.origin.x > 0) {
//        return;
//    }
    
    // mainView 进行偏移, 偏移距离为: offsetX
    
    _menuView.frame = [self menuViewFrameWithOffsetX:offsetX];
    _mainView.frame = [self mainViewFrameWithOffsetX:offsetX];
    
    // 复原
    [self.pan setTranslation:CGPointZero inView:self.mainView];
    
    // 当手势结束的时候,定位
    if(self.pan.state == UIGestureRecognizerStateEnded){
        if(_mainView.frame.origin.x > ScreenW * 0.4){
            // 定位到右边
            [self menuViewShow];
        }else{
            [self menuViewHidden];
        }
    }
    NSLog(@"%.2f--%.2f",offsetX,_mainView.frame.origin.x);
}

#pragma mark - 根据迁移量计算mainView.frame
- (CGRect)mainViewFrameWithOffsetX:(CGFloat)offsetX{
    // 获取上一次的frame
    CGRect perframe = _mainView.frame;
    // 跟新frame
    perframe.origin.x += offsetX;
    return perframe;
}
- (CGRect)menuViewFrameWithOffsetX:(CGFloat)offsetX{
    // 获取上一次的frame
    CGRect perframe = _menuView.frame;
    // 跟新frame
    perframe.origin.x += offsetX * 0.5;
    return perframe;
}


- (void)tapMenu{
    [self menuViewHidden];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self.mainView];
    if(point.x < ScreenW * 0.2) {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
