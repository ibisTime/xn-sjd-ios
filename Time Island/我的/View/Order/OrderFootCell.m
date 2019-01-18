//
//  OrderFootCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderFootCell.h"

@implementation OrderFootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //n编号
        self.OrderIdlab = [[UILabel alloc]initWithFrame:CGRectMake(15, 9.5, SCREEN_WIDTH - 40 - 30, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#666666")];
        self.OrderIdlab.text = @"D2986508238869";
        [self addSubview:self.OrderIdlab];
        
        //状态
        self.OrderStatelab = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 15, 9.5, 40, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FE5656")];
        self.OrderStatelab.text = @"待支付";
        [self addSubview:self.OrderStatelab];
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = kLineColor;
        view.frame = CGRectMake(15, 35, SCREEN_WIDTH - 30, 1);
        [self addSubview:view];
        
        self.OrderCount = 2;
        for (int i = 0; i < self.OrderCount; i ++ ) {
            //左边图片
//            self.TreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,51 + 105 * i, 75, 75)];
//            self.TreeImage.image = kImage(@"baner1");
//            [self.contentView addSubview:self.TreeImage];
            
            self.TreeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15,51 + 104 * i, 75, 75)];
            self.TreeImage.image = kImage(@"baner1");
            [self.contentView addSubview:self.TreeImage];

            
            //树的名字
            self.TreeName = [[UILabel alloc]initWithFrame:CGRectMake(self.TreeImage.xx + 15, self.TreeImage.y, 0, 21) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#333333")];
            [self addSubview:self.TreeName];
            self.TreeName.text = @"树的名字";
            [self.TreeName sizeToFit];
            if (self.TreeName.width > SCREEN_WIDTH - 100) {
                self.TreeName.frame = CGRectMake(self.TreeImage.xx + 15, self.TreeImage.y, SCREEN_WIDTH - 100, 21);
            }
            else{
                self.TreeName.frame = CGRectMake(self.TreeImage.xx + 15, self.TreeImage.y, self.TreeName.width, 21);
            }
            
            //树的所在位置
            self.treeAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.TreeName.x, self.TreeName.yy + 8.5, 0, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
            [self addSubview:self.treeAddress];
            self.treeAddress.text = @"浙江 杭州";
            [self.treeAddress sizeToFit];
            if (self.treeAddress.width > SCREEN_WIDTH - 100) {
                self.treeAddress.frame = CGRectMake(self.TreeName.x, self.TreeName.yy + 8.5, SCREEN_WIDTH - 100, 16.5);
            }
            else{
                self.treeAddress.frame = CGRectMake(self.TreeName.x, self.TreeName.yy + 8.5, self.treeAddress.width, 16.5);
            }
            
            //树的年限
            self.TreeAge = [[UILabel alloc]initWithFrame:CGRectMake(self.TreeName.x, self.treeAddress.yy + 12.5, 70, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
            self.TreeAge.text = @"年限：1年";
            [self addSubview:self.TreeAge];
            
            //金额
            self.TreeMoney = [[UILabel alloc]initWithFrame:CGRectMake(self.TreeAge.xx + 143, self.TreeName.yy + 36, 61, 18) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#333333")];
            self.TreeMoney.text = @"¥2480.00";
            [self addSubview:self.TreeMoney];
            
            
            if (i < self.OrderCount - 1) {
                [self addSubview:[self createview:CGRectMake(15, self.TreeMoney.yy + 15, SCREEN_WIDTH - 30, 1)]];
            }
            
        }
        
        
        
        
    }
    return self;
}

-(UIView*)createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
@end
