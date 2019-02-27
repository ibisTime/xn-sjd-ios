//
//  OrderFootCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderFootCell.h"

@implementation OrderFootCell
{
     UILabel * OrderIdlab;
     UILabel * OrderStatelab;
    
     UIImageView * TreeImage;
     UILabel * TreeName;
     UILabel * treeAddress;
     UILabel * TreeAge;
     UILabel * TreeMoney;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.height = 140 * 4 - 35 * 2;
        //编号
        OrderIdlab = [[UILabel alloc]initWithFrame:CGRectMake(15, 9.5, SCREEN_WIDTH - 40 - 30, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#666666")];
//        self.OrderIdlab.text = @"D2986508238869";
        [self addSubview:OrderIdlab];
        
        //状态
        OrderStatelab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15, 9.5, 40, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FE5656")];
        OrderStatelab.text = @"待支付";
        [self addSubview:OrderStatelab];
//        self.OrderCount = 3;
//    }
//    return self;
//}
//
//-(void)setOrderCount:(NSInteger)OrderCount
//{
//    self.count = OrderCount;
//
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = kLineColor;
    view.frame = CGRectMake(15, 35, SCREEN_WIDTH - 30, 1);
    [self addSubview:view];
//    for (int i = 0; i < self.count; i ++ ) {
        //左边图片
//        self.TreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,51 + 104 * i, 75, 75)];
        TreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,51, 75, 75)];
        TreeImage.image = kImage(@"baner1");
        [self.contentView addSubview:TreeImage];
        
        //树的名字
        TreeName = [UILabel labelWithFrame:CGRectMake(TreeImage.xx + 15, TreeImage.y, 0, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
        [self addSubview:TreeName];
        TreeName.text = @"树的名字";
        [TreeName sizeToFit];
        if (TreeName.width > SCREEN_WIDTH - 100) {
            TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, SCREEN_WIDTH - 100, 21);
        }
        else{
            TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, TreeName.width, 21);
        }
        
        //树的所在位置
        treeAddress = [UILabel labelWithFrame:CGRectMake( TreeName.x,  TreeName.yy + 8.5, 0, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        [self addSubview:treeAddress];
        treeAddress.text = @"浙江 杭州";
        [treeAddress sizeToFit];
        if (treeAddress.width > SCREEN_WIDTH - 100) {
            treeAddress.frame = CGRectMake( TreeName.x,  TreeName.yy + 8.5, SCREEN_WIDTH - 100, 16.5);
        }
        else{
            treeAddress.frame = CGRectMake( TreeName.x,  TreeName.yy + 8.5,treeAddress.width, 16.5);
        }
        
        //树的年限
        TreeAge = [UILabel labelWithFrame:CGRectMake( TreeName.x,  treeAddress.yy + 12.5, 70, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        TreeAge.text = @"年限：1年";
        [self addSubview:TreeAge];
        
        //金额
        TreeMoney = [UILabel labelWithFrame:CGRectMake( TreeAge.xx + 143,  TreeName.yy + 36, 61, 18) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#333333")];
        TreeMoney.text = @"¥2480.00";
        [self addSubview:TreeMoney];
        
//        if (i <  OrderCount - 1) {
//            [self addSubview:[self createview:CGRectMake(15,  TreeMoney.yy + 15, SCREEN_WIDTH - 30, 1)]];
//        }
        }
    return self;
}


-(void)setOrderModel:(OrderModel *)OrderModel{
    [TreeImage sd_setImageWithURL:[NSURL URLWithString: [OrderModel.product[@"listPic"] convertImageUrl]]];
    OrderIdlab.text = OrderModel.code;
    TreeName.text = OrderModel.product[@"name"];
    [TreeName sizeToFit];
    if (TreeName.width > SCREEN_WIDTH - 100) {
        TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, SCREEN_WIDTH - 100, 21);
    }
    else{
        TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, TreeName.width, 21);
    }
    treeAddress.text = [NSString stringWithFormat:@"%@ %@ %@",OrderModel.product[@"province"],OrderModel.product[@"city"],OrderModel.product[@"area"]];
    [treeAddress sizeToFit];
    if (treeAddress.width > SCREEN_WIDTH - 100) {
        treeAddress.frame = CGRectMake( TreeName.x,  TreeName.yy + 8.5, SCREEN_WIDTH - 100, 16.5);
    }
    else{
        treeAddress.frame = CGRectMake( TreeName.x,  TreeName.yy + 8.5,treeAddress.width, 16.5);
    }
    TreeAge.text = [NSString stringWithFormat:@"年限：%@年",OrderModel.adoptYear];
    float payAmount = [OrderModel.payAmount floatValue] / 1000.00;
    TreeMoney.text = [NSString stringWithFormat:@"¥ %.2f",payAmount];
    
    int status = [OrderModel.status intValue];
    switch (status) {
        case 3:
            OrderStatelab.text = @"认养中";
            break;
        case 1:
            OrderStatelab.text = @"已取消";
            break;
        default:
            break;
    }
}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
@end
