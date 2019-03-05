//
//  MallCancelOrderCell.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallCancelOrderCell.h"

@implementation MallCancelOrderCell

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
        self.ShopNameBtn = [UIButton buttonWithTitle:@"店铺名称" titleColor:kTextColor3 backgroundColor:kClearColor titleFont:14];
        self.ShopNameBtn.tag = 100-1;
        [self.ShopNameBtn addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.ShopNameBtn];
        
        //下单时间
        self.OrderTime = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 139, 9.5, 72.5, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kTextColor2];
        [self addSubview:self.OrderTime];
        
        //订单状态
        self.StateLab = [UILabel labelWithFrame:CGRectMake(self.OrderTime.xx + 10, 9.5, 73 - 15, 16.5) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:FONT(13) textColor:kHexColor(@"#FE5656 ")];
        [self addSubview:self.StateLab];
        
        //底线
        UIView * lineview1 = [self createview:CGRectMake(15, 35.5, SCREEN_WIDTH - 30, 1)];
        [self addSubview:lineview1];
        
        //合计价格
        self.TotalMoney = [UILabel labelWithFrame:CGRectMake(15, self.GoodsImage.yy + 15, SCREEN_WIDTH - 30, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:FONT(16) textColor:kBlackColor];
        [self addSubview:self.TotalMoney];
        
        
        
        //底部按钮
        
        NSLog(@"state = %d",self.OrderState);
        
        
    }
    return self;
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


-(void)setModel:(MallCancelOrderModel *)model{
    _model = model;
    
    [self.ShopNameBtn setTitle:model.shopName forState:(UIControlStateNormal)];
    //店铺名称
    //商店名称自适应
    [self.ShopNameBtn sizeToFit];
    if (self.ShopNameBtn.width > SCREEN_WIDTH / 2 - 15 - 10.5) {
        self.ShopNameBtn.frame = CGRectMake(15, 4.5, SCREEN_WIDTH / 2 - 15 - 10.5, 26.5);
    }
    else{
        self.ShopNameBtn.frame = CGRectMake(15, 4.5, self.ShopNameBtn.width + 15, 26.5);
    }
    
    [self.ShopNameBtn SG_imagePositionStyle:SGImagePositionStyleRight spacing:3.5 imagePositionBlock:^(UIButton *button) {
        [button setImage:kImage(@"跳转") forState:UIControlStateNormal];
    }];
    
    
    //下单时间
    self.OrderTime.text = [model.applyDatetime convertToDetailDate];
    [self.OrderTime sizeToFit];
    self.OrderTime.frame = CGRectMake(SCREEN_WIDTH - self.OrderTime.width - 5 - 58, 9.5, self.OrderTime.width, 16.5);
    
    //订单状态
    int OrderState = [model.status intValue];
    if (OrderState == 1) {
        self.StateLab.text = @"待发货";
        self.StateLab.textColor = kTextColor3;
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
    else if (OrderState == 5){
        self.StateLab.text = @"已取消";
        self.StateLab.textColor = kTextColor3;
    }
    
    for (int i = 0; i < 1; i++) {
        [self addview:CGRectMake(0, 50.5 + 90 * i, SCREEN_WIDTH, 90)];
        //商品图片
        [self.GoodsImage sd_setImageWithURL:[NSURL URLWithString:[model.listPic convertImageUrl]] placeholderImage:kImage(@"树 跟背景")];
        //商品名称
        self.GoodsName.text = model.commodityName;
        //商品数量
        self.GoodsCount.text = [NSString stringWithFormat:@"x%@",model.quantity];
        //商品规格
        self.GoodsDescribe.text = [NSString stringWithFormat:@"规格分类：%@",model.specsName];
        //商品统计
        self.GoodsTotal.text = [NSString stringWithFormat:@"合计%@件商品",model.quantity];
        //商品价格
        self.GoodsMoney.text = [NSString stringWithFormat:@"x%.2f",[model.amount floatValue] / 1000];
        
        
        
    }
    UIView * lineview = [self createview:CGRectMake(15, 50.5+90 * 1, SCREEN_WIDTH - 30, 1)];
    [self addSubview:lineview];
    //合计价格
//    if ([model.postalFee isEqualToString:@"0"]) {
        self.TotalMoney.text = [NSString stringWithFormat:@"合计：¥%.2f(%.2f)",[model.amount floatValue]/1000,[model.amount floatValue]/1000];
//    }
//    else{
//        self.TotalMoney.text = [NSString stringWithFormat:@"合计：¥%.2f(%.2f+邮费(%.2f))",[model.amount floatValue]/1000,[model.amount floatValue]/1000,[model.price floatValue]/1000];
//    }
//    if (model.detailList.count == 0) {
//        self.TotalMoney.frame = CGRectMake(15, 50.5 + 15, SCREEN_WIDTH - 30, 40);
//    }else
//    {
        self.TotalMoney.frame = CGRectMake(15, 50.5+90 * 1, SCREEN_WIDTH - 30, 40);
//    }
}
-(void)addview:(CGRect)frame{
    self.details = [[UIView alloc]initWithFrame:frame];
    
    //商品图片
    self.GoodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 75, 75)];
    kViewRadius(self.GoodsImage, 4);
    [self.details addSubview:self.GoodsImage];
    
    //商品名称
    self.GoodsName = [UILabel labelWithFrame:CGRectMake(self.GoodsImage.xx + 10, self.GoodsImage.y + 7, SCREEN_WIDTH - self.GoodsImage.xx - 10 - 50, 20) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:HGboldfont(16) textColor:kTextBlack];
    [self.details addSubview:self.GoodsName];
    
    
    //商品数量
    self.GoodsCount = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 50, self.GoodsImage.y + 7, 35, 20) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(13) textColor:kTextColor2];
    [self.details addSubview:self.GoodsCount];
    
    //商品描述
    self.GoodsDescribe = [UILabel labelWithFrame:CGRectMake(self.GoodsName.x, self.GoodsName.yy + 7, SCREEN_WIDTH - self.GoodsName.x - 15, 15) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(14) textColor:kTextColor2];
    [self.details addSubview:self.GoodsDescribe];
    
    //商品统计
    self.GoodsTotal = [UILabel labelWithFrame:CGRectMake(self.GoodsName.x, self.GoodsDescribe.yy + 7, 100, 15) textAligment:NSTextAlignmentLeft backgroundColor:kClearColor font:FONT(14) textColor:kTextColor2];
    [self.details addSubview:self.GoodsTotal];
    
    //商品价格
    self.GoodsMoney = [UILabel labelWithFrame:CGRectMake(self.GoodsTotal.xx + 10, self.GoodsDescribe.yy + 7, SCREEN_WIDTH - self.GoodsTotal.xx - 25, 18) textAligment:NSTextAlignmentRight backgroundColor:kClearColor font:FONT(13) textColor:kBlackColor];
    [self.details addSubview:self.GoodsMoney];
    
    [self addSubview:self.details];
    
}
@end
