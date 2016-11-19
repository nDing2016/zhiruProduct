//
//  ZRGroupBuyingController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingController.h"
#import "ZRGroupBuyingCell.h"
#import "ZRMyWalletViewController.h"
#import "ZRHomePageRequst.h"
#import "ZRNavModel.h"
#import "ZRGropBuyingNavController.h"
#import "ZRRegionModel.h"
#import "ZRLabelModel.h"
#import "ZRGroupBuyingDetailsController.h"

@interface ZRGroupBuyingController ()<UITableViewDelegate ,UITableViewDataSource  >

@property (nonatomic , strong) NSArray * groupArr;
@end

@implementation ZRGroupBuyingController

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

- (void)homeBaseViewControllerHeaderClickWithBtn:(NSInteger)index{
    
    ZRNavModel * nav = self.model.nav[index];
    WS(ws)
    ZRUserAddress * userAdd = [[ZRUserAddress alloc] init];
    //发送请求
    [ZRHomePageRequst requestGetGroupWithNavId:nav.nav_id andLongitude:userAdd.Longitude andLatitude:userAdd.Latitude andSuccess:^(id success) {
        
        ZRHomeNavModel * model = success[0];
        _groupArr = model.groupList;
       NSDictionary * screeningDict = [NSDictionary dictionaryGetScreeningWithModel:model isPaixu:NO];
        //跳转
        ZRGropBuyingNavController * VC = [[ZRGropBuyingNavController alloc] initWithTitleArr:nil andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序"] andTitleImgArr:nil];
        VC.model = model;
        [ws.navigationController pushViewController:VC animated:YES];
        
        //获取数据
        
    } andFailure:^(id error) {
        
    }];
}

- (void)homeBaseViewControllerPostRequestWithDistance :(NSString *)distance andSort :(NSString*)sort andScreen :(NSString *)screen andLabel :(NSInteger)labelIndex{
    
    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];

    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sortStr ;
    switch (self.currentData3Index) {
        case 0:
            sortStr = @"9";
            break;
        case 1:
            sortStr = @"10";
            break;
        case 2:
            sortStr = @"11";
            break;
        default:
            break;
    }
     ZRUserAddress * userAdd = [[ZRUserAddress alloc] init];
    WS(ws)
    
    [ZRHomePageRequst requestGetGroupListWithLongitude:userAdd.Longitude andLatitude:userAdd.Latitude andRegionId:region.region_id andNavId:@"" andLabel:label.nav_id andSort:sortStr andRows:[NSString stringWithFormat:@"%d",ZRRows] andPage:@"1" andSuccess:^(id success) {
        
        _groupArr = success;
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        //NSLog(@"%@",error);
    }];
//    [ZRHomePageRequst requestGetFindtasteListWithLongitude:ZRLongitude andLatitude:ZRLatitude andRegionId:region.region_id andCity:@"" andNavId:@"" andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
//        
//        NSLog(@"成功");
//        ws.modelArr = success;
//        //        NSLog(@"%ld",ws.modelArr.count);
//        [ws.myTableView reloadData];
//    } andFailure:^(id error) {
//        
//        NSLog(@"失败");
//
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
