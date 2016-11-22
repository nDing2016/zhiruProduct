//
//  ZRWeDetailController.m
//  zhiruProduct
//
//  Created by pj on 16/9/30.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRWeDetailController.h"

@interface ZRWeDetailController ()

@end

@implementation ZRWeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我们有话说"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    UIImage * image;
    if (ScreenWidth == 320) {
        image = [UIImage imageNamed:@"wetalk5s"];
    } else {
        image = [UIImage imageNamed:@"we"];
    }
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [scrollView setContentSize:CGSizeMake(ScreenWidth, image.size.height)];
    [self.view addSubview:scrollView];
    
    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollView.contentSize.height)];
    [scrollView addSubview:imgView];
    [imgView setImage:image];
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
