//
//  ZRProblemController.m
//  zhiruProduct
//
//  Created by pj on 16/9/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRProblemController.h"
#import "ZRProblemZeroView.h"
#import "ZRProblemOneView.h"
#import "ZRProblemTwoView.h"
#import "ZRProblemThreeView.h"
#import "ZRProblemFourView.h"
#import "ZRProblemFiveView.h"
@interface ZRProblemController ()

@end

@implementation ZRProblemController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"常见问题"];
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    
    
    if (self.problem == 0) {
        ZRProblemZeroView * view = [[ZRProblemZeroView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
    } else if (self.problem == 1) {
        ZRProblemOneView * view = [[ZRProblemOneView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
    } else if (self.problem == 2) {
        ZRProblemTwoView * view = [[ZRProblemTwoView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
    } else if (self.problem == 3) {
        ZRProblemThreeView * view = [[ZRProblemThreeView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
    } else if (self.problem == 4) {
        ZRProblemFourView * view = [[ZRProblemFourView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
    } else if (self.problem == 5) {
        ZRProblemFiveView * view = [[ZRProblemFiveView alloc] initWithFrame:CGRectMake(15, 64, ScreenWidth - 30, ScreenHeight)];
        [view setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:view];
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
