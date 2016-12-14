//
//  ZRSelectAddressController.m
//  zhiruProduct
//
//  Created by pj on 16/10/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSelectAddressController.h"
#import "ZRSelectAddressCell.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUserAddressModel.h"
#import "ZRNewAddressViewController.h"
#import "ZRAddView.h"
@interface ZRSelectAddressController ()<UITableViewDelegate, UITableViewDataSource, ZRSelectAddressCellDelegate, newAddressDelegate>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSMutableArray * dataArray;

@property (nonatomic, strong)ZRUserAddressModel * containerModel;
@end

@implementation ZRSelectAddressController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 50) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBounces:NO];
        
        UIView * view = [UIView new];
        [_tableView setTableFooterView:view];
        ZRAddView * addFooter = [[ZRAddView alloc] initWithFrame:CGRectMake(0, _tableView.frame.origin.y + _tableView.frame.size.height, ScreenWidth, 50)];
        [addFooter setBackgroundColor:[UIColor whiteColor]];
        [addFooter.clearButton addTarget:self action:@selector(actionAddNewAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addFooter];
        
    }
    return _tableView;
}
- (void)actionAddNewAddress
{
    if (self.dataArray.count == 10) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"最多只能添加10条地址" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:ok];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        ZRNewAddressViewController * newAddressVC = [[ZRNewAddressViewController alloc] init];
        newAddressVC.delegates = self;
        [self.navigationController pushViewController:newAddressVC animated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:RGBCOLOR(240, 240, 240)];
    [self.view addSubview:self.tableView];
    [self setTitle:@"选择地址"];
    self.dataArray = [NSMutableArray array];
    [self createNavigationRightButton];
    [self getAddress];
}
- (void)getAddress
{
    [CustomHudView show];
    [ZRUserInterfaceModel getUserAddressCallBack:^(NSArray *result, NSString *isLoginStr, NSString *code) {
        [CustomHudView dismiss];
        [self.dataArray removeAllObjects];
        for (NSDictionary * dic in result) {
            ZRUserAddressModel * model = [ZRUserAddressModel userWithDict:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
- (void)createNavigationRightButton
{
    UIButton * rightBtn = [MyControl createButtonWithFrame:CGRectMake(0, 0, 50, 40) ImageName:nil Target:self Action:@selector(actionRightNavigationBtn) Title:@"确认"];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)actionRightNavigationBtn
{
    if (self.containerModel != nil) {
        [self.delegate getAddressModel:self.containerModel];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择一个地址" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    ZRSelectAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ZRSelectAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.delegate = self;
    cell.selectBtn.tag = indexPath.row;
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
// 选择地址
- (void)getSelectButtonState:(UIButton *)sender
{
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        ZRUserAddressModel * model = [self.dataArray objectAtIndex:i];
        if (i == sender.tag) {
            model.state = !sender.selected;
            if (model.state == YES) {
                self.containerModel = model;
            } else {
                self.containerModel = nil;
            }
        } else {
            model.state = NO;
        }
    }
    [self.tableView reloadData];
}
// 添加地址之后重新请求数据
- (void)newAddress
{
    [self getAddress];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
