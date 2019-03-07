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
        _cell.userInteractionEnabled = NO;
    }
    


    _cell.evaModel = self.evaluationModel[indexPath.row];

    
    return _cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    EvaluationModel * model = self.evaluationModel[indexPath.row];
    CGFloat height = [self getcellheight:model.content];
    if ([self.evaluationModel[indexPath.row].content containsString:@"<img"]) {
        return 60 + height + 115;
    }
    return 60 + height ;
}
-(CGFloat)getcellheight:(NSString *)content{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15,0, SCREEN_WIDTH - 30, 10)];
    label.numberOfLines = 0;
    NSRange startRange = [content rangeOfString:@"<p>"];
    NSRange endRange = [content rangeOfString:@"</p>"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString * title = [content substringWithRange:range];
    label.text = title;
    [label sizeToFit];
    return label.height;
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

@end
