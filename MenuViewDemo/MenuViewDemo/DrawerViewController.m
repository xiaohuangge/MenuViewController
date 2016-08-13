//
//  DrawerViewController.m
//  MenuViewDemo
//
//  Created by 黄启山 on 16/8/11.
//  Copyright © 2016年 黄启山. All rights reserved.
//

#import "DrawerViewController.h"
#import "MainViewController.h"
#import "MenuViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    mainVC.baseDrawer = self;
    UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:mainVC];
    mainVC.view.frame = self.view.frame;
    [self.mainView addSubview:navc.view];
    [self addChildViewController:navc];

    MenuViewController *menuVC = [[MenuViewController alloc]init];
    menuVC.view.frame = self.view.frame;
    menuVC.view.backgroundColor = [UIColor purpleColor];
    [self.menuView addSubview:menuVC.view];
    [self addChildViewController:menuVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
