//
//  MyHomePageTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/10.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MyHomePageTableView.h"
#import "MyHomePageCell.h"
#define MyHomePage @"MyHomePageCell"

@interface MyHomePageTableView()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation MyHomePageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MyHomePageCell class] forCellReuseIdentifier:MyHomePage];

        
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    MyHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:MyHomePage forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *imageAry = @[@"泡泡",@"我的礼物",@"我的通知",@"设置"];
    NSArray *nameArray = @[@"我的碳泡泡",@"我的礼物",@"我的通知",@"设置"];
    cell.iconImage.image = kImage(imageAry[indexPath.row]);
    cell.nameLabel.text = nameArray[indexPath.row];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return 55;
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
