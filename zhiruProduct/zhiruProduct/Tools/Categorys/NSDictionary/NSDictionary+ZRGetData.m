//
//  NSDictionary+ZRGetData.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "NSDictionary+ZRGetData.h"
#import "ZRRegionModel.h"
#import "ZRLabelModel.h"

@implementation NSDictionary (ZRGetData)

+ (NSDictionary *)dictionaryGetScreeningWithModel :(ZRHomeNavModel *)model {
    
    //地理
    NSMutableArray * regionMarr = [NSMutableArray array];
    for (ZRRegionModel * region in model.region) {
        if (region.region_name != nil) {
            [regionMarr addObject:region.region_name];
        }
        
    }
    //品类
    NSMutableArray * labelMarr = [NSMutableArray array];
    for (ZRLabelModel * label in model.label) {
        if (label.nav_name != nil) {
            [labelMarr addObject:label.nav_name];
        }
    }
    
    return @{@"地理":regionMarr,@"品类":labelMarr,@"排序":@[@"900",@"1000",@"2300"],@"筛选":@[@"1",@"2",@"3"]};
}
@end
