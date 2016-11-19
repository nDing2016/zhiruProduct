//
//  ZRHometownViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHometownViewController.h"

@interface ZRHometownViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSDictionary * data;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSArray * headerArray;
@end

@implementation ZRHometownViewController

- (NSArray *)headerArray
{
    if (_headerArray == nil) {
        _headerArray = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
    }
    return _headerArray;
}

- (NSDictionary *)data
{
    if (_data == nil) {
        NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"letterProvince.plist" ofType:nil];
        _data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return _data;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择家乡"];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self createNavigationLeftButton];
}
- (void)createNavigationLeftButton
{
    UIImage * image = [UIImage imageNamed:@"zuojiantou"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(actionLeftButton)];
}
- (void)actionLeftButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.allKeys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * headerStr = [self.headerArray objectAtIndex:section];
    NSArray * dataArray = [self.data objectForKey:headerStr];
    return dataArray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.headerArray objectAtIndex:section];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.headerArray;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    [tableView
//     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:index]
//     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString * headerStr = [self.headerArray objectAtIndex:indexPath.section];
    NSArray * dataArray = [self.data objectForKey:headerStr];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.textLabel setText:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * headerStr = [self.headerArray objectAtIndex:indexPath.section];
    NSArray * dataArray = [self.data objectForKey:headerStr];
    NSString * hometown = [dataArray objectAtIndex:indexPath.row];
    [self.delegate sendHometownString:hometown];
    [self dismissViewControllerAnimated:YES completion:nil];
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
