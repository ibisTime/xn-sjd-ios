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
        self.ShopNameBtn.tag = 100-1;
        [self.ShopNameBtn addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.ShopNameBtn];

        //下单时间
        self.OrderTime = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 139, 9.5, 72.5, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
        [self addSubview:self.OrderTime];
        
        //订单状态
        self.StateLab = [UILabel labelWithFrame:CGRectMake(self.OrderTime.xx + 10, 9.5, 73 - 15, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#FE5656 ")];
        [self addSubview:self.StateLab];
        
        //底线
        UIView * lineview1 = [self createview:CGRectMake(15, 35, SCREEN_WIDTH - 30, 1)];
        [self addSubview:lineview1];
        
        //商品图片
        self.GoodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, lineview1.yy + 15, 75, 75)];
        [self addSubview:self.GoodsImage];
        
        //商品名称
        self.GoodsName = [UILabel labelWithFrame:CGRectMake(self.GoodsImage.xx + 10, self.GoodsImage.y, 0, 21) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        [self addSubview:self.GoodsName];

        
        //商品数量
        self.GoodsCount = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 100, lineview1.yy + 17.5, 85, 16.5) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(12) textColor:kTextColor2];
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
        
        
        //底线
        UIView * lineview = [self createview:CGRectMake(15, self.GoodsMoney.yy + 18.5, SCREEN_WIDTH - 30, 1)];
        [self addSubview:lineview];
        
        //底部按钮
        
        NSLog(@"state = %d",self.OrderState);
        

    }
    return self;
}

-(void)setOrderState:(int)OrderState{
    _OrderState = OrderState;
    if (OrderState == 1) {
        self.StateLab.text = @"待付款";
        self.StateLab.textColor = kHexColor(@"#FE5656");
        [self addSubview:[self CreateButtonWithFrame:CGRectMake(SCREEN_WIDTH - 90, self.GoodsMoney.yy + 27, 75, 28) Title:@"删除订单" Color:kTextColor2 tag:101]];
    }
    else if (OrderState == 2){
        self.StateLab.text = @"待收货";
        self.StateLab.textColor = kTextColor3;
        
    }
    else if (OrderState == 3){
        self.StateLab.text = @"待发货";
        self.StateLab.textColor = kTextColor3;
    }
    else if (OrderState == 4){
        self.StateLab.text = @"待评价";
        self.StateLab.textColor = kTextColor3;
    }
}



-(UIView * )createview:(CGRect)frame{
    UIView * view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kLineColor;
    return view;
}
- (void)clickDeleteButton:(UIButton *)sender

{
    [_delagate MallOrderCell:self clickDeleteButton:sender];
}


-(UIButton * )CreateButtonWithFrame : (CGRect)frame Title : (NSString * )title Color : (UIColor * )color tag : (int)tag
{
    UIButton * btn = [UIButton buttonWithTitle:title titleColor:color backgroundColor:kClearColor titleFont:12 cornerRadius:2];
    btn.frame = frame;
    btn.layer.borderColor = color.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
