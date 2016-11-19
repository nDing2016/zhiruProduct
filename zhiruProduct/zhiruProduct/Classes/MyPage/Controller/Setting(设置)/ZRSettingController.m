//
//  ZRSettingController.m
//  zhiruProduct
//
//  Created by pj on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSettingController.h"
#import "ZRSettingCell.h"
#import "ZRSettingMessageCell.h"
#import "ZRWeController.h"
@interface ZRSettingController ()<UITableViewDelegate, UITableViewDataSource, switchDelegate>

@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic, strong)UITableView * tableView;
@end

@implementation ZRSettingController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"清除缓存",@"消息推送",@"关于我们", nil];
    }
    return _dataArray;
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
    [self setTitle:@"设置"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString * cellID = @"settingMessage";
        ZRSettingMessageCell * cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell1 == nil) {
            cell1 = [[ZRSettingMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell1.delegate = self;
        }
        [cell1.titleLabel setText:[self.dataArray objectAtIndex:indexPath.section]];
        return cell1;
    } else {
        static NSString * cellID = @"setting";
        ZRSettingCell * cell2 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell2 == nil) {
            cell2 = [[ZRSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell2.titleLabel setText:[self.dataArray objectAtIndex:indexPath.section]];
        return cell2;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache] clearDisk];
            [AlertText showAndText:@"清除成功"];
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    } else if (indexPath.section == 2) {
        ZRWeController * weVC = [[ZRWeController alloc] init];
        [self.navigationController pushViewController:weVC animated:YES];
    }
}
- (void)setSwitch:(UISwitch *)sender
{
    NSString * str;
    if (sender.isOn == YES) {
        //NSLog(@"开");
        str = @"1";
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
//          [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        //NSLog(@"关");
        str = @"0";
          [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushValue" object:str];
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
