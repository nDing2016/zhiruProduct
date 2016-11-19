//
//  ZRShoppingCarView.m
//  zhiruProduct
//
//  Created by nanding on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarView.h"
#import "ZRSupermarketHomeObj.h"
#import "ZRShoppingCarCell.h"

#define kToolHeight          (30*SCREEN_HEIGHT/667)
#define kCellHeight          (44*SCREEN_HEIGHT/667)

@interface ZRShoppingCarView ()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation ZRShoppingCarView


#pragma mark - 懒加载

-(UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kToolHeight)];
        UIButton *shoppingCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, kToolHeight)];
        [shoppingCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
        [shoppingCarBtn setTitleColor:RGBCOLOR(85, 85, 85) forState:UIControlStateNormal];
        shoppingCarBtn.titleLabel.font = CustomFont(15);
        shoppingCarBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [shoppingCarBtn addTarget:self action:@selector(shoppingCarClick:) forControlEvents:UIControlEventTouchUpInside];
        //UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"购物车" style:UIBarButtonItemStylePlain target:self action:nil];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:shoppingCarBtn];
        
        UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 50, kToolHeight)];
        [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
        [clearBtn setTitleColor:RGBCOLOR(85, 85, 85) forState:UIControlStateNormal];
        clearBtn.titleLabel.font = CustomFont(15);
        clearBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [clearBtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *btnPlace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        //UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick:)];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
        _toolBar.items = @[leftItem,btnPlace, rightItem];
        
        
    }
    return _toolBar;
}


-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kToolHeight, SCREEN_WIDTH, self.height-self.toolBar.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        
    }
    _tableView.frame = CGRectMake(0, kToolHeight, SCREEN_WIDTH, self.height-self.toolBar.height);
    return _tableView;
}


#pragma mark - init methods
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.toolBar];
        [self addSubview:self.tableView];
        
    }
    return self;
}


#pragma mark - UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = self.allArray.count;
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZRShoppingCarCell *cell = [ZRShoppingCarCell cellWithTable:self.tableView IndexPath:indexPath];
    

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *productsArr = self.allArray[indexPath.row];
    
    cell.num = productsArr.count;
    cell.idxPath = indexPath;
    cell.viewTag = self.Tag;

    cell.model = productsArr[0];
    
    
    return cell;
}



#pragma mark - click methods
/**
 *  清空
 *
 *  @param sender
 */
- (void)rightItemClick:(UIButton *)sender
{
    
    if (self.Tag == kSupermarketShoppingCar_Tag) {
        //model数据更新
        [ZRSupermarketHomeObj shareInstance].allNumber = 0;
        [ZRSupermarketHomeObj shareInstance].allPrice = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kClearShoppingCar_Noti object:nil];
        //直接删除cell
        [[ZRSupermarketHomeObj shareInstance].allProductsArray removeAllObjects];
        //刷新tableView
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingCarReloadData" object:nil];
        
    }else if (self.Tag == kWaimaiShoppingCar_Tag){
        [ZRSupermarketHomeObj shareInstance].totalNumber = 0;
        [ZRSupermarketHomeObj shareInstance].totalPrice = 0;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWaimaiClearshoppingCar_Noti object:nil];
        //直接删除cell
        [[ZRSupermarketHomeObj shareInstance].selectedFoodsArray removeAllObjects];
        
        //刷新tableView
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingCarReloadData" object:nil];
        

    }
    
    
}

/**
 *  跳转到购物车
 */
- (void)shoppingCarClick:(UIButton *)sender
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
