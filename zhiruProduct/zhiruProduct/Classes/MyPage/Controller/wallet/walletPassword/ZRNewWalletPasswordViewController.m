//
//  ZRNewWalletPasswordViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNewWalletPasswordViewController.h"

@interface ZRNewWalletPasswordViewController ()

@end

@implementation ZRNewWalletPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置密码"];
    //NSLog(@"钱包新密码");
    [self.button addTarget:self action:@selector(actionButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)actionButton
{
    UIViewController * vc = [self.navigationController.viewControllers objectAtIndex:1];
    [self.navigationController popToViewController:vc animated:YES];
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
