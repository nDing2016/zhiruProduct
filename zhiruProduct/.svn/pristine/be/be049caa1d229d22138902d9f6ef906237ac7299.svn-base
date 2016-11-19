//
//  ZREntertainmentController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZREntertainmentController.h"
#import "ZREntertainmentCell.h"


@interface ZREntertainmentController ()

@end

@implementation ZREntertainmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建头视图
- (void)createHeadView{
    
    for (int i = 0; i < self.ScreeningDict.count; i++) {
        
        
        ZRScreeningView * screeningView = [[ZRScreeningView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 40)andTitleArr:self.ScreeningDict[self.queryArr[i]]];
        [self.view addSubview:screeningView];
        
        
        
        screeningView.screeningViewClick = ^(NSString * infoStr){
            NSLog(@"%@",infoStr);
        };
        
        [self.screeningMarr addObject:screeningView];
    }
}
#pragma mark -- tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"entertainmentCell";
    ZREntertainmentCell *entertainmentCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (entertainmentCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZREntertainmentCell class]) owner:self options:nil];
        entertainmentCell = [nibs lastObject];
    }
    
    return entertainmentCell;
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
