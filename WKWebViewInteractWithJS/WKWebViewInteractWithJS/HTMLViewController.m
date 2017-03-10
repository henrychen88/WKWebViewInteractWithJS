//
//  HTMLViewController.m
//  WKWebViewInteractWithJS
//
//  Created by Henry on 2017/3/9.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import "HTMLViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
#import "DestinationViewController.h"

@interface HTMLViewController ()<WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) WKWebViewJavascriptBridge* bridge;

@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.webView];
    
    [self loadHtml];
    
    [self setupWebViewJavascriptBridge];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"随机数" style:UIBarButtonItemStylePlain target:self action:@selector(methodTest)];
    
}

- (void)loadHtml
{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"test1" ofType:@"html"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];

    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
}

- (void)setupWebViewJavascriptBridge
{
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    [WKWebViewJavascriptBridge enableLogging];
    
    
    __weak typeof(self) weakSelf = self;
    [self.bridge registerHandler:@"JSCallObjc" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"data : %@", data);
        
        [weakSelf.navigationController pushViewController:[DestinationViewController new] animated:YES];
    }];
    
}

- (void)methodTest
{
    NSString *val = [NSString stringWithFormat:@"%d", arc4random_uniform(100000)];
    [self.bridge callHandler:@"ObjcCallJS" data:val responseCallback:^(id responseData) {
        NSLog(@"responseData : %@", responseData);
    }];
}

- (void)dealloc
{
    NSLog(@"HTMLVieweController dealloc");
}

#pragma mark - navigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"结束加载");
}

#pragma mark - Lazy Load

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

@end
