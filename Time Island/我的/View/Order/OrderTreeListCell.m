//
//  OrderTreeListCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/27.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderTreeListCell.h"

@implementation OrderTreeListCell{
    UILabel * OrderIdlab;
//    UILabel * OrderStatelab;
    
    UIImageView * TreeImage;
    UILabel * TreeName;
//    UILabel * treeAddress;
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

        TreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,12.5, 75, 75)];
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
        

        
        //树的年限
        TreeAge = [UILabel labelWithFrame:CGRectMake( TreeName.x,  TreeImage.yy - 16.5, 70, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
        TreeAge.text = @"年限：1年";
        [self addSubview:TreeAge];
        
        //金额
        TreeMoney = [UILabel labelWithFrame:CGRectMake( TreeAge.xx + 143,  TreeImage.yy - 18, 61, 18) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#333333")];
        TreeMoney.text = @"¥2480.00";
        [self addSubview:TreeMoney];
    }
    return self;
}

-(void)setOrderModel:(OrderModel *)OrderModel{
    _OrderModel = OrderModel;
}

-(void)setTreeList:(NSDictionary *)treeList{
    [TreeImage sd_setImageWithURL:[NSURL URLWithString: [treeList[@"pic"] convertImageUrl]]];
    TreeName.text = treeList[@"treeNumber"];
    [TreeName sizeToFit];
    if (TreeName.width > SCREEN_WIDTH - 100) {
        TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, SCREEN_WIDTH - 100, 21);
    }
    else{
        TreeName.frame = CGRectMake(TreeImage.xx + 15, TreeImage.y, TreeName.width, 21);
    }
    TreeAge.text = [NSString stringWithFormat:@"树龄：%@年",treeList[@"age"]];
    float payAmount = [self.OrderModel.payAmount floatValue] / 1000.00;
    TreeMoney.text = [NSString stringWithFormat:@"¥ %.2f",payAmount];
}
-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}

@end
