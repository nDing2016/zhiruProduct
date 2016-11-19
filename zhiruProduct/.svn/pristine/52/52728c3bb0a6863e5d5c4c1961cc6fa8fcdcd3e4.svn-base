//
//  ZRErrorController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRErrorController.h"
#import "ZRMyLocation.h"
@interface ZRErrorController ()
@property (nonatomic , strong) UIButton * btn;
@end

@implementation ZRErrorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView ];
}

- (void)createView{
    
    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"internet problem"]];
    
    [self.view addSubview:img];
    
    WS(ws)
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (ws.view.mas_centerX);
        make.top.equalTo(ws.view.mas_top).offset(80);
    }];
    
    
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:@"点击重试" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    _btn = btn;
    
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img.mas_centerX);
        make.top.equalTo(img.mas_bottom).offset(130);
    }];
}

- (void)btnclick {
    [CustomHudView show];
    
    [[ZRMyLocation shareInstance] getMylocation];
    
    [self dismissViewControllerAnimated:YES completion:^{

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
