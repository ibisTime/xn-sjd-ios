//
//  OrderView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderView.h"
#import "OrderFootCell.h"
#import "OrderDetailsVC.h"
@interface OrderView ()
@property (nonatomic,strong) TLTableView * table;
@end

@implementation OrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.table registerClass:[OrderFootCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderFootCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.OrderCount = 2;
    }
    else{
        cell.OrderCount = 1;
    }
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140 * 2 - 35 * 1;
    }
    else
        return 140 * 1 - 35 * 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",(int)indexPath.section);
    OrderDetailsVC * vc = [[OrderDetailsVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
