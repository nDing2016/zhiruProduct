//
//  ZRExplainViewController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRExplainViewController.h"

@interface ZRExplainViewController ()

@end

@implementation ZRExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMainView];
}


- (void)createMainView{
    
    UIImageView * mainView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deliver illustrate"]];
    [self.view addSubview:mainView];
    
    WS(ws)
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.bottom.equalTo(ws.view.mas_top);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
    }];
    
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
