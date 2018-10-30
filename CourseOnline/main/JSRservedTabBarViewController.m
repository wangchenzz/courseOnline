//
//  JSRservedTabBarViewController.m
//  CourseReservation
//
//  Created by Mac on 17/6/16.
//  Copyright © 2017年 Zz. All rights reserved.
//

#import "JSRservedTabBarViewController.h"

#import "JSEDefine.h"

#import "UIImage+Render.h"

#import "MainPageControlViewController.h"

#import "CourseDesignBasicViewController.h"

#import "UserInfoBasicViewController.h"

@interface JSRservedTabBarViewController ()

@end

@implementation JSRservedTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //tabbar 主题；
    
    //设置tabbar item 的颜色；
    self.tabBar.barTintColor = [UIColor colorWithWhite:1 alpha:1];
    
    
    //设置普通状态下的tabbaritem字体；
    //tintcolor 即是字体选中颜色；未设置情况下。
    self.tabBar.tintColor = JSColor(0, 177, 73, 1);
    
    
    //首页.
    MainPageControlViewController *course = [[MainPageControlViewController alloc] init];
    [self addJSChildViewController:course withNormalImage:@"1" selectImage:@"1" title:@"精品课"];

    
    CourseDesignBasicViewController *design = [[CourseDesignBasicViewController alloc] init];
    [self addJSChildViewController:design withNormalImage:@"2" selectImage:@"2" title:@"我的学习"];
    
    UserInfoBasicViewController *userInfo = [[UserInfoBasicViewController alloc] init];
    [self addJSChildViewController:userInfo withNormalImage:@"3" selectImage:@"3" title:@"我"];
    /*
     for (UITabBarItem *item in self.tabBar.items) {
     item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     }
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  添加试图控制器
 *
 *  @param childController 创建好的试图控制器
 */

-(void)addJSChildViewController:(UIViewController *)childController withNormalImage:(NSString *)nname selectImage:(NSString *)sname title:(NSString *)title{
    
    childController.title = title;
    
    NSMutableDictionary *normalAttri = [NSMutableDictionary dictionary];
    
    normalAttri[NSFontAttributeName] = JSFont(12);
    
    normalAttri[NSForegroundColorAttributeName] = JSColor(155, 155, 155, 1);
    
    //设置选中状态下的tabbaritem的字体；
    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
    
    selectAttri[NSFontAttributeName] = JSFont(12);
    
    selectAttri[NSForegroundColorAttributeName] = JSColor(0, 177, 73, 1);
    
    
    //此处预留的设置选中和普通状态的图片
    
    childController.tabBarItem.image = [[UIImage imageNamed:nname] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childController.tabBarItem.selectedImage = [UIImage imageNamed:sname];
    
    //设置tabbar 的item的字体。
    
    [[UITabBarItem appearance] setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:normalAttri forState:UIControlStateNormal];
    
    /**
     *  导航栏主题
     */
    
    //设置导航栏title 字体颜色；
    NSMutableDictionary *navigationTitle = [NSMutableDictionary dictionary];
    navigationTitle[NSFontAttributeName] = JSFont(23);
    navigationTitle[NSForegroundColorAttributeName] = [UIColor blackColor];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:childController];
    [navi.navigationBar setTitleTextAttributes:navigationTitle];
    
    /**
     *  导航栏返回键颜色
     */
    
    [navi.navigationBar setTintColor:[UIColor blackColor]];
    
    //设置导航栏 主体颜色；
    [navi.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    //修改状态栏主题
    [navi.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    
#pragma mark - 这是这次邢增的
    
    UIImage *image = [UIImage imageNamed:@"bj"];
    
    UIImage *scaleImage = [image scaleSize:CGSizeMake(navi.navigationBar.frame.size.width, navi.navigationBar.frame.size.height + JSStatusRect.size.height)];
    
    [navi.navigationBar setBackgroundImage:scaleImage forBarMetrics:UIBarMetricsDefault];
    //去掉底部线条
    [navi.navigationBar setShadowImage:[[UIImage alloc] init]];

    [self addChildViewController:navi];
    /*
     
     */
    
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
