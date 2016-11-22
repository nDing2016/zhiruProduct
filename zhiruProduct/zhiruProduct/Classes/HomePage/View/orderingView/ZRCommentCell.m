//
//  ZRCommentCell.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCommentCell.h"
#import "ZROrderingCommentCell.h"
#import "ZROrderingComment.h"

@interface ZRCommentCell ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * myTableView;
@property (nonatomic , assign) CGFloat offsetY;
@end


@implementation ZRCommentCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)setModel:(ZRCommentListModel *)model {
    _model = model;
    self.myTableView.delegate = self;
}

- (UITableView *)myTableView{
    if (_myTableView == nil ) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,self.contentView.height   ) style:UITableViewStylePlain];
        
        [self addSubview:_myTableView];
        
        _myTableView.backgroundColor = [UIColor clearColor];
        
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.estimatedRowHeight = 120.0;
        
        ZROrderingComment * headView = [[[NSBundle mainBundle] loadNibNamed:@"ZROrderingComment" owner:self options:nil] lastObject];
        headView.frame = CGRectMake(0, 0, self.contentView.width, headView.height);
        
        _myTableView.tableHeaderView = headView;
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    
    }
    return _myTableView;
}

#pragma mark - tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * Cell = @"CommentCell";
    ZROrderingCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if (commentCell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ZROrderingCommentCell class]) owner:self options:nil];
        commentCell = [nibs lastObject];
    }
    
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return commentCell;
}


#pragma mark -- 监听滑动距离
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    //89

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tableViewDidScroll" object:nil userInfo:@{@"offsetY":@(offsetY - _offsetY)}];

    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    

    _offsetY = scrollView.contentOffset.y;
    
}
@end
