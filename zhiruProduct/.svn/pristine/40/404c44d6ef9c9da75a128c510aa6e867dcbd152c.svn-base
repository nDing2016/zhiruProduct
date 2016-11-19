//
//  ZRNavigationController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNavigationController.h"
#import "ZRTabBarViewController.h"


@interface ZRNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic , strong) id popDelegate;
@property (nonatomic , weak) ZRTabBarViewController * myTabBar;
@end

@implementation ZRNavigationController

+ (void)initialize{
    //获取当前导航条下 所有UIBarButtonItem
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTintColor:R_G_B_16(0x555555)];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
    [[UINavigationBar appearance] setBarTintColor:R_G_B_16(0xfafafa)];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           R_G_B_16(0x555555), NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    _popDelegate = self.interactivePopGestureRecognizer;
}


#pragma mark - 跳转

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //实现 滑动 跳转
    
    //是否是根控制器
    if (self.viewControllers.count != 0) {
        //非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark -- navigation代理方法
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {//根控制器
       
        ZRTabBarViewController * tabBarVC =  (ZRTabBarViewController *) [self getCurrentVC];
        _myTabBar = tabBarVC;
        //在 新的  视图即将显示的时候干掉 系统的 tabbar
        for (UIView* tabBarBtn in tabBarVC.tabBar.subviews) {
            if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [tabBarBtn removeFromSuperview];
            }
        }
    }
}

//视图  显示后设置 滑动代理
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(viewController == self.viewControllers[0]){ //根控制器
        
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{ //非根控制器
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
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
