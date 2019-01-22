//
//  MallCommentTB.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallCommentTB.h"
#import "CommentCell.h"
@interface MallCommentTB()<UITableViewDelegate, UITableViewDataSource>

@end
static NSString *identifierCell = @"CommentCell";

@implementation MallCommentTB
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        
        [self registerClass:[CommentCell class] forCellReuseIdentifier:identifierCell];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 30;
    }else{
        return 0.01;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        view.backgroundColor = kWhiteColor;
        
        UILabel *commentLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15];
        commentLab.frame = CGRectMake(15, 0, 100, 30);
        commentLab.text = @"评价";
        [view addSubview:commentLab];
        UIButton *button = [UIButton buttonWithTitle:@"查看更多" titleColor:kHexColor(@"#666666") backgroundColor:kClearColor titleFont:12];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        button.frame  = CGRectMake(kScreenWidth - 100, 0, 85, 30);
        [button SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"积分更多") forState:UIControlStateNormal];
        }];
        
        [button addTarget:self action:@selector(MoreClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        return view;

    }else{
        return nil;

    }
}


- (void)MoreClick
{
    if (self.clickMoreBlock) {
        self.clickMoreBlock();
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

@end
