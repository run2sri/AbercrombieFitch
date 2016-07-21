//
//  AFWebViewController.m
//  AbercrombieFitch
//
//  Created by Srinivasan Baskaran on 7/21/16.
//  Copyright © 2016 A&F. All rights reserved.
//

#import "AFWebViewController.h"

@interface AFWebViewController ()
@property (nonatomic, weak) IBOutlet UIWebView *webview;
@end

@implementation AFWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadWebview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper

- (void) loadWebview {
    NSURL *url = [NSURL URLWithString:_webURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
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
