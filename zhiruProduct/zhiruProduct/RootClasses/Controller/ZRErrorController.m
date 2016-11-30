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
/** 背景cover */
@property (nonatomic, strong) UIView *bgView;
@end

@implementation ZRErrorController



-(void)setIsMeiWang:(BOOL)isMeiWang{
    _isMeiWang = isMeiWang;
   
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    self.view.backgroundColor  = [UIColor whiteColor];
     [self createView ];
}

- (void)createView{
    
    UIButton * btn = [[UIButton alloc] init];
    
    if (_isMeiWang) {
        [btn setImage:[UIImage imageNamed:@"net weak"] forState:UIControlStateNormal];

    }else{
        [btn setImage:[UIImage imageNamed:@"internet problem"] forState:UIControlStateNormal];

    }
    
    
    
    
    [self.view addSubview:btn];
    
    WS(ws)
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (ws.view.mas_centerX);
        make.centerY.equalTo (ws.view.mas_centerY);
        make.width.equalTo(@250);
        make.height.equalTo(@250);
    }];
    
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    _btn = btn;

}

- (void)btnclick {
    
    if (_isMeiWang) {
        self.clickBtn();
    }else{
        [CustomHudView show];
        
        [[ZRMyLocation shareInstance] getMylocation];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }

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
