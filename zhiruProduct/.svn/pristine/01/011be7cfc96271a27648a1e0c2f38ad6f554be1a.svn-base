//
//  ZRSetUpController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/10/31.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSetUpController.h"

@interface ZRSetUpController ()

@end

@implementation ZRSetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"敬请期待";
    [self createMainView];
}

- (void)createMainView{
    UIImage * backImg = [UIImage imageNamed:@"qingqidai"];
    UIImageView * backImView = [[UIImageView alloc] initWithImage:backImg];
    [self.view addSubview:backImView];
    
    WS(ws)
    [backImView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top);
        make.left.equalTo(ws.view.mas_left);
        make.right.equalTo(ws.view.mas_right);
        make.bottom.equalTo(ws.view.mas_bottom);
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
