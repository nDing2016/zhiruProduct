//
//  ZRMessageController.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMessageController.h"
#import "ZRStringWithLabel.h"
#import "ZRMessageCell.h"
#import "ZRUserInterfaceModel.h"
#import "ZRMessageModel.h"
@interface ZRMessageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * array;

@property (nonatomic, strong)NSMutableArray * dataArray;
@end

@implementation ZRMessageController

- (NSArray *)array
{
    if (_array == nil) {
        _array = [NSArray arrayWithObjects:@"如果你无法简洁的表达你的想法, 那只能说明你还不够了解它",@"评论了你的点评: 如果你无法简洁的表达你的想法，那只说明你还不够了解它。如果你无法简洁的表达你的想法，那只说明你还不够了解它",@"赞了您的点评", nil];
    }
    return _array;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
        UIView * view = [UIView new];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self setTitle:@"消息"];
    self.dataArray = [NSMutableArray array];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80.0;
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self addHeader];
}
- (void)addHeader
{
    [self.tableView startRefreshWithCallback:^{
        [self getRequestDataList];
    }];
}
- (void)getRequestDataList
{
    [ZRUserInterfaceModel userMessageListCallBack:^(id result) {
        [self.dataArray removeAllObjects];
        self.dataArray = result;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } Failure:^(id error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat width = ScreenWidth - 80;
//    ZRMessageModel * model = [self.dataArray objectAtIndex:indexPath.row];
//    CGFloat height = [ZRStringWithLabel returanHeightWithText:model.content width:width font:[UIFont systemFontOfSize:13]];
//    return height + 45;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    ZRMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
// tableView编辑
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleDelete;
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//    }
//    [tableView reloadData];
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
