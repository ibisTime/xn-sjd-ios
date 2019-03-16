//
//  ShopCartPayTableview.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/8.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ShopCartPayTableview.h"
#import "ShopCartPayCell.h"

@interface ShopCartPayTableview()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ShopCartPayTableview

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ShopcartPayModels.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ShopcartPayModels[section].commodityOrderDetails.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    ShopCartPayCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[ShopCartPayCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        cell.model = [commodityOrderDetailModel mj_objectWithKeyValues:self.ShopcartPayModels[indexPath.section].commodityOrderDetails[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel * shopname = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(14) textColor:kBlackColor];
    shopname.text = self.ShopcartPayModels[section].shop[@"name"];
    [view addSubview:shopname];
    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 29, SCREEN_WIDTH - 30, 1)];
    v1.backgroundColor = kLineColor;
    [view addSubview:v1];
    return view;
}
@end
