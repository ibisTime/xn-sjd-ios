//
//  MallGoodIntroduceTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallGoodIntroduceTableView.h"

#import "MallGoodsInformationCell.h"
#define MallGoodsInformation @"MallGoodsInformationCell"
#import "TeamPostCell.h"
@interface MallGoodIntroduceTableView()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>
{
    TeamPostCell *_cell;
    NSInteger tag;
}

@end

@implementation MallGoodIntroduceTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MallGoodsInformationCell class] forCellReuseIdentifier:MallGoodsInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.evaluationModel.count > 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 2) {
        return self.evaluationModel.count;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MallGoodsInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:MallGoodsInformation forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.treeModel = self.treeModel;
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = @"规格：选择规格分类";
        cell.textLabel.font = FONT(13);
        return cell;
    }
    
    
    
    static NSString *CellIdentifier = @"Cell";
    // 通过唯一标识创建cell实例
    _cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!_cell) {
        _cell = [[TeamPostCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.evaModel = self.evaluationModel[indexPath.row];
    
    return _cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 135;
    }
    if (indexPath.section == 1) {
        return 55;
    }
    EvaluationModel * model = self.evaluationModel[indexPath.row];
    
    CGFloat height =  [self getcellheight:model.content];
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
    
    
    if (section == 1) {
        return 10;
    }
    if (section == 2) {
        return 46;
    }
    return 0.1;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 36)];
        backView.backgroundColor = kWhiteColor;
        [headView addSubview:backView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, 50, 21) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        nameLbl.text = @"评价";
        [backView addSubview:nameLbl];
        
        UIButton *allBtn = [UIButton buttonWithTitle:@"查看全部" titleColor:kHexColor(@"#999999") backgroundColor:kClearColor titleFont:13];
        allBtn.frame = CGRectMake(SCREEN_WIDTH - 120, 15, 105, 21);
        allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [allBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"积分更多") forState:(UIControlStateNormal)];
        }];
        [allBtn addTarget:self action:@selector(selectmore) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:allBtn];

        return headView;
    }
    return [UIView new];
}
-(void)selectmore{
    if (self.more) {
        self.more();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
