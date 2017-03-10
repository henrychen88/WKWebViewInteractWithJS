//
//  ViewController.m
//  WKWebViewInteractWithJS
//
//  Created by Henry on 2017/3/9.
//  Copyright © 2017年 Henry. All rights reserved.
//

#import "ViewController.h"

#import "HTMLViewController.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    
}

- (void)jump
{
    [self.navigationController pushViewController:[HTMLViewController new] animated:YES];
}


@end
