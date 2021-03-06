//
//  ZRUserInformationViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserInformationViewController.h"
#import "ZRHeadImageTableViewCell.h"
#import "ZRUserContentTableViewCell.h"
#import "ZRNameViewController.h"
#import "ZRAddressViewController.h"
#import "ZRHometownViewController.h"
#import "ZRNavigationController.h"
#import "ZRAlterPhoneViewController.h"
#import "ZRSettingPasswordViewController.h"
#import "PJDatePicker.h"
#import "ZRUserTool.h"
#import "ZRUser.h"
#import "ZRUserInterfaceModel.h"
#import "ZRUpdatePasswordController.h"
#import "ZRBecomeVipController.h"
@interface ZRUserInformationViewController ()<UITableViewDelegate, UITableViewDataSource, datePickerDelegate, sendNameDelegate, sendHometownDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong)UITableView * tableView;

@property (nonatomic, strong)NSArray * titleArray;
@property (nonatomic, strong)NSMutableArray * contentArray;

@property (nonatomic, strong)PJDatePicker * datePicker;

@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * gender;
@property (nonatomic, copy)NSString * birthday;
@property (nonatomic, copy)NSString * hometown;
@property (nonatomic, copy)NSString * address;

@property (nonatomic, strong)UIImage * headerImage;

@property (nonatomic, assign)NSInteger state;

@end

@implementation ZRUserInformationViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 400.0 / 667.0 * ScreenHeight) style:UITableViewStylePlain];
        [_tableView setScrollEnabled:NO];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSArray arrayWithObjects:@"昵称",@"性别",@"生日",@"家乡",@"绑定手机号",@"收货地址",@"会员身份",@"修改密码", nil];
    }
    return _titleArray;
}
- (NSMutableArray *)contentArray
{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray arrayWithObjects:@"设置",@"设置",@"设置生日",@"设置",@"设置",@"修改/添加",@"成为VIP享特权",@"修改", nil];
    }
    return _contentArray;
}
- (PJDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[PJDatePicker alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        [self.view addSubview:_datePicker];
        [_datePicker setHidden:YES];
    }
    return _datePicker;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"个人信息"];
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);
    
    /*
     birthday = "<null>";
     "failure_time" = 604800;
     gender = 0;
     "head_url" = "http://192.168.2.7:8181/img/touxiang.jpg";
     hometown = "<null>";
     "is_vip" = 0;
     name = 114;
     password = 5fd0b37cd7dbbb00f97ba6ce92bf5add;
     phone = 114;
     token = d4eb33dc29da86386b8d02d5d103a987;
     "user_id" = fff1dc931ae743038246e5603136e7c0;
     */
    

    ZRUser * user = [ZRUserTool user];
    
    if (![user.name isEqualToString:user.phone]) {
        self.contentArray[0] = user.name;
    }
    if ([user.gender isEqualToString:@"0"]) {
        self.contentArray[1] = @"男";
    } else if ([user.gender isEqualToString:@"1"]) {
        self.contentArray[1] = @"女";
    }
    if (user.birthday != nil) {
        self.contentArray[2] = user.birthday;
    }
    if (user.hometown != nil) {
        self.contentArray[3] = user.hometown;
    }
    
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self createRightNavigationButton];
    
    UIButton * exitLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:exitLoginButton];
    WS(weakSelf);
    [exitLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).with.offset(40);
        make.right.equalTo(weakSelf.view).with.offset(-40);
        make.top.equalTo(weakSelf.tableView.mas_bottom).with.offset(25);
        make.height.mas_equalTo(40);
    }];
    [exitLoginButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [exitLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    exitLoginButton.backgroundColor = RGBCOLOR(255, 82, 82);
    exitLoginButton.layer.masksToBounds = YES;
    exitLoginButton.layer.cornerRadius = 5;
    [exitLoginButton addTarget:self action:@selector(actionExitButton) forControlEvents:UIControlEventTouchUpInside];
    self.datePicker.delegate = self;
}
- (void)createRightNavigationButton
{
    UIButton * rightButton = [MyControl createButtonWithFrame:CGRectMake(0, 0, 40, 40) ImageName:nil Target:self Action:@selector(actionSubmitButton) Title:@"提交"];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightButton setTitleColor:RGBCOLOR(255, 82, 82) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
// 提交
- (void)actionSubmitButton
{
    if (self.state == 0) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您未修改任何信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    } else {
        NSString * name = self.name;
        NSString * gender;
        if ([self.gender isEqualToString:@"男"]) {
            gender = @"0";
        } else if ([self.gender isEqualToString:@"女"]) {
            gender = @"1";
        }
        NSString * birthday = self.birthday;
        NSString * hometown = self.hometown;
        NSMutableArray * imgArray = [NSMutableArray array];
        if (self.headerImage != nil) {
            NSData * data = UIImageJPEGRepresentation(self.headerImage, 0.1);
            NSInteger i = 0;
            NSDictionary * dic = @{@"fileName":[NSString stringWithFormat:@"fileImg%ld",(long)i],@"imageData":data};
            [imgArray addObject:dic];
        }
        [ZRUserInterfaceModel updateUserInfoWithName:name Gender:gender Birthday:birthday HomeTown:hometown File:imgArray CallBack:^(NSString *message, NSDictionary *userData) {
            
            if ([message isEqualToString:@"用户信息修改成功"]) {
                ZRUser * before = [ZRUserTool user];
                
                ZRUser * user = [ZRUser userWithDict:userData];
                user.token = before.token;
                user.failure_time = before.failure_time;
                user.expires_date = before.expires_date;
                BOOL state =  [ZRUserTool saveAccount:user];
                if (state == YES) {
                    [self.delegate submitUserInfo];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else {
                [AlertText showAndText:@"用户信息修改失败"];
            }
        } Failure:^(id error) {
            [AlertText showAndText:@"修改失败"];
        }];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80.0 / 667.0 * ScreenHeight;
    } else {
        return 40.0 / 667.0 * ScreenHeight;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * headCellID = @"headImage";
    static NSString * contentCellID = @"content";
    if (indexPath.row == 0) {
        ZRHeadImageTableViewCell * headCell = [tableView dequeueReusableCellWithIdentifier:headCellID];
        if (headCell == nil) {
            headCell = [[ZRHeadImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCellID];
        }
        [headCell.headImage setImage:self.image];
        return headCell;
    } else {
        ZRUserContentTableViewCell * contentCell = [tableView dequeueReusableCellWithIdentifier:contentCellID];
        if (contentCell == nil) {
            contentCell = [[ZRUserContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellID];
        }
        [contentCell.titleLabel setText:[_titleArray objectAtIndex:indexPath.row - 1]];
        [contentCell.contentLabel setText:[self.contentArray objectAtIndex:indexPath.row - 1]];
        return contentCell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) { // 头像
        UIAlertController * alertSheetVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * actionPhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self setImageWithCamera];
            //NSLog(@"拍照");
        }];
        UIAlertAction * actionCamera = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"从手机相册选择");
            [self setImageWithPhotoLibrary];
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"取消");
        }];
        [alertSheetVC addAction:actionPhoto];
        [alertSheetVC addAction:actionCamera];
        [alertSheetVC addAction:cancel];
        
        [self presentViewController:alertSheetVC animated:YES completion:^{
            
            
        }];

    } else if (indexPath.row == 1) { // 昵称
        ZRNameViewController * nameVC = [[ZRNameViewController alloc] init];
        nameVC.delegate = self;
        if (![self.contentArray[0] isEqualToString:@"设置"]) {
            nameVC.name = self.contentArray[0];
        }
        [self.navigationController pushViewController:nameVC animated:YES];
    } else if (indexPath.row == 2) { // 性别
        UIAlertController * sexActionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [sexActionSheet addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.state = 1;
            self.gender = @"男";
            self.contentArray[1] = self.gender;
            [self.tableView reloadData];
        }]];
        [sexActionSheet addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.state = 1;
            self.gender = @"女";
            self.contentArray[1] = self.gender;
            [self.tableView reloadData];
        }]];
        [sexActionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"取消");
        }]];
        [self presentViewController:sexActionSheet animated:YES completion:nil];
    } else if (indexPath.row == 3) { // 生日
        [self.datePicker setHidden:NO];
        NSDateFormatter * formatter_maxDate = [[NSDateFormatter alloc] init];
        [formatter_maxDate setDateFormat:@"yyyy-MM-dd"];
        NSDate * toDay = [NSDate date];
        NSString *minDateString = @"1900-01-01";
        NSString *maxDateString =  [formatter_maxDate stringFromDate:toDay];
        [self.datePicker setMinDateStr:minDateString MaxDateStr:maxDateString];
    } else if (indexPath.row == 4) { // 家乡
        ZRHometownViewController * hometownVC = [[ZRHometownViewController alloc] init];
        hometownVC.delegate = self;
        ZRNavigationController * hometownVCNav = [[ZRNavigationController alloc] initWithRootViewController:hometownVC];
        [self presentViewController:hometownVCNav animated:YES completion:nil];
    } else if (indexPath.row == 5) { // 绑定手机号
        ZRAlterPhoneViewController * alterPhoneVC = [[ZRAlterPhoneViewController alloc] init];
        [self.navigationController pushViewController:alterPhoneVC animated:YES];
    } else if (indexPath.row == 6) { // 收货地址
        ZRAddressViewController * addressVC = [[ZRAddressViewController alloc] init];
        [self.navigationController pushViewController:addressVC animated:YES];
    } else if (indexPath.row == 7) { // 会员身份
        ZRBecomeVipController * vipVC = [[ZRBecomeVipController alloc] init];
        [self.navigationController pushViewController:vipVC animated:YES];
    } else if (indexPath.row == 8) { // 设置密码
        ZRUpdatePasswordController * updatePswVC = [[ZRUpdatePasswordController alloc] init];
        [self.navigationController pushViewController:updatePswVC animated:YES];
    }
}
- (void)setImageWithPhotoLibrary
{
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}
- (void)setImageWithCamera
{
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = YES;
    //设置相册呈现的样式
    pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate = self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.state = 1;
    self.headerImage = resultImage;
    self.image = resultImage;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
// 点击DatePicker的确定
- (void)datePickerString:(NSString *)string
{
    self.state = 1;
    self.birthday = string;
    self.contentArray[2] = self.birthday;
    [self.datePicker setHidden:YES];
    [self.tableView reloadData];
}
// 点击DatePicker的取消或者点击半透明View
- (void)datePikcerViewState
{
    [self.datePicker setHidden:YES];
}
// 姓名
- (void)sendNameString:(NSString *)name
{
    self.state = 1;
    self.name = name;
    self.contentArray[0] = self.name;
    [self.tableView reloadData];
}
// 家乡
- (void)sendHometownString:(NSString *)string
{
    self.state = 1;
    self.hometown = string;
    self.contentArray[3] = self.hometown;
    [self.tableView reloadData];
}

// 退出当前登录
- (void)actionExitButton
{
    //NSLog(@"1111");
    [ZRUserInterfaceModel exitUserLoginCallBack:^(NSString *message) {
        //NSLog(@"%@", message);
        if ([message isEqualToString:@"success"]) {
            [ZRUserTool saveAccount:nil];
            [self.delegate exitUserLogin];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)navbanckBtnClick
{
    
    //执行block
//    [self baseNavLeftBtnClick];
    
    if (self.state == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您尚未提交, 确认退出?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:defaultAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    
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
