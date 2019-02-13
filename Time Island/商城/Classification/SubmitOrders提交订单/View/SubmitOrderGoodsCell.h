//
//  SubmitOrderGoodsCell.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallGoodsModel.h"
@interface SubmitOrderGoodsCell : UITableViewCell

@property (nonatomic , strong)MallGoodsModel *model;

@property (nonatomic , copy)NSDictionary *dic;

@property (nonatomic , strong)UIImageView *goodsImage;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *introduceLabel;

@property (nonatomic , strong)UILabel *priceLabel;

@property (nonatomic , strong)UILabel *numberLabel;

@property (nonatomic , strong)UILabel *shopLabel;

@property (nonatomic,assign) NSInteger count;

@property (nonatomic,strong) NSString * size;

@property (nonatomic,assign) int selectnum;

@end
