//
//  ZRConfirmOrderController.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRConfirmOrderController.h"
#import "ZROrderAddressCell.h"
#import "ZROrderSelectCell.h"
#import "ZROrderSelectTwoCell.h"
#import "ZROrderMenuCell.h"
#import "ZROrderTipCell.h"
#import "ZROrderPeiSongCell.h"
#import "ZROrderingMenuModel.h"
#import "ZRSupermarketHomeObj.h"
#import "ZRLunchAddressCell.h"
#import "ZRNameViewController.h"
#import "TZTimePickerView.h"
#import "ZRSelectAddressController.h"
#import "ZRUserAddressModel.h"
#import "ZRPaymentOrderController.h"
#import "ZRUser.h"
#import "ZRUserTool.h"
#import "ZROrderRemarksView.h"
#import "ZRExplainViewController.h"
#import "ZRSupermarketGoodsListModel.h"
#import "ZRSupermarketRequest.h"
#import "ZRSupermarketHomeModel.h"
#import "ZRAddKaOrderModel.h"

#import "ZRHomePageRequst.h"
#import "ZRUserShoppingCarRequest.h"
@interface ZRConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource,ZRSelectAddressControllerDelegate>

@property (nonatomic , weak) UITableView * myTableView;

@property (nonatomic , assign) BOOL isPickedUp; //是否自提 no外卖配送 yes到店自提
@property (nonatomic , assign) NSInteger sectionCount;
@property (nonatomic , strong) UIButton * selectBtn; // 用于保存 选中按钮
@property (nonatomic , strong) UIButton * paymentBtn; // 用于保存 选中支付方式按钮

@property (nonatomic , strong) NSArray * titleArr;
@property (nonatomic , strong) NSArray * paymentArr;
//用于保存小费比例 比如 5 10 15 20   0是没有小费
@property (nonatomic , assign) NSInteger xiaoFei;
//保存小费
@property (nonatomic , assign) float xiaoMoney;
//保存配送费
@property (nonatomic , assign) float peiMoney;
//保存税费
@property (nonatomic , assign) float shuiMoney;
//保存总计label
@property (nonatomic , strong) UILabel * moneyCountLB;
@property (nonatomic , assign) BOOL  isOne;
@property (nonatomic , assign) BOOL  isTwo;

@property (nonatomic , assign) BOOL isRegister;
@property (nonatomic , assign) BOOL isPayment;
@property (nonatomic , assign) BOOL isTwoCell;
@property (nonatomic , assign) BOOL isLunchCell;
@property (nonatomic , assign) BOOL isRemarkCell;
@property (nonatomic , assign) BOOL isWeight;
//午餐
@property (nonatomic , strong) UIButton * lunchSelectBtn;

//送达时间
@property (nonatomic , strong) NSDictionary * songdaDict;

//备注
@property (nonatomic , strong) NSDictionary * beizhuDict;

//重量费
@property (nonatomic , assign) CGFloat weightMoney;
//名字
@property (nonatomic , copy) NSString * userName;

//电话号
@property (nonatomic , copy) NSString * userIphone;

//总重量
@property (nonatomic, assign) CGFloat allWeight;

@property (nonatomic, strong) UIButton * querenBtn;
@end

@implementation ZRConfirmOrderController

-(void)setProductArr:(NSArray *)productArr{
    _productArr = productArr;
    _allWeight = 0;
    _shuiMoney = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05;
    if (_orderType == Supermarket) {
        for (NSMutableArray *arr in productArr) {
            ZRSupermarketGoodsListModel *superGoodsListModel = arr[0];
            _allWeight += ([superGoodsListModel.weight floatValue] ) * arr.count;
        }
    }
    
}


//-(void)setWeather:(CGFloat)weather{
//    _weather = 1.5;
//    
//}

- (void)setBusinessMsg:(ZROrderingBusinessMsgModel *)businessMsg{
    _businessMsg = businessMsg;
    
}

-(NSArray *)paymentArr{
    if (_paymentArr == nil ) {
        _paymentArr = @[@"在线支付",@"货到付款"];
    }
    return _paymentArr;
}

-(NSArray *)titleArr {
    if (_titleArr == nil) {
        _titleArr = @[@"到店自取",@"外卖配送"];
    }
    return _titleArr;
}
-(void)setLatitude:(NSString *)latitude{
    _latitude = latitude;
    
   
}


//总重量
- (CGFloat)getAllGoodsWeight
{
    __block CGFloat wei;
    [[ZRSupermarketHomeObj shareInstance].allProductsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = obj;
        ZRSupermarketGoodsListModel *goodsModel = arr[0];
        wei += [goodsModel.weight floatValue] *arr.count;
        
        
        
    }];
    
    return wei;
}

-(UITableView *)myTableView{
    if (_myTableView == nil) {
        UITableView * myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 49, ScreenWidth , ScreenHeight - 49) style:UITableViewStylePlain];
        [self.view addSubview:myTableView];
        _myTableView = myTableView;
        
        myTableView.backgroundColor = [UIColor clearColor];
        myTableView.rowHeight = UITableViewAutomaticDimension;
        myTableView.estimatedRowHeight = 80.0;
        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        myTableView.tableFooterView = footView;

    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZRBackgroundColor;
    self.navigationItem.title = @"确认订单";
    _xiaoFei = 5; // 0 5 10 15 20

    if (_orderType == lunchOrdering) {
        _songdaDict = @{@"取餐时间":@"请选择取餐时间"};
          _beizhuDict = @{@"订单备注":@"口味 , 偏好等其他需求"};
    }else{
        _songdaDict = @{@"送达时间":@"默认送达"};
          _beizhuDict = @{@"订单备注":@"对本次交易的说明"};
    }
    
    
  
   
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self createConfirmToolbar];
    
    
    
   
}

- (void)setIsDeliver:(BOOL )isDeliver{
    _isDeliver = isDeliver;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
}

-(void)setIsOnlinePay:(BOOL )isOnlinePay{
    _isOnlinePay = isOnlinePay;
    
    
}

#pragma mark -- tableView 代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_orderType == Supermarket ) {
        
        if (_weather != 1) {
            _sectionCount = 7;
            return 7;
        }else{
            _sectionCount = 6;
            return 6;
        }

    }
    else if(_orderType == lunchOrdering){
        _sectionCount = 6;
        return 6;
    }
    else{
        //是否自己配送 1是, 0不是
        if (_isDeliver == YES && _isPickedUp == NO) {
            _sectionCount = 8;
            return 8;
        }else if(_isDeliver == YES && _isPickedUp == YES ){
            _sectionCount = 6;
            return 6;
        }else if(_isDeliver == NO && _isPickedUp == NO){
            _sectionCount = 8;
            return 8;
        }else{
            _sectionCount = 6;
            return 6;
        }

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_orderType == Supermarket && _sectionCount ==6) {
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return 1;
        }else if(section == 2){
            return 1;
        }else if(section == 3){
            return 1;
        }else if (section == 4){
            return 1;
        }else{
            return 1;
        }
    }
    if (_orderType == Supermarket && _sectionCount ==7) {
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return 1;
        }else if(section == 2){
            return 1;
        }else if(section == 3){
            return 1;
        }else if (section == 4){
            return 1;
        }else{
            return 1;
        }
    }
    
    if (_orderType == lunchOrdering && _sectionCount == 6) {
        if (section == 0) {
            return _businessMsg.readdress.count + 1;
        }else if(section == 1){
            return 2;
        }else if (section == 2){
            return 2;
        }else if (section == 3){
            return 2;
        }else if(section == 4){
            return 1;
        }else if(section == 5){
            return 1;
        }else{
            return 1;
        }
    }
    
    if ( _sectionCount == 8) {
        //1
        if (section == 0) {
            return 1;
        }else if (section == 1){ //2
            return 2;
        }else if (section == 2){
            if (_isDeliver == YES) {
                return 1;
            }else{
                if (_isOnlinePay == YES) {
                    return 2;
                }else{
                    return 1;
                }
            }
        }else if(section == 3){
            return 2;
        }else if(section == 4) {
            return 1;
        }else if(section == 5){
            return 1;
        }else if(section == 6){
            return 1;
        }else{
            return 1;
        }
        
    }else{
        //1
        if (section == 0) {
            return 2;
        }else if (section == 1){// 2
            if (_isDeliver == YES) {
                return 1;
            }else{
                if (_isOnlinePay == YES) {
                    return 2;
                }else{
                    return 1;
                }
            }
            
        }else if (section == 2){  //3
            return 2;
        }else if(section == 3){
            return 1;
        }else if(section == 4){
            return 1;
        }else{
            return 1;
        }

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * addressCell = @"addressCell";
    static NSString * selectCell = @"selectCell";
//    static NSString * selectPaymentCell = @"selectPaymentCell";
    static NSString * selectTwoCell = @"selectTwoCell";
    static NSString * selectRemarksCell = @"selectRemarksCell";
    static NSString * MenuCell = @"MenuCell";
    static NSString * tipCell = @"tipCell";
     static NSString * peisongCell = @"peisongCell";
     static NSString * shuiCell = @"shuiCell";
    static NSString * lunchCell = @"lunchCell";
    static NSString * lunchAddress = @"lunchAddress";
    static NSString * wightCell = @"wightCell";
    if (_orderType == Supermarket) {
       
        if (indexPath.section == 0) {
            
           
            ZROrderAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderAddressCell class]) owner:self options:nil];
                cell = [nibs lastObject];
            }
            cell.addressModel = _addressModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        else if(indexPath.section == 1){
            if (!_isTwoCell) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectTwoCell class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:selectTwoCell];
                _isTwoCell = YES;
            }
            
            ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:selectTwoCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary * titleDict ;
            titleDict = _beizhuDict;
            cell.titleDict = titleDict;
            
            return cell;
        }
        
        else if(indexPath.section == 2){
            
            ZROrderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:MenuCell];
            if (cell == nil) {
                cell = [[ZROrderMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            

            
            if (self.orderType == 0) {
                cell.type = NO;
            } else {
                cell.type = YES;
            }
            cell.menuArr = self.productArr;
            
            
            
            //回调 超市点击 加减号
            WS(ws)
            cell.upDataCount = ^(){
 //11111111111111111111111111111111111111
                UITableViewCell * shui = [tableView dequeueReusableCellWithIdentifier:shuiCell];
                shui.detailTextLabel.text = [NSString stringWithFormat:@"$%.2lf", [ZRSupermarketHomeObj shareInstance].allPrice * 0.05];
               

                
                ws.shuiMoney = [ZRSupermarketHomeObj shareInstance].allPrice * 0.05;
                //重量
                
                ws.allWeight = 0;
                for (NSMutableArray *arr in ws.productArr) {
                    ZRSupermarketGoodsListModel *superGoodsListModel = arr[0];
                    ws.allWeight += ([superGoodsListModel.weight floatValue] ) * arr.count;
                }
                ws.weightMoney = [ws getWeight:ws.allWeight] * _weather;
                
                //配送
                ws.peiMoney  = [self getSupermarketDataWithDistance:[self.distanceStr floatValue] andWeight:_allWeight andSpecialWeather:_weather];
                
                //总计
                ws.moneyCountLB.text = [NSString stringWithFormat:@"总计: $%.2f",([ZRSupermarketHomeObj shareInstance].allPrice  + ws.peiMoney + ws.shuiMoney + ws.weightMoney) ];
                
                NSLog(@"%lf",[ZRSupermarketHomeObj shareInstance].allPrice);
                
                [ws.myTableView reloadData];
                
//                NSLog(@"%f",[[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] );
                };
            
            return cell;
        }
        
        else if (indexPath.section == 3){

            ZROrderPeiSongCell * cell = [tableView dequeueReusableCellWithIdentifier:peisongCell];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderPeiSongCell class]) owner:self options:nil];
                cell = [nibs lastObject];
            }
            
            //点击配送说明
            WS(ws)
            cell.peisongShuomingClick = ^(){
                ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
                
                explainVC.title = @"配送费说明";
                
                [ws.navigationController pushViewController:explainVC animated:YES];
            };
            
            _peiMoney  = [self getSupermarketDataWithDistance:[self.distanceStr floatValue] andWeight:_allWeight andSpecialWeather:_weather];
            
          
            cell.psMoney = _peiMoney;
  
            ZRUser * user = [ZRUserTool user];
            if ([user.is_vip isEqualToString:@"0"]) {
                cell.isVip =NO;
            }else{
                cell.isVip = YES;
            }
            
            if ([_businessMsg.specialDelivery isEqualToString:@"1"]) {
                cell.isXXDistribution = YES;
            }else{
                cell.isXXDistribution =YES;
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        
        else if(indexPath.section == 4){
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shuiCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shuiCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"收取商品5%的税费";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f", [ZRSupermarketHomeObj shareInstance].allPrice * 0.05];
            _shuiMoney = [ZRSupermarketHomeObj shareInstance].allPrice * 0.05;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.textColor = [UIColor redColor];
            return cell;
        }
        
        else if(indexPath.section == 5){
            
            if (!_isWeight) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectTwoCell class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:wightCell];
                _isWeight = YES;
            }
            
            ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:wightCell];
            if (_weather != 1.0) {
                cell.isSpecialWeather = YES;
//                [self createWeateLabei:cell];
            }else{
                cell.isSpecialWeather = NO;
            }
            _weightMoney = [self getWeight:[self getAllGoodsWeight]] * _weather;
            cell.allWeight = _allWeight;
            cell.weightMoney = [NSString stringWithFormat:@"%.2f",_weightMoney] ;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        else{
            NSString * tianqicell = @"tianqishuoming";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shuiCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tianqicell];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"因特殊天气包含额外费用(x%.1f)",_weather];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.textColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    
    
    
    if (_sectionCount == 8) {
        //---地址cell
        if (indexPath.section == 0) {
            
            
            ZROrderAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:addressCell];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderAddressCell class]) owner:self options:nil];
                cell = [nibs lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        else if (indexPath.section == 1){
            if (!_isRegister) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectCell class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:selectCell];
                _isRegister = YES;
            }
            ZROrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:selectCell ];

            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.TitleText = self.titleArr[indexPath.row];

            if (indexPath.row == 1 && _isOne == NO) {
                cell.isSelect = @"1";
                _selectBtn = cell.isSelectBtn;
                _isOne = YES;
            }
            
            WS(ws)
            cell.isSelectClick = ^(UIButton * btn){
                //因为只能同时 选中一个按钮, 保存一个按钮, 其他按 取消后再保存.
                ws.selectBtn.selected = NO;
                ws.selectBtn = btn;
                
                // tag  0是 到店自取  1是 外卖配送
                if (btn.tag == 0) {
                    ws.isPickedUp = YES;
                }else{
                    ws.isPickedUp = NO;
                }
                
                [ws.myTableView reloadData];

            };
            return cell;
        }
        
        else if(indexPath.section == 2){
            if (!_isPayment) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectCell class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:selectCell];
                _isPayment = YES;
            }

            ZROrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:selectCell];
          
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if(_isDeliver == YES){
                cell.TitleText = @"在线支付";
                
                if (_isTwo == NO) {
                    cell.isSelect = @"1";
                    cell.isChange = YES;
                    _paymentBtn = cell.isSelectBtn;
                    _isTwo = YES;
                   
                }
                 return cell;
            }else{

                if (_isOnlinePay == YES){//支持在线和 货到付款
                    cell.TitleText = _paymentArr[indexPath.row];
                    
                    if (indexPath.row == 1 && _isTwo == NO) {
                        cell.isSelect = @"1";
                        _paymentBtn = cell.isSelectBtn;
                    }
                    WS(ws)
                    cell.isSelectClick = ^(UIButton * btn){
                        ws.paymentBtn.selected = NO;
                        ws.paymentBtn = btn;
                    };
                    return cell;
                }else{
                    cell.TitleText = @"货到付款";
                    cell.isSelect = @"1";
                    cell.isChange = YES;
                    _paymentBtn = cell.isSelectBtn;
                    return cell;
                }
                
            }
        }
        else if(indexPath.section == 3){
            if (!_isTwoCell) {
                UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectTwoCell class]) bundle:nil];
                [tableView registerNib:nib forCellReuseIdentifier:selectTwoCell];
                _isTwoCell = YES;
            }
            
            ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:selectTwoCell];
       
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary * titleDict ;
            if (indexPath.row==0) {
                titleDict = _songdaDict;
            }else{
                titleDict = _beizhuDict;
            }
            cell.titleDict = titleDict;
            return cell;
        }
        
        else if(indexPath.section == 4){
            ZROrderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:MenuCell];
            if (cell == nil) {
                cell = [[ZROrderMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.menuArr = self.productArr;
            [cell setHeight: _productArr.count * 40];
            
            //回调
            WS(ws)
            cell.upDataCount = ^(){
                //送餐小费
               ZROrderTipCell * tip = [tableView dequeueReusableCellWithIdentifier:tipCell];
                tip.percentage = ws.xiaoFei / 100 ;
                ws.xiaoMoney =  [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * (_xiaoFei / 100 );
                //配送费(判断是否有配送费)
//                if (ws.sectionCount == 8) {
//                    
//                }
                //税费
                UITableViewCell * shui = [tableView dequeueReusableCellWithIdentifier:shuiCell];
                 shui.detailTextLabel.text = [NSString stringWithFormat:@"$%lf", [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05];
                ws.shuiMoney = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05;
                //总计
                ws.moneyCountLB.text = [NSString stringWithFormat:@"总计: $%f",[[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] + _xiaoMoney + _peiMoney + _shuiMoney];
                [ws.myTableView reloadData];
                
                NSLog(@"%lf",_weather);
//               NSArray * arr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;

            };
            
            return cell;
        }
        
        else if(indexPath.section == 5){
            ZROrderTipCell * cell = [tableView dequeueReusableCellWithIdentifier:tipCell];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderTipCell class]) owner:self options:nil];
                cell = [nibs lastObject];
            }
            cell.percentage = _xiaoFei / 100 ;
            _xiaoMoney =  [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * (_xiaoFei / 100 );
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        else if(indexPath.section == 6){
            ZROrderPeiSongCell * cell = [tableView dequeueReusableCellWithIdentifier:peisongCell];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderPeiSongCell class]) owner:self options:nil];
                cell = [nibs lastObject];
            }
//---------待完善 配送费暂时未定
//            self getOrderingDataWithIsBusiness:<#(NSString *)#> andDistance:<#(CGFloat)#> andFreeSingleMoney:<#(CGFloat)#>
            
            cell.psMoney = 5;
            _peiMoney = 5;
            
            
            ZRUser * user = [ZRUserTool user];
            if ([user.is_vip isEqualToString:@"0"]) {
                cell.isVip =NO;
            }else{
                cell.isVip = YES;
            }
            
            
            if ([_businessMsg.specialDelivery isEqualToString:@"1"]) {
                cell.isXXDistribution = YES;
            }else{
                cell.isXXDistribution = NO;
            }
            
            WS(ws)
            cell.peisongShuomingClick = ^(){
                ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
                
                explainVC.title = @"配送费说明";
                
                [ws.navigationController pushViewController:explainVC animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shuiCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shuiCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"收取餐费5%的税费";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
           
            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2lf", [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05];
            _shuiMoney = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.textColor = [UIColor redColor];
            return cell;
        }
        
    }
    else if (_orderType == lunchOrdering) {
        //午餐
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:lunchCell];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lunchCell];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"请选择一处取餐地址";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                 return cell;
            }else {
                //lunchAddress
                if (!_isLunchCell) {
                    UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZRLunchAddressCell class]) bundle:nil];
                    [tableView registerNib:nib forCellReuseIdentifier:lunchAddress];
                    _isLunchCell = YES;
                }
                
                ZRLunchAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:lunchAddress];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.count = [NSString stringWithFormat:@"%ld",indexPath.row - 1];
                cell.addressModel = _businessMsg.readdress[indexPath.row - 1];
                cell.orderingModel = _businessMsg;
                
                
                
                WS(ws)
                //午餐地址选择按钮
                cell.selectBtnClick = ^ (UIButton * btn){
                    ws.lunchSelectBtn.selected = NO;
                    
                    ws.lunchSelectBtn = btn;
                    
                    ws.lunchSelectBtn.selected = YES;
                };
                 return cell;
            }
        }
        else if(indexPath.section == 1){
            
            static NSString * nameCell = @"nameCell";
            static NSString * nameCellTwo = @"nameCellTwo";
            if (indexPath.row == 0) {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nameCell];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCell];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.text = @"姓名:";
                
                 return cell;
            }else {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nameCellTwo];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nameCellTwo];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                if (_userName == nil) {
                    ZRUser * user = [ZRUserTool user];

                    cell.textLabel.text = user.name;
                    _userName = user.name;
                }else{
                    cell.textLabel.text = _userName;
                }
                
                
                
                 return cell;
            }
        }
        else if (indexPath.section == 2){
            static NSString * iphoneCell = @"iphoneCell";
            static NSString * iphoneCellTwo = @"iphoneCellTwo";
            
            if (indexPath.row == 0) {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iphoneCell];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iphoneCell];
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"手机号:";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                 return cell;
                
            }else {
                
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iphoneCellTwo];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iphoneCellTwo];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                
                if (_userIphone == nil) {
                    ZRUser * user = [ZRUserTool user];
                    cell.textLabel.text = user.phone;
                     _userIphone = user.phone;
                }else{
                    cell.textLabel.text = _userIphone;
                }
                
               
                return cell;
            }
        }
        else if(indexPath.section == 3){
            
            if (indexPath.row==0) {
                if (!_isTwoCell) {
                    UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectTwoCell class]) bundle:nil];
                    [tableView registerNib:nib forCellReuseIdentifier:selectTwoCell];
                    _isTwoCell = YES;
                }
                
                ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:selectTwoCell];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary * titleDict ;

                titleDict = _songdaDict;
 
                cell.titleDict = titleDict;
                return cell;
            }else{
//                selectRemarksCell
                if (!_isRemarkCell) {
                    UINib * nib = [UINib nibWithNibName:NSStringFromClass([ZROrderSelectTwoCell class]) bundle:nil];
                    [tableView registerNib:nib forCellReuseIdentifier:selectRemarksCell];
                    _isRemarkCell = YES;
                }
                
                ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:selectRemarksCell];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSDictionary * titleDict ;
                
                titleDict = _beizhuDict;
                
                cell.titleDict = titleDict;
                return cell;
            }
            
            
        }
        else if(indexPath.section == 4){
            ZROrderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:MenuCell];
            if (cell == nil) {
                cell = [[ZROrderMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MenuCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.menuArr = self.productArr;
            [cell setHeight: _productArr.count * 40];
            
            //回调
            WS(ws)
            cell.upDataCount = ^(){
            
                UITableViewCell * shui = [tableView dequeueReusableCellWithIdentifier:shuiCell];
                shui.detailTextLabel.text = [NSString stringWithFormat:@"$%.2lf", [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05];
                ws.shuiMoney = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05;
                
                //总计
                ws.moneyCountLB.text = [NSString stringWithFormat:@"总计: $%.2f",([[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] +  _shuiMoney) ];
                [ws.myTableView reloadData];

            };
            
            return cell;
        }
        
        else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shuiCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shuiCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"收取餐费5%的税费";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            

            cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2lf", [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05];
            _shuiMoney = [[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] * 0.05;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
            cell.detailTextLabel.textColor = [UIColor redColor];
            return cell;
        }
    }
    
    else {
        if (indexPath.section == 0){
            ZROrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:selectCell];
            
            return cell;
          }
        else if(indexPath.section == 1){
            ZROrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:selectCell];
            return cell;
        }
        else if(indexPath.section == 2){
            ZROrderSelectTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:selectTwoCell];
            return cell;
        }
        else if(indexPath.section == 3){
            ZROrderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:MenuCell];
            return cell;
        }
        else if(indexPath.section == 4){
            ZROrderTipCell * cell = [tableView dequeueReusableCellWithIdentifier:tipCell];
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:shuiCell];
            return cell;
        }
    }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_orderType == Supermarket && _sectionCount ==6) {
        if (indexPath.section == 0 && indexPath.row == 0  ) {
            ZRSelectAddressController * VC = [[ZRSelectAddressController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(indexPath.section == 1 && indexPath.row == 0){
            ZROrderRemarksView * remarksView = [[ZROrderRemarksView alloc] init];
            //                NSString * selectRemarksCell = @"selectRemarksCell";
            
            [remarksView show];
            WS(ws)
            remarksView.userClickQueding = ^(NSString * userText){
                
                
                if (userText.length==0) {
                    _beizhuDict = @{@"订单备注":@"对本次交易的说明"};
                }else{
                    _beizhuDict = @{@"订单备注":userText};
                }
                
                
                
                [ws.myTableView reloadData];
            };
        }
        else if(indexPath.section == 5){
            //重量说明
            ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
            explainVC.type = 1;
            explainVC.title = @"重量费说明";
            
            [self.navigationController pushViewController:explainVC animated:YES];
        }
   
    }
    if (_orderType == Supermarket && _sectionCount ==7){
        
        if (indexPath.section == 0 && indexPath.row == 0  ) {
            ZRSelectAddressController * VC = [[ZRSelectAddressController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if(indexPath.section == 1 && indexPath.row == 0){
            ZROrderRemarksView * remarksView = [[ZROrderRemarksView alloc] init];
            //                NSString * selectRemarksCell = @"selectRemarksCell";
            
            [remarksView show];
            WS(ws)
            remarksView.userClickQueding = ^(NSString * userText){
                
                
                if (userText.length==0) {
                    _beizhuDict = @{@"订单备注":@"对本次交易的说明"};
                }else{
                    _beizhuDict = @{@"订单备注":userText};
                }
                
                
                
                [ws.myTableView reloadData];
            };
        }
        else if(indexPath.section == 5){
            //重量说明
            ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
            explainVC.type = 1;
            explainVC.title = @"重量费说明";
            
            [self.navigationController pushViewController:explainVC animated:YES];
        }
        
        //,,,,,,,,,,,,,,,,,,,shangmian  na xia lai
        
         if(indexPath.section == 6){
            ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
            explainVC.type = 2;
            explainVC.title = @"天气系数说明";
            
            [self.navigationController pushViewController:explainVC animated:YES];
        }
    }
    if (_orderType == lunchOrdering && _sectionCount == 6) {
        //午餐
        if (indexPath.section == 1&& indexPath.row == 1) {
            ZRNameViewController * name = [[ZRNameViewController alloc] init];
            name.nameAndIphone = ZRName;
            [self.navigationController pushViewController:name animated:YES];
            WS(ws)
            name.clickBaocun = ^(NSString * text ){
                ws.userName = text;
                [ws.myTableView  reloadData];
            };
        }
        WS(ws)
        if (indexPath.section == 2 && indexPath.row == 1) {
            ZRNameViewController * name = [[ZRNameViewController alloc] init];
            name.nameAndIphone =ZRIphone;
            [self.navigationController pushViewController:name animated:YES];
            
            name.clickBaocun = ^(NSString * text ){
                ws.userIphone = text;
                [ws.myTableView  reloadData];
            };
        }
       
        if (indexPath.section == 3 ) {
          
            
            if (indexPath.row == 0) {
            
                TZTimePickerView * timeView = [[TZTimePickerView alloc] init];
                
//                NSString * selectTwoCell = @"selectTwoCell";
                
                [timeView show];
                WS(ws)
                timeView.okBtnClickBlock = ^(NSString * time , NSString * day){
                    //选中的时间,日期
                
                    _songdaDict = @{@"取餐时间":[NSString stringWithFormat:@"%@ %@",day,time]};
                    
                    [ws.myTableView reloadData];
                };
            }else{
                ZROrderRemarksView * remarksView = [[ZROrderRemarksView alloc] init];
//                NSString * selectRemarksCell = @"selectRemarksCell";
                
                [remarksView show];
                WS(ws)
                remarksView.userClickQueding = ^(NSString * userText){
          

                    if (userText.length==0) {
                       _beizhuDict = @{@"订单备注":@"口味 , 偏好等其他需求"};
                    }else{
                        _beizhuDict = @{@"订单备注":userText};
                    }
                    

                   
                    [ws.myTableView reloadData];
                };
            }
        }
     
        
    }
    
    if (_orderType == Ordering && _sectionCount == 8) {
        if (indexPath.section == 0 ) {
            ZRSelectAddressController * VC = [[ZRSelectAddressController alloc] init];
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    
    if (_orderType == Ordering && _sectionCount == 6) {
        
    }
    
    
}

#pragma mark - ZRSelectAddressController代理
- (void)getAddressModel:(ZRUserAddressModel *)model
{
    ZRUserFindAddressModel * addModel = [[ZRUserFindAddressModel alloc] init];
    addModel.name = model.name;
    addModel.addressId= model.addressId;
    addModel.phone = model.phone;
    addModel.gender = [NSString stringWithFormat:@"%d", model.gender];
    addModel.longitude = model.longitude;
    addModel.latitude = model.latitude;
    addModel.address = model.address;
    _addressModel = addModel;
WS(ws)
    [CustomHudView show];
     [ZRSupermarketRequest requestGetDustabceWithLongitudeOne:_longitude andLatitudeOne:_latitude andLongitudeTwo:model.longitude andLatitudeTwo:model.latitude andSuccess:^(id success) {
         [CustomHudView dismiss];
         ws.distanceStr = success;
        
         [ws.myTableView reloadData];
     } andFailure:^(id error) {
         [CustomHudView dismiss];
         [SVProgressHUD showErrorWithStatus:@"定位失败,距离计算可能存在误差"];
         [ws.myTableView reloadData];
     }];
    
   
    
}

#pragma mark -- 确认支付
- (void)createConfirmToolbar{
    UIView * toolView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    UIColor *myColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    
    toolView.backgroundColor = myColor;
    
    [self.view addSubview:toolView];
    
    [toolView bringSubviewToFront:self.view];
    
    //钱数
    UILabel * moneyCountLB = [UILabel new];
    _moneyCountLB = moneyCountLB;
    
    if (_orderType == Supermarket) {
            moneyCountLB.text = [NSString stringWithFormat:@"总计: $%.2f",([ZRSupermarketHomeObj shareInstance].allPrice + _peiMoney + _shuiMoney + _weightMoney ) ];
     
        
    }else{
            moneyCountLB.text = [NSString stringWithFormat:@"总计: $%.2f",([[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] + _xiaoMoney + _peiMoney + _shuiMoney ) ];
    }
    
    moneyCountLB.font = [UIFont systemFontOfSize:15];
    moneyCountLB.textColor = [UIColor whiteColor];
    [toolView addSubview:moneyCountLB];
    
    [moneyCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(toolView.mas_centerY);
        make.left.equalTo(toolView.mas_left).offset(15);
    }];
    
    
    //确认下单按钮
    UIButton * confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"确认下单" forState:UIControlStateNormal];
    
//<<<<<<< HEAD
    if (_peiMoney == 0 && _orderType == Supermarket) {
        confirmBtn.userInteractionEnabled = NO;
        [confirmBtn setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
//=======
//#warning 由于午餐无法下单，丁楠在此稍作改动，不知对错，请嘉楠再确认一下
//    
//    if (_orderType == Supermarket) {
//        if (_peiMoney == 0) {
//            confirmBtn.userInteractionEnabled = NO;
//            [confirmBtn setBackgroundColor:[UIColor grayColor] forState:UIControlStateNormal];
//        }else{
//            confirmBtn.userInteractionEnabled = YES;
//            [confirmBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
//        }
// 
//>>>>>>> 7a263b1c31fd9e0978947483fc065930681a0000
    }else{
        confirmBtn.userInteractionEnabled = YES;
        [confirmBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    
#warning 给以上加了个判断,else里的内容是我后加上去的
    
    
//    [confirmBtn setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
   // [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _querenBtn = confirmBtn;
    [toolView addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolView.mas_top);
        make.right.equalTo(toolView.mas_right);
        make.bottom.equalTo(toolView.mas_bottom);
        make.width.equalTo(toolView.mas_width).multipliedBy(0.3);
    }];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
}



#pragma mark -- 点击确认订单
- (void)confirmBtnClick{
    //NSLog(@"%@",self.userName);
    _querenBtn.userInteractionEnabled = NO;
    
    if (_orderType == lunchOrdering) {
        if (self.userName == nil) {
            [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
            
            
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
            _querenBtn.userInteractionEnabled = YES;
            return  ;
        }else if(self.userIphone == nil){
            _querenBtn.userInteractionEnabled = YES;
            [SVProgressHUD showErrorWithStatus:@"请输入用户电话"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
            return ;
        }else if(_lunchSelectBtn.selected == NO){
            _querenBtn.userInteractionEnabled = YES;
            [SVProgressHUD showErrorWithStatus:@"请选择取餐地址"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
            
            return;
        }else if([_songdaDict[@"取餐时间"] isEqualToString:@"请选择取餐时间"]){
            _querenBtn.userInteractionEnabled = YES;
            [SVProgressHUD showErrorWithStatus:@"请选择取餐时间"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:0.5];
            return;
        }
        
    }
    
    
    if (_orderType == Supermarket) {
        if (_addressModel == nil) {
            _querenBtn.userInteractionEnabled = YES;
            [SVProgressHUD showErrorWithStatus:@"请添加地址"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:1];
            return; 
        }
    }
       //跳转到支付页面
    WS(ws)
    ZRPaymentOrderController *paymentOrderVC = [[ZRPaymentOrderController alloc] init];
    //[self.navigationController pushViewController:paymentOrderVC animated:YES];
    if (self.orderType == Ordering || self.orderType == lunchOrdering) {
        
        NSMutableArray *LunchOrderGoods = [NSMutableArray array];
        for (NSMutableArray * arr in self.productArr) {
            ZROrderingMenuModel * model = arr[0];
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            [goodsDic setObject:model.menu_id forKey:@"goodsId"];
            [goodsDic setObject:model.name forKey:@"goodsName"];
            NSString *priceStr = [NSString stringWithFormat:@"%f",[model.unit_price floatValue]*arr.count];
            
            [goodsDic setObject:priceStr forKey:@"price"];
            [goodsDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)arr.count] forKey:@"num"];
            [LunchOrderGoods addObject:goodsDic];
        }
        NSString * sendTime =_songdaDict[@"取餐时间"];
        NSString * price = @"0";
        NSString * taxation =  [NSString stringWithFormat:@"%.2lf",_shuiMoney];
#warning test
        NSString * total =[NSString stringWithFormat:@"%.2lf",[[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] +  _shuiMoney];
        //NSString *total = @"0.002";
        
        ZROrderingAddress * address = _businessMsg.readdress[_lunchSelectBtn.tag];
        NSString * receiptAddress = address.address;
        NSString * personName = address.person_name;
        NSString * personPhone = address.person_phone;
        NSString * takeMealName = self.userName;
        NSString * takeMealPhone = self.userIphone;
        NSString * payMethod = @"在线支付";
        NSString * remarks = _beizhuDict[@"订单备注"];
        paymentOrderVC.payOrderType = ZRPayOrderLunch;
        paymentOrderVC.payPrice =[NSString stringWithFormat:@"$%@", total];
        [SVProgressHUD show];
        
        [ZRHomePageRequst requestForAddLunchOrderWithSendTime:sendTime Price:price Taxation:taxation CanadianDollar:total ReceiptAddress:receiptAddress PersonName:personName PersonPhone:personPhone TakeMealName:takeMealName TakeMealPhone:takeMealPhone PayMethod:payMethod Remarks:remarks LunchOrderGoods:LunchOrderGoods CallBack:^(id details, NSError *error) {
            ws.querenBtn.userInteractionEnabled = YES;
            [SVProgressHUD dismiss];
            
            if (details) {
                [ws.navigationController pushViewController:paymentOrderVC animated:YES];
                //数据转模型
                ZRAddKaOrderModel *kaOrderModel = [ZRAddKaOrderModel mj_objectWithKeyValues:details];
                paymentOrderVC.addKaOrderModel = kaOrderModel;
                
                
//111111111111111111111111111111111111111111111111111111111111111111111
                //将购物车中内容清空
                [ZRSupermarketHomeObj shareInstance].selectedFoodsArray = nil;
                [ZRSupermarketHomeObj shareInstance].totalPrice = 0;
                [ZRSupermarketHomeObj shareInstance].totalNumber = 0;
                
                
            }

            
        }];
        
        
        
        
    }else if (self.orderType == Supermarket){
        paymentOrderVC.payOrderType = ZRPayOrderSupermarket;
        paymentOrderVC.payPrice = [NSString stringWithFormat:@"$%.2f",[ZRSupermarketHomeObj shareInstance].allPrice + _peiMoney + _shuiMoney + _weightMoney];
        //paymentOrderVC.superHomeModel = self.supermarketHomeModel;
        NSMutableArray *kaOrderGoodsArr = [NSMutableArray array];
        for (NSMutableArray *arr in self.productArr) {
            ZRSupermarketGoodsListModel *superGoodsListModel = arr[0];
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            [goodsDic setObject:superGoodsListModel.goods_id forKey:@"goodsId"];
            [goodsDic setObject:superGoodsListModel.goods_name forKey:@"goodsName"];
            NSString *priceStr = [NSString stringWithFormat:@"%.2f",[superGoodsListModel.now_price floatValue]*arr.count];
            [goodsDic setObject:priceStr forKey:@"price"];
            [goodsDic setObject:[NSString stringWithFormat:@"%lu",(unsigned long)arr.count] forKey:@"num"];
            [kaOrderGoodsArr addObject:goodsDic];
            
        }
//        @param kaId           超市id
//        *  @param kaName         超市名称
//        *  @param roomTips       重量费
//        *  @param sendPrice      配送费
//        *  @param taxation       税费
//        *  @param total          总计
//        *  @param remarks        备注
//        *  @param receiptAddress 收货地址id
//        *  @param kaOrderGoods   数组
//        *  @param takeMealName   取餐人姓名
//        *  @param takeMealPhone  取餐人电话
//        *  @param callback       回调
        //网络请求
         [SVProgressHUD show];

        if ([self.superOrderState isEqualToString:@"1"]) {
            /**
             * 超市购物车提交订单
             * @param kaId            超市ID
             * @param kaName          超市名称
             * @param roomTips        重量费
             * @param sendPrice       配送费
             * @param taxation        税费
             * @param canadianDollar  总计
             * @param takeMealName    取餐人姓名
             * @param takeMealPhone   取餐人电话
             * @param remarks         备注
             * @param receiptAddress  收获地址id
             * @param kaOrderGoods    商品数组: [{goodsId:”物品id”,goodsName:”物品名称”,price:”当前物品总
             价”,(加币)num:”当前物品总数”}]
             * @param callBack        成功
             * @param failure         失败
             
             */
            CGFloat price;
            CGFloat allWeight;
            for (int i = 0; i < self.productArr.count; i++) {
                NSArray * array = self.productArr[i];
                for (ZRSupermarketGoodsListModel * model in array) {
                    price += model.now_price.floatValue;
                }
                
                
                ZRSupermarketGoodsListModel *goodsModel = array[0];
                allWeight+=[goodsModel.weight floatValue] *array.count;
                
            }
            CGFloat total = price + _peiMoney + _shuiMoney + _weightMoney;
            //NSLog(@"%@",[NSString stringWithFormat:@"%.2f",_shuiMoney] );            
            
            
            [ZRUserShoppingCarRequest shoppingCartAddKaOrderKaId:self.supermarketHomeModel.kaId KaName:self.supermarketHomeModel.kaName RoomTips:[NSString stringWithFormat:@"%.2f" ,_weightMoney] SendPrice:[NSString stringWithFormat:@"%.2f",_peiMoney] Taxation:[NSString stringWithFormat:@"%.2f",_shuiMoney] CanadianDollar:[NSString stringWithFormat:@"%.2f", total] TakeMealName:_addressModel.name TakeMealPhone:_addressModel.phone  andWeight : [NSString stringWithFormat:@"%.3f",allWeight]  Remarks:_beizhuDict[@"订单备注"] ReceiptAddress:_addressModel.address KaOrderGoods:kaOrderGoodsArr CallBack:^(id success) {
                [SVProgressHUD dismiss];
                ws.querenBtn.userInteractionEnabled = YES;
                NSDictionary * dict = success;
                if ([dict[@"code"] isEqualToString:@"S000"]) {
                    [ws.navigationController pushViewController:paymentOrderVC animated:YES];
                    //数据转模型
                    ZRAddKaOrderModel *kaOrderModel = [ZRAddKaOrderModel mj_objectWithKeyValues:dict[@"data"]];
                    paymentOrderVC.addKaOrderModel = kaOrderModel;
                    
                    
                    
  //111111111111111111111111111111111111111111111111111111111111111111111
                    [ZRSupermarketHomeObj shareInstance].allProductsArray = nil;
                    [ZRSupermarketHomeObj shareInstance].allPrice = 0;
                    [ZRSupermarketHomeObj shareInstance].allNumber = 0;
                    
                    
                } else {

                    [AlertText showAndText:@"确认订单失败"];
                }

//        [ZRSupermarketRequest requestAddKaOrderWithKaId:self.supermarketHomeModel.kaId KaName:self.supermarketHomeModel.kaName RoomTips:[NSString stringWithFormat:@"%.2f" ,_weight] SendPrice:[NSString stringWithFormat:@"%.2f",_peiMoney] Taxation:[NSString stringWithFormat:@"%.2f",_shuiMoney]  CanadianDollar:[NSString stringWithFormat:@"%.2f",[ZRSupermarketHomeObj shareInstance].allPrice + _peiMoney + _shuiMoney + _weight] Remarks:_beizhuDict[@"订单备注"] ReceiptAddress:_addressModel.id KaOrderGoods:kaOrderGoodsArr TakeMealName:_addressModel.name TakeMealPhone:_addressModel.phone Callback:^(id details, NSError *error) {
//             [SVProgressHUD dismiss];
//            if (details) {
//               [self.navigationController pushViewController:paymentOrderVC animated:YES];
//                //数据转模型
//                ZRAddKaOrderModel *kaOrderModel = [ZRAddKaOrderModel mj_objectWithKeyValues:details];
//                paymentOrderVC.addKaOrderModel = kaOrderModel;

                
            } Filure:^(id error) {
                ws.querenBtn.userInteractionEnabled = YES;
                [SVProgressHUD dismiss];
                [AlertText showAndText:@"确认订单失败"];
            }];
        } else {
            [ZRSupermarketRequest requestAddKaOrderWithKaId:self.supermarketHomeModel.kaId KaName:self.supermarketHomeModel.kaName RoomTips:[NSString stringWithFormat:@"%.2f" ,_weightMoney] SendPrice:[NSString stringWithFormat:@"%.2f",_peiMoney] Taxation:[NSString stringWithFormat:@"%.2f",_shuiMoney]  CanadianDollar:[NSString stringWithFormat:@"%.2f",[ZRSupermarketHomeObj shareInstance].allPrice + _peiMoney + _shuiMoney + _weightMoney] Remarks:_beizhuDict[@"订单备注"] ReceiptAddress:_addressModel.address KaOrderGoods:kaOrderGoodsArr TakeMealName:_addressModel.name TakeMealPhone:_addressModel.phone Weight:[NSString stringWithFormat:@"%.3f",[self getAllGoodsWeight]] Callback:^(id details, NSError *error) {
                ws.querenBtn.userInteractionEnabled = YES;
                [SVProgressHUD dismiss];
                if (details) {
                    [ws.navigationController pushViewController:paymentOrderVC animated:YES];
                    //数据转模型
                    ZRAddKaOrderModel *kaOrderModel = [ZRAddKaOrderModel mj_objectWithKeyValues:details];
                    paymentOrderVC.addKaOrderModel = kaOrderModel;
                    
//111111111111111111111111111111111111111111111111111111111111111111111
//                    将购物车内容清空
                    [ZRSupermarketHomeObj shareInstance].allProductsArray = nil;
                    [ZRSupermarketHomeObj shareInstance].allPrice = 0;
                    [ZRSupermarketHomeObj shareInstance].allNumber = 0;

                }
            }];
        }
    }
}


#pragma mark -- 配送费

//------订餐  如果是 返回-1 代表不配送 vai ter
- (CGFloat )getOrderingDataWithIsBusiness :(NSString*)isBusiness andDistance:(CGFloat)distance andFreeSingleMoney:(CGFloat )freeSingleMoney {
    
    if ([isBusiness isEqualToString:@"1"]) {
        //嗖嗖专送
        if (distance <= 3000 ) {
            return 3;
        }
        else if(distance > 10000){
            return -1;
        }
        else{
            int count = (distance - 3000)  / 1000 ;
            return count + 3;
        }
    }else{
        //店铺专送 pCosts
        if (distance >10000) {
            return -1 ;
        }else {
            if ([[ZRSupermarketHomeObj shareInstance] getPrductsMoneyCount] >= freeSingleMoney) {
                return 0;
            }else{
                return [_businessMsg.pCosts floatValue] ;
            }
        }
    }
}

// ---- 超市配送费  重量单位为千克kg

- (CGFloat)getSupermarketDataWithDistance:(CGFloat)distance andWeight:(CGFloat)weight andSpecialWeather : (CGFloat)weather{
//    CGFloat weightMoney = [self getWeight:weight ];
    CGFloat shouxuMoney = [ZRSupermarketHomeObj shareInstance].allPrice * 0.05;
    //配送费
    if (distance < 5000) {


        return (3 + shouxuMoney ) * weather ;
        
    }else if (distance >= 5000 && distance < 10000){
        CGFloat numb = (distance - 5000)/1000;


       return ([self heixinShangjia:numb] + 3 +shouxuMoney )*weather ;
    }else{

        return 0;
    }
    //手续费
    
    //重量费
    
    //特殊天气
}


//黑心卖家,专用方法,传入原价 返回现价
- (NSInteger)heixinShangjia :(CGFloat)numb{
    
    if (numb - (NSInteger)numb > 0) {
        return numb + 1;
    }else{
        return numb;
    }
    
}



- (CGFloat)getWeight :(CGFloat)weight{
    
    CGFloat moneyCount = [ZRSupermarketHomeObj shareInstance].allPrice;
    if (moneyCount < 30) {
        return [self heixinShangjia:weight];
    }else if (moneyCount >= 30 && moneyCount < 60){
        if ([self heixinShangjia:weight] - 3 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 3) ;
        }
    }else if (moneyCount >= 60 && moneyCount < 90){
        if ([self heixinShangjia:weight] - 6 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 6);
        }
    }else if(moneyCount >= 90 && moneyCount < 120){
        if ([self heixinShangjia:weight] - 9 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 9);
        }
    }else if (moneyCount>= 120 && moneyCount < 150){
        if ([self heixinShangjia:weight] - 12 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 12);
        }
    }else if (moneyCount>= 150 && moneyCount < 180){
        if ([self heixinShangjia:weight] - 15 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 15);
        }
    }else{
        if ([self heixinShangjia:weight] - 18 <= 0) {
            return 0;
        }else{
            return ([self heixinShangjia:weight] - 18);
        }
    }
}

- (void)createWeateLabei:(UITableViewCell *)cell{
    
    UILabel * lab = [UILabel new];
//    lab.text = @"因特殊天气包含额外费用(*";
    lab.text = [NSString stringWithFormat:@"因特殊天气包含额外费用(x%.1f)",_weather];
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:12];
    lab.numberOfLines = 0;
    [self.view addSubview:lab];
    
    WS(ws)
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.myTableView.mas_bottom).offset(-55);
        make.left.equalTo(ws.view.mas_left).offset(15);
        make.right.equalTo(ws.view.mas_right);
    }];
    
    UIButton * btn = [UIButton new];
    [btn setImage:[UIImage imageNamed:@"wenhao_hong"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(wenhaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(ws.view.mas_left).offset(15);
        make.bottom.equalTo(lab.mas_top).offset(10);
    }];
    
}

- (void)wenhaoBtnClick{
    ZRExplainViewController * explainVC = [[ZRExplainViewController alloc] init];
    explainVC.type = 2;
    explainVC.title = @"天气系数说明";
    
    [self.navigationController pushViewController:explainVC animated:YES];
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
