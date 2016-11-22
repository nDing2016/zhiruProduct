//
//  ZRReviewDetailController.m
//  zhiruProduct
//
//  Created by nanding on 16/11/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRReviewDetailController.h"
#import "ZRCommentRequest.h"

@interface ZRReviewDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ZRReviewDetailController
#pragma mark - lifeCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView startRefreshWithCallback:^{
        
        [self loadDetails];
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - get methods
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource methods



#pragma mark - UITableViewDelegate methods




#pragma mark - 网络请求
- (void)loadDetails
{
    [ZRCommentRequest requestForBusinessCommentDetailsWithCommentId:self.commentIdStr CallBack:^(id details, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        if ([details[@"code"] isEqualToString:@"S000"]) {
            
            
            
        }else{
            
        }
        
    }];
}

#pragma mark - manage memory methods
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
