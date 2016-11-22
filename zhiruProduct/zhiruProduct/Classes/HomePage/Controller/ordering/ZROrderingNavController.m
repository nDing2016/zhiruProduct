//
//  ZROrderingNavController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingNavController.h"
#import "ZROrdeingCell.h"
#import "ZROrderingBusinessMsg.h"
#import "ZROrderingDetailsController.h"
#import "ZRHomePageRequst.h"
#import "ZRLabelModel.h"
@interface ZROrderingNavController ()
@property (nonatomic , strong) NSArray * cellData;
@end

@implementation ZROrderingNavController

-(void)setModel:(ZROrderingModel *)model{
    _model = model;
    _cellData = model.businessMsg;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"LookProductCell";
    ZROrdeingCell *ordeingCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (ordeingCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrdeingCell class]) owner:self options:nil];
        ordeingCell = [nibs lastObject];
    }
    ZROrderingBusinessMsg * model = _cellData[indexPath.row];
    ordeingCell.businessModel = model;
    return ordeingCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZROrderingDetailsController * detailsVC = [[ZROrderingDetailsController alloc] init];
    ZROrderingBusinessMsg * model = _cellData[indexPath.row];
    detailsVC.businessId = model.businessId;
    [self.navigationController  pushViewController:detailsVC animated:YES];
}

- (void)homeBaseViewControllerPostRequestWithDistance :(NSString *)distance andSort :(NSString*)sort andScreen :(NSString *)screen andLabel :(NSInteger)labelIndex{
    //点击筛选条件
    
    ZRLabelModel * label = _model.label[labelIndex];
    ZRUserAddress * address = [ZRUserAddress   sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestOrderingListQueryWithLongitude:address.Longitude andLatitude:address.Latitude andDistance:distance andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows] andPage:[NSString stringWithFormat:@"%d",1] andSuccess:^(id success) {
        NSArray * successArr = success;
        if (successArr.count>0) {
            _cellData = successArr;
        }
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        
    }];
}

@end
