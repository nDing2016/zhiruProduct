//
//  ZRLookForTasteController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLookForTasteController.h"
#import "ZRHomeCellTwo.h"
#import "ZRProductDetailsController.h"
#import "ZRBusinessModel.h"
#import "ZRLabelModel.h"
#import "ZRHomePageRequst.h"
#import "ZRLookForTasteNavController.h"

#import "ZRRegionModel.h"
#import "ZRLabelModel.h"

@interface ZRLookForTasteController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , assign) NSInteger page;
@end

@implementation ZRLookForTasteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    //下拉加载最新
    WS(ws)
    [self.myTableView startRefreshWithCallback:^{
        ws.page = 1;
        //网络请求
        [ws startRefresh];
    }];
    
}

-(void)setModel:(ZRHomeNavModel *)model{
    _model = model;
    self.modelArr = model.businessMsg;
}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * productCell = @"LookProductCell";
    ZRHomeCellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:productCell];
    
    if (cellTwo == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
        cellTwo = [nibs lastObject];
    }
    
    cellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cellTwo.model = self.modelArr[indexPath.row];
    return cellTwo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRProductDetailsController * detailVC = [[ZRProductDetailsController alloc] init];
    ZRBusinessModel * model = self.modelArr[indexPath.row];
    detailVC.businessId = model.businessId;
    detailVC.title = model.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击筛选条件工具条
- (void)screenToolClick{
    
    
    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];
    //NSLog(@"%@",region.region_name);
    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
    
   
    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
    
    if (self.currentData4Index == 2) {
        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
    }
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:_longitude andLatitude:_latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
        
        //NSLog(@"成功");
        ws.modelArr = success;

        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        //NSLog(@"失败");
        
    }];
}


- (void)homeBaseViewControllerHeaderClickWithBtn: (NSInteger) index{
    
    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];
    //NSLog(@"%@",region.region_name);
    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
    
    
    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
    
    if (self.currentData4Index == 2) {
        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
    }
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:_longitude andLatitude:_latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
        
        //NSLog(@"成功");
        ws.modelArr = success;
        
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        //NSLog(@"失败");
        
    }];

    
  
    
}






- (void)startRefresh{

    //地域
    NSArray * regionArr = _model.region;
    ZRRegionModel * region = regionArr[self.currentData1Index];
    //NSLog(@"%@",region.region_name);
    //标签
    NSArray * labelArr = _model.label;
    ZRLabelModel * label = labelArr[self.currentData2Index];
    
    NSString * sort = [NSString stringWithFormat:@"%ld",self.currentData3Index + 1];
    
    
    NSString * screen = [NSString stringWithFormat:@"%ld",(long)self.currentData4Index ];
    
    if (self.currentData4Index == 2) {
        screen = [NSString stringWithFormat:@"%ld",self.currentData4Index + 1];
    }
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:_longitude andLatitude:_latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:[NSString stringWithFormat:@"%ld",_page ] andSuccess:^(id success) {
        
        //NSLog(@"成功");
        [ws.myTableView.mj_header endRefreshing];
        _page ++;
        
        ws.modelArr = success;
        
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
         [ws.myTableView.mj_header endRefreshing];
        //NSLog(@"失败");
        
    }];
    
}
//lr dk dz zs
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
