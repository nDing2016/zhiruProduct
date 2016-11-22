//
//  ZRPointsRuleController.m
//  zhiruProduct
//
//  Created by pj on 16/9/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointsRuleController.h"
#import "ZRStringWithLabel.h"
#import "ZRPointsRuleView.h"
@interface ZRPointsRuleController ()<UIWebViewDelegate>

@end

@implementation ZRPointsRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"积分规则"];
    [self.view setBackgroundColor:RGBCOLOR(251, 251, 251)];
    
    // 5s: 920.185547
    // 6: 847.390625
    // 6s plus : 779.369141
    
//    CGFloat scrollContentHeight;
//    
//    if (ScreenWidth == 320.0f) {
//        scrollContentHeight = 921;
//    } else if (ScreenWidth == 375.0f) {
//        scrollContentHeight = 848;
//    } else if (ScreenWidth == 414.0f) {
//        scrollContentHeight = 780;
//    }
//    
//    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
//    [scrollView setContentSize:CGSizeMake(ScreenWidth, scrollContentHeight + 20)];
//    [self.view addSubview:scrollView];
//    
//    
//    ZRPointsRuleView * ruleView = [[ZRPointsRuleView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 1000)];
//    [ruleView setFrame:CGRectMake(15, 0, ScreenWidth - 30, scrollView.contentSize.height)];
//    [ruleView setBackgroundColor:[UIColor clearColor]];
//    [scrollView addSubview:ruleView];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [webView setDelegate:self];
//    @"http://192.168.2.10:8181/manage/agreement/IntegralRule.html"
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[HOST stringByAppendingString:@"agreement/IntegralRule.html"]]]];
    [self.view addSubview:webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [CustomHudView show];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [CustomHudView dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [CustomHudView dismiss];
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
