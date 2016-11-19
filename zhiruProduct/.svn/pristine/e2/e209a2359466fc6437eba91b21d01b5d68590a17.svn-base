//
//  ZRStoreupOrderingController.m
//  zhiruProduct
//
//  Created by pj on 16/9/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStoreupOrderingController.h"
#import "ZROrdeingCell.h"
#import "ZRUserStoreupRequest.h"
@interface ZRStoreupOrderingController ()

@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isUpLoading;
@property (nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation ZRStoreupOrderingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    //NSLog(@"11111111111111111111");
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"cellID";
    ZROrdeingCell *ordeingCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (ordeingCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrdeingCell class]) owner:self options:nil];
        ordeingCell = [nibs lastObject];
    }
    ZROrderingBusinessMsg * model = _dataArray[indexPath.row];
    ordeingCell.businessModel = model;
    return ordeingCell;
}
- (void)addHeaderRefresh
{
    [self.tableView startRefreshWithCallback:^{
        self.page = 1;
        self.isUpLoading = YES;
        NSString * pageStr = [NSString stringWithFormat:@"%ld", (long)self.page];
        [self requestDataList:pageStr];
    }];
}
- (void)addFooterRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.page++;
        self.isUpLoading = NO;
        //NSLog(@"%ld", (long)self.page);
        NSString * pageStr = [NSString stringWithFormat:@"%ld", (long)self.page];
        [self requestDataList:pageStr];
    }];
}
- (void)requestDataList:(NSString *)pageStr
{
    [ZRUserStoreupRequest orderingCollectionWithRows:@"6" Page:pageStr OrderingCollectionCallBack:^(NSMutableArray * array, NSString * message) {
        if ([message isEqualToString:@"success"]) {
            if (self.isUpLoading == YES) {
                [self.dataArray removeAllObjects];
            }
            for (ZROrderingBusinessMsg * model in array) {
                [self.dataArray addObject:model];
            }
        } else {
            //NSLog(@"订餐 %@", message);
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } Failure:^(id error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
// tableView编辑
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZROrderingBusinessMsg * model = [self.dataArray objectAtIndex:indexPath.row];
        NSString * businessId = model.businessId;
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [ZRUserStoreupRequest delOrderingCollectionWithBusinessId:businessId CallBack:^(NSString *message) {
            
            //NSLog(@"___%@", message);
        } Failure:^(id error) {
            //NSLog(@"___%@", error);
        }];
    }
    [tableView reloadData];
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
