//
//  orderDetailCell.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "orderDetailCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JVShopcartCountView.h"
@interface orderDetailCell()
@property (nonatomic, strong) UIButton *productSelectButton;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLable;
@property (nonatomic, strong) UILabel *productSizeLable;
@property (nonatomic, strong) UILabel *productPriceLable;
@property (nonatomic, strong) JVShopcartCountView *shopcartCountView;
@property (nonatomic, strong) UILabel *productStockLable;
@property (nonatomic, strong) UIView *shopcartBgView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *productTotalLable;
@property (nonatomic, strong) UILabel *countLable;



@end
@implementation orderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectButton];
    
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.arrowImageView];
    
    [self.shopcartBgView addSubview:self.productSizeLable];
//    [self.shopcartBgView addSubview:self.shopcartCountView];
    [self.shopcartBgView addSubview:self.productStockLable];
    [self.shopcartBgView addSubview:self.productTotalLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.countLable];

    [self.shopcartBgView addSubview:self.topLineView];
}

//- (void)configureShopcartCellWithProductURL:(NSString *)productURL productName:(NSString *)productName productSize:(NSString *)productSize productPrice:(NSInteger)productPrice productCount:(NSInteger)productCount productStock:(NSInteger)productStock productSelected:(BOOL)productSelected {
//    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
////    [self.productImageView sd_setImageWithURL:encodingURL];
////    self.productImageView.image = kImage(@"我的背景");
//    self.productNameLable.text = productName;
//    self.productSizeLable.text = productSize;
//    self.countLable.text = @"x1";
//    self.productPriceLable.text = [NSString stringWithFormat:@"￥%ld", productPrice];
//    self.productSelectButton.selected = productSelected;
//    [self.shopcartCountView configureShopcartCountViewWithProductCount:productCount productStock:productStock];
//    self.productStockLable.text = [NSString stringWithFormat:@"库存:%ld", productStock];
//    self.productTotalLable.text = [NSString stringWithFormat:@"合计一件商品"];
//}

- (void)productSelectButtonAction {
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectButton.selected);
    }
}

- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_productSelectButton setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
}

- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}
- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil){
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kImage(@"积分更多");
    }
    return _arrowImageView;
}
- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.font = HGboldfont(14);
        _productNameLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _productNameLable;
}

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont systemFontOfSize:13];
        _productSizeLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productSizeLable;
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        [_productPriceLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        _productPriceLable.textColor = kBlackColor;
        _productPriceLable.textAlignment = NSTextAlignmentRight;
    }
    return _productPriceLable;
}
- (UILabel *)countLable {
    if (_countLable == nil){
        _countLable = [[UILabel alloc] init];
        _countLable.font = [UIFont systemFontOfSize:14];
        _countLable.textColor = kTextColor2;
        _countLable.textAlignment = NSTextAlignmentRight;
    }
    return _countLable;
}
- (UILabel *)productTotalLable {
    if (_productTotalLable == nil){
        _productTotalLable = [[UILabel alloc] init];
        _productTotalLable.font = [UIFont systemFontOfSize:14];
        _productTotalLable.textColor = kTextColor2;
    }
    return _productTotalLable;
}
- (JVShopcartCountView *)shopcartCountView {
    if (_shopcartCountView == nil){
        _shopcartCountView = [[JVShopcartCountView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _shopcartCountView.shopcartCountViewEditBlock = ^(NSInteger count){
            if (weakSelf.shopcartCellEditBlock) {
                weakSelf.shopcartCellEditBlock(count);
            }
        };
    }
    return _shopcartCountView;
}

- (UILabel *)productStockLable {
    if (_productStockLable == nil){
        _productStockLable = [[UILabel alloc] init];
        _productStockLable.font = [UIFont systemFontOfSize:13];
        _productStockLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productStockLable;
}

- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
//    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.shopcartBgView.mas_left).offset(10);
//        make.centerY.equalTo(self.shopcartBgView).offset(-20);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView).offset(15);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.productImageView);
        make.right.equalTo(self.shopcartBgView).offset(-5);
    }];
    [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productImageView);
        make.right.equalTo(self.shopcartBgView).offset(-10);
        make.height.equalTo(@20);

    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productNameLable.mas_right).offset(10);
        make.centerY.equalTo(self.productNameLable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(7, 15));
    }];
    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.productNameLable.mas_bottom).offset(10);
        make.right.equalTo(self.shopcartBgView).offset(-5);
        make.height.equalTo(@20);
    }];
    [self.productTotalLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(10);
        make.top.equalTo(self.productSizeLable.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@120);

    }];
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.productSizeLable.mas_bottom).offset(10);
        make.right.equalTo(self.shopcartBgView).offset(-10);
        make.height.equalTo(@20);

    }];
    
    
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopcartBgView);
        make.bottom.right.equalTo(self.shopcartBgView);
        make.height.equalTo(@0.4);
    }];
}
-(void)setShownum:(NSInteger)shownum{
    _shownum = shownum;
}
-(void)setModel:(MallOrderModel *)model{
    _model = model;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:[model.detailList[self.shownum][@"listPic"] convertImageUrl]] placeholderImage:kImage(@"我的背景")];
    self.productNameLable.text = model.detailList[self.shownum][@"commodityName"];
    self.productSizeLable.text = [NSString stringWithFormat:@"规格分类：%@",model.detailList[self.shownum][@"specsName"]];
    self.countLable.text = [NSString stringWithFormat:@"x%@",model.detailList[self.shownum][@"quantity"]];
    self.productPriceLable.text = [NSString stringWithFormat:@"¥ %.2f",[model.detailList[self.shownum][@"price"] floatValue]/1000];
    self.productTotalLable.text = [NSString stringWithFormat:@"合计%@件商品",model.detailList[self.shownum][@"quantity"]];
    
    UIButton * btn1 = [UIButton buttonWithTitle:@"申请退款" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:12 cornerRadius:4];
    btn1.layer.borderColor = kTabbarColor.CGColor;
    btn1.layer.borderWidth = 1;
    self.btn1 = btn1;
    btn1.frame = CGRectMake(SCREEN_WIDTH - 90,125, 75, 28);
    
    
    UIButton * btn2 = [UIButton buttonWithTitle:@"申请退款" titleColor:kTabbarColor backgroundColor:kClearColor titleFont:12 cornerRadius:4];
    btn2.layer.borderColor = kTabbarColor.CGColor;
    btn2.layer.borderWidth = 1;
    self.btn2 = btn2;
    btn2.frame = CGRectMake(SCREEN_WIDTH - 180,125, 75, 28);
    
    if ([model.detailList[self.shownum][@"afterSaleStatus"] isEqualToString:@"2"]) {
        [self.btn2 setTitle:@"取消售后" forState:(UIControlStateNormal)];
        [self.btn1 setTitle:@"售后中" forState:(UIControlStateNormal)];
        [self.btn1 setTitleColor:kTextColor3 forState:(UIControlStateNormal)];
//        self.btn1.userInteractionEnabled = NO;
        self.btn1.layer.borderColor = kTextColor3.CGColor;
    }
    else if ([model.detailList[self.shownum][@"afterSaleStatus"] isEqualToString:@"9"]){
         [self.btn1 setHidden: NO];
         [self.btn2 setHidden: YES];
    }
    else if ([model.status isEqualToString:@"3"]){
        [self.btn2 setTitle:@"申请售后" forState:(UIControlStateNormal)];
        [self.btn1 setTitle:@"评价" forState:(UIControlStateNormal)];
    }
    else if ([model.status isEqualToString:@"4"]){
        [self.btn2 setHidden: YES];
        [self.btn1 setTitle:@"已完成" forState:(UIControlStateNormal)];
        self.btn1.layer.borderColor = kTextColor3.CGColor;
    }
    else if (!model.detailList[self.shownum][@"afterSaleStatus"]){
        [self.btn1 setHidden: NO];
        [self.btn2 setHidden: YES];
    }
    else{
        [self.btn2 setHidden: YES];
        [self.btn1 setHidden:YES];
    }
    
    [self.shopcartBgView addSubview:btn1];
    [self.shopcartBgView addSubview:btn2];
}
-(void)click:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate clickBtn:sender];
    }
}

@end
