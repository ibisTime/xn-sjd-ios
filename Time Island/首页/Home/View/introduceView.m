//
//  introduceView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "introduceView.h"

@interface introduceView ()<UIWebViewDelegate,UIScrollViewDelegate>
{
//    NSString *webViewHeight1;
    int height;
}
@property (nonatomic,assign)  NSString *webViewHeight1;

@end

@implementation introduceView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detail = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.detail.delegate = self;
    self.detail.scrollView.delegate = self;
    self.detail.scrollView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.detail loadHTMLString:self.web baseURL:nil];
    self.detail.scrollView.contentOffset= CGPointMake(0, -150);

    UIView * headview = [[UIView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
    headview.backgroundColor = kWhiteColor;
    
    UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(20) textColor:kBlackColor];
    titlelab.numberOfLines = 0;
    titlelab.text = self.IntroduceTitle;
    [headview addSubview:titlelab];
    
    UILabel * timelab = [UILabel labelWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 50) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(20) textColor:kBlackColor];
    timelab.text = self.time;
    [headview addSubview:timelab];
    
    [self.detail.scrollView addSubview:headview];
    
    
    
    [self.view addSubview:self.detail];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        webViewHeight1 = [[self.detail stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//        self.detail.frame = CGRectMake(0, 0, SCREEN_WIDTH, webViewHeight1);
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
