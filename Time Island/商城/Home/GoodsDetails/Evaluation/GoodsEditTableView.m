//
//  GoodsEditTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/12.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsEditTableView.h"

#import "TeamPostCell.h"
@interface GoodsEditTableView()<UITableViewDelegate, UITableViewDataSource>
{
    TeamPostCell *_cell;
    NSInteger row;
}

@end

@implementation GoodsEditTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.evaluationModel.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    _cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!_cell) {
        _cell = [[TeamPostCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    _cell.informationLabel.scalesPageToFit = YES;

    _cell.evaModel = self.evaluationModel[indexPath.row];

    NSArray *photoImg = [self filterImage:self.evaluationModel[indexPath.row].content];
    NSString *name = [self filterHTML:self.evaluationModel[indexPath.row].content];

    
    return _cell;
}


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

- (NSArray *)filterImage:(NSString *)html
{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    
    return resultArray;
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"contentSize"]) {
//
//        _webViewHeight1 = [[_cell.informationLabel stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//        UIWebView *webView = [self viewWithTag:row];
//        webView.frame = CGRectMake(15, 53, SCREEN_WIDTH - 30, _webViewHeight1);
//
////        [self reloadData];
//    }
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_webViewHeight1 > 100) {
//        return 100;
//    }
//    else
    if (indexPath.row == row - 1000) {
        return 60 + _webViewHeight1;
    }
    return 60 + _webViewHeight1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
-(void)dealloc{
    [_cell.informationLabel.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    
}
@end
