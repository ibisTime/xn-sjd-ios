//
//  MallGoodsInformationCell.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/11.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallGoodsInformationCell.h"

@interface MallGoodsInformationCell()

@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *courierLab;
@property (nonatomic, strong) UILabel *onThePinLab;
@property (nonatomic, strong) UILabel *addressLab;

@end

@implementation MallGoodsInformationCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.priceLable = [UILabel labelWithFrame:CGRectMake(15, 15.5, SCREEN_WIDTH - 30, 21) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kHexColor(@"#F68646")];
        [self addSubview:self.priceLable];
        
        self.nameLab = [UILabel labelWithFrame:CGRectMake(15, 47.5, SCREEN_WIDTH, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(15) textColor:kTextBlack];
        
        [self addSubview:self.nameLab];
        
        for (int i = 0; i < 3; i ++) {
            UILabel *label = [UILabel labelWithFrame:CGRectMake(15 + i % 3 * (SCREEN_WIDTH - 30)/3, 104.5, (SCREEN_WIDTH - 30)/3, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:FONT(12) textColor:kHexColor(@"#999999")];
            if (i == 0) {
                self.courierLab = label;
                self.courierLab.textAlignment = NSTextAlignmentLeft;
            }
            if (i == 1) {
                self.onThePinLab = label;
                self.onThePinLab.textAlignment = NSTextAlignmentCenter;
            }
            if (i == 2) {
                self.addressLab = label;
                self.addressLab.textAlignment = NSTextAlignmentRight;
            }
            [self addSubview:label];
        }
        
        
    }
    return self;
}

-(void)setTreeModel:(MallGoodsModel *)treeModel
{
    _treeModel = treeModel;
    CGFloat minPrice = [treeModel.minPrice floatValue] / 1000;
    CGFloat maxPrice = [treeModel.maxPrice floatValue] / 1000;
    self.priceLable.text = [NSString stringWithFormat:@"¥%.2f-¥%.2f",minPrice,maxPrice];
    self.nameLab.text = treeModel.name;
    self.nameLab.numberOfLines = 2;
    [self.nameLab sizeToFit];
    
    self.courierLab.text = @"快递：包邮";
    self.onThePinLab.text = [NSString stringWithFormat:@"月销%@笔",treeModel.monthSellCount];
    self.addressLab.text = treeModel.originalPlace;
}

@end
