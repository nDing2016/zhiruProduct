//
//  ZRAgreementViewController.m
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//


// 用户使用协议
#import "ZRAgreementViewController.h"
@interface ZRAgreementViewController ()<UIWebViewDelegate>

@end

@implementation ZRAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self setTitle:@"用户服务协议"];
    [self.view setBackgroundColor:RGBCOLOR(251, 251, 251)];

    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [webView setDelegate:self];
    [self.view addSubview:webView];
    
//    @"http://192.168.2.10:8181/manage/agreement/UserAgreement.html"
    NSURLRequest * quest = [NSURLRequest requestWithURL:[NSURL URLWithString:[HOST stringByAppendingString:@"agreement/UserAgreement.html"]]];
    [webView loadRequest:quest];
    
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
