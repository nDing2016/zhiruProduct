//
//  ZRSupermarketExplainController.m
//  zhiruProduct
//
//  Created by nanding on 16/11/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketExplainController.h"

@interface ZRSupermarketExplainController ()

@end

@implementation ZRSupermarketExplainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:imgView];
    imgView.image = ZRImage(@"supermarket illustrate");
    // Do any additional setup after loading the view.
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
