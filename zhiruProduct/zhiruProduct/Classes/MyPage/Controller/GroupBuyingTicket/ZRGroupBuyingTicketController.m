//
//  ZRGroupBuyingTicketController.m
//  zhiruProduct
//
//  Created by pj on 16/8/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingTicketController.h"
#import "ZRGroupBuyingTicketCell.h"
@interface ZRGroupBuyingTicketController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)UIImageView * templateImage;

@end

@implementation ZRGroupBuyingTicketController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:_tableView];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        UIView * view = [UIView new];
        _tableView.tableFooterView = view;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的团购券"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
//    [self.tableView setDelegate:self];
//    [self.tableView setDataSource:self];
//    
//    [self createTemplateImage];
    [self createNoOpenImage];
}
- (void)createNoOpenImage
{
    UIImageView * image = [[UIImageView alloc] init];
    [image setImage:ZRImage(@"qingqidai")];
    [self.view addSubview:image];
    WS(weakSelf);
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(64);
        make.bottom.equalTo(weakSelf.view).with.offset(0);
    }];
}

- (void)createTemplateImage
{
    self.templateImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [self.templateImage setImage:[UIImage imageNamed:@"zu-3"]];
    [self.templateImage setUserInteractionEnabled:YES];
    [self.view addSubview:self.templateImage];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction:)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [self.templateImage addGestureRecognizer:tap];
}
- (void)imageAction:(UITapGestureRecognizer *)sender
{
    [self.templateImage setHidden:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"groupBuyingTicket";
    ZRGroupBuyingTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZRGroupBuyingTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.backgroundColor = [UIColor blackColor];
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
