//
//  ZRBeautyController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBeautyController.h"
#import "ZREntertainmentCell.h"
#import "ZRHomeCellTwo.h"
#import "ZRProductDetailsController.h"
#import "ZRLabelModel.h"
#import "ZRRegionModel.h"
#import "ZRHomePageRequst.h"
#import "ZRLookForTasteNavController.h"
@interface ZRBeautyController ()

@end

@implementation ZRBeautyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setModel:(ZRHomeNavModel *)model{
    _model = model;
    self.modelArr = model.businessMsg;
}

#pragma mark - 创建头视图
- (void)createHeadView{
    
    for (int i = 0; i < self.ScreeningDict.count; i++) {
        
        
        ZRScreeningView * screeningView = [[ZRScreeningView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 40)andTitleArr:self.ScreeningDict[self.queryArr[i]]];
        [self.view addSubview:screeningView];
        
        
        
        screeningView.screeningViewClick = ^(NSString * infoStr){
            //NSLog(@"%@",infoStr);
        };
        
        [self.screeningMarr addObject:screeningView];
    }
}
#pragma mark -- tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"entertainmentCell";
    ZRHomeCellTwo *entertainmentCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (entertainmentCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRHomeCellTwo class]) owner:self options:nil];
        entertainmentCell = [nibs lastObject];
    }
    entertainmentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    entertainmentCell.model = self.modelArr[indexPath.row];
    return entertainmentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZRProductDetailsController * detailVC = [[ZRProductDetailsController alloc] init];
    detailVC.isLiren = YES;
    ZRBusinessModel * model = self.modelArr[indexPath.row];
    detailVC.businessId = model.businessId;
    detailVC.title = model.name;
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
    ZRUserAddress * address = [ZRUserAddress sharedInstance];
    WS(ws)
    [ZRHomePageRequst requestGetFindtasteListWithLongitude:address.Longitude andLatitude:address.Latitude andRegionId:region.region_id andCity:@""  andLabel:label.nav_id andSort:sort andScreen:screen andRows:[NSString stringWithFormat:@"%d",ZRRows]  andPage:@"1" andSuccess:^(id success) {
        
        //NSLog(@"成功");
        ws.modelArr = success;
        
        [ws.myTableView reloadData];
    } andFailure:^(id error) {
        
        //NSLog(@"失败");
        
    }];
}


- (void)homeBaseViewControllerHeaderClickWithBtn: (NSInteger) index{
    NSArray * labelArr = self.model.label;
    ZRLabelModel * labelModel = labelArr[index + 1];
    
    WS(ws)
    [CustomHudView show];
    //跳转
    [ZRHomePageRequst requestGetFindtasteIndexWithLongitude:_longitude andLatitude:_latitude andLabel:labelModel.nav_id andSuccess:^(id success) {
        
        ZRHomeNavModel * model = ws.model;
        //地理
        NSMutableArray * regionMarr = [NSMutableArray array];
        for (ZRRegionModel * region in model.region) {
            if (region.region_name != nil) {
                [regionMarr addObject:region.region_name];
            }
            
        }
        //品类
        NSMutableArray * labelMarr = [NSMutableArray array];
        for (ZRLabelModel * label in model.label) {
            if (label.nav_name != nil) {
                [labelMarr addObject:label.nav_name];
            }
        }
        
        
        //        NSDictionary * screeningDict = [NSDictionary dictionaryGetScreeningWithModel:ws.model isPaixu:YES];
        NSDictionary * screeningDict = @{@"地理":regionMarr, @"品类":labelMarr , @"排序":@[@"智能排序,"@"离我最近",@"评价最好",@"设施最佳",@"环境最佳",@"服务最佳"],@"筛选":@[@"默认",@"优惠",@"营业中",@"新店"]};
        
        ZRLookForTasteNavController * navVC = [[ZRLookForTasteNavController alloc]  initWithTitleArr:nil andScreeningDict:screeningDict andQueryTitleArr:@[@"地理",@"品类",@"排序",@"筛选"] andTitleImgArr:nil];
        navVC.title = @"丽人";
        navVC.model = success[0];
        navVC.latitude = _latitude;
        navVC.longitude = _longitude;
        [ws.navigationController pushViewController:navVC animated:YES];
        [CustomHudView dismiss];
    } andFailure:^(id error) {
        
        
        [CustomHudView dismiss];
    }];
    
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
