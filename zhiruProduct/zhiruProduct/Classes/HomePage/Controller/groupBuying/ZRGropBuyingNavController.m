//
//  ZRGropBuyingNavController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGropBuyingNavController.h"
#import "ZRGroupBuyingCell.h"
#import "ZRGroupBuyingDetailsController.h"

@interface ZRGropBuyingNavController ()

@property (nonatomic , strong) NSArray * groupArr;
@end

@implementation ZRGropBuyingNavController
- (void)setModel:(ZRHomeNavModel *)model {
    _model = model;
    
    _groupArr = model.groupList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _groupArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"GroupBuyingCell";
    ZRGroupBuyingCell *ordeingCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (ordeingCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRGroupBuyingCell class]) owner:self options:nil];
        ordeingCell = [nibs lastObject];
    }
    ordeingCell.model = _groupArr[indexPath.row];
    return ordeingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRGroupBuyingDetailsController * detailVC = [[ZRGroupBuyingDetailsController alloc] init];
    
    detailVC.isClickCell = YES;
    ZRGroupModel * model = _groupArr[indexPath.row];
    
    detailVC.groupId = model.groupId;
    detailVC.businessId = model.businessId;
    [self.navigationController pushViewController:detailVC animated:YES];
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
