//
//  MallOrderCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/21.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallOrderCell.h"

@implementation MallOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //店铺名称
        self.ShopNameBtn = [UIButton buttonWithTitle:@"店铺名称" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:12];
        [self addSubview:self.ShopNameBtn];

        
        
        //下单时间
        self.OrderTime = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 139, 9.5, 72.5, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.OrderTime];
        
        //订单状态
        self.OrderState = [UILabel labelWithFrame:CGRectMake(self.OrderTime.xx + 10, 9.5, 73 - 15, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FE5656 ")];
        [self addSubview:self.OrderState];
        
        //底线
        UIView * lineview = [self createview:CGRectMake(15, 35, SCREEN_WIDTH - 30, 1)];
        [self addSubview:lineview];
        
        //商品图片
        self.GoodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineview.yy + 15, 75, 75)];
        [self addSubview:self.GoodsImage];
        
        //商品名称
        self.GoodsName = [UILabel labelWithFrame:CGRectMake(self.GoodsImage.xx + 10, self.GoodsImage.y, 0, 21) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
//        self.GoodsName.text = @"商品名称";
        [self addSubview:self.GoodsName];
        [self.GoodsName sizeToFit];
        if (self.GoodsName.width > SCREEN_WIDTH - 100 - 100) {
            self.GoodsName.frame = CGRectMake(self.GoodsImage.xx + 10, self.GoodsImage.y,SCREEN_WIDTH - 100 - 100, 21);
        }
        else
        {
            self.GoodsName.frame = CGRectMake(self.GoodsImage.xx + 10, self.GoodsImage.y,self.GoodsName.width, 21);
        }
        
        
        //商品数量
        self.GoodsCount = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 100, lineview.yy + 17.5, 85, 16.5) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.GoodsCount];
        
        //商品描述
        self.GoodsDescribe = [UILabel labelWithFrame:CGRectMake(self.GoodsName.x, self.GoodsName.yy + 8.5, SCREEN_WIDTH - 115, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.GoodsDescribe];
        
        //商品统计
        self.GoodsTotal = [UILabel labelWithFrame:CGRectMake(self.GoodsName.x, self.GoodsDescribe.yy + 12.5, SCREEN_WIDTH - 176, 16.5) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.GoodsTotal];
        
        //商品价格
        self.GoodsMoney = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 61, self.GoodsDescribe.yy + 11, 61, 18) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kBlackColor];
        [self addSubview:self.GoodsMoney];
        
        
        
        
        
        
    }
    return self;
}

-(UIView * )createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
//-(void)setShopName:(UILabel *)ShopName{
//    
//}
@end
