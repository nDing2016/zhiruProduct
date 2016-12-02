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
    UIImageView * mainView;
    switch (_type) {
        case 1://重量费说明
            mainView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weight illustrate"]];
            break;
            
        default:
            mainView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deliver illustrate"]];
            break;
    }
    
//     mainView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"deliver illustrate"]];
    mainView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [self.view addSubview:mainView];
    

    
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
