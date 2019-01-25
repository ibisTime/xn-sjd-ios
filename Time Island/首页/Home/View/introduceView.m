//
//  introduceView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "introduceView.h"

@interface introduceView ()<UIWebViewDelegate>
{
//    NSString *webViewHeight1;
    int height;
}
@property (nonatomic,assign)  NSString *webViewHeight1;

@end

@implementation introduceView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.detail = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    self.detail.textColor = kBlackColor;
////    [self]
//    [self.detail loadHTMLString:self.web baseURL:nil];
//    [self.view addSubview:self.detail];
    self.detail = [[UIWebView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 200)];
    self.detail.delegate = self;
    [self.detail loadHTMLString:self.web baseURL:nil];
    self.webViewHeight1 = [self.detail stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
    height = [self.webViewHeight1 intValue];
    NSLog(@"%d",height);
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height + 200)];
    
    UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(20) textColor:kBlackColor];
    titlelab.numberOfLines = 0;
    titlelab.text = self.IntroduceTitle;
    [self.scrollview addSubview:titlelab];
    
    UILabel * timelab = [UILabel labelWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 50) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(20) textColor:kBlackColor];
    timelab.text = self.time;
    [self.scrollview addSubview:timelab];
    
    
    
    [self.scrollview addSubview:self.detail];
    [self.view addSubview:self.scrollview];
}
- (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
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
