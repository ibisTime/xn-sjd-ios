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
@interface MallGoodIntroduceTableView()<UITableViewDelegate, UITableViewDataSource>
{
    TeamPostCell *_cell;
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
    _cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (_cell == nil) {
        _cell = [[TeamPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
    return _cell.lineView.frame.origin.y + 0.5;
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
        [backView addSubview:allBtn];

        return headView;
    }
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
