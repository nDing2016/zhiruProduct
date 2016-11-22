//
//  ZRStorupGroupController.m
//  zhiruProduct
//
//  Created by pj on 16/7/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStorupGroupController.h"
#import "ZRGroupBuyingCell.h"
#import "ZRUserStoreupRequest.h"
#import "ZRGroupModel.h"
@interface ZRStorupGroupController ()


@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isUpLoading;
@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation ZRStorupGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
//    [self addHeaderRefresh];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"storeupGroup";
    ZRGroupBuyingCell *ordeingCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (ordeingCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZRGroupBuyingCell class]) owner:self options:nil];
        ordeingCell = [nibs lastObject];
    }
    
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
    [ZRUserStoreupRequest groupCollectionWithRows:@"6" Page:pageStr GroupCollectionCallBack:^(NSMutableArray * array, NSString * message) {
        //NSLog(@"团购: %ld %@", (unsigned long)array.count, array);
        if ([message isEqualToString:@"success"]) {
            if (self.isUpLoading == YES) {
                [self.dataArray removeAllObjects];
            }
            for (ZRGroupModel * model in array) {
                [self.dataArray addObject:model];
            }
        } else {
            //NSLog(@"团购: %@", message);
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
        ZRGroupModel * model = [self.dataArray objectAtIndex:indexPath.row];
        NSString * groupId = model.groupId;
        NSString * businessId = model.businessId;
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [ZRUserStoreupRequest delGroupCollectionWithGroupId:groupId BusinessId:businessId CallBack:^(NSString *message) {
            //NSLog(@"++++%@", message);
            
        } Failure:^(id error) {
            //NSLog(@"++++%@", error);
            
        }];
    }
    [tableView reloadData];
}

//- (void)setGroupState:(BOOL)groupState
//{
//    if (groupState == YES) {
//        [self addHeaderRefresh];
//    }
//}
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
