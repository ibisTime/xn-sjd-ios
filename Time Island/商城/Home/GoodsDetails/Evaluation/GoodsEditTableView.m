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
//    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[TeamPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell.evaModel = self.evaluationModel[indexPath.row];
    
    [_cell.informationLabel loadHTMLString:self.evaluationModel[indexPath.row].content baseURL:nil];
    [_cell.informationLabel.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    return _cell;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        _webViewHeight1 = [[_cell.informationLabel stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        _cell.informationLabel.frame = CGRectMake(15, 53, SCREEN_WIDTH - 30, _webViewHeight1);
        [self reloadData];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (_webViewHeight1 > 100) {
//        return 100;
//    }
//    else
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
