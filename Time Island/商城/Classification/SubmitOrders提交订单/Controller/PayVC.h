//
//  PayVC.h
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLBaseVC.h"
#import "MallGoodsModel.h"
@interface PayVC : TLBaseVC

//@property (nonatomic , copy)NSString *state;
//
//@property (nonatomic , copy)NSString *code;
//
//@property (nonatomic , assign)CGFloat price;
@property (nonatomic,strong) UIImageView * IconImg;
@property (nonatomic,strong) UILabel * TreeName;
@property (nonatomic,strong) UILabel * TreeAddress;
@property (nonatomic,strong) UILabel * TreeSize;
@property (nonatomic,strong) UILabel * TreeCount;
@property (nonatomic,strong) UILabel * TreeMoney;
@property (nonatomic,strong) UILabel * PayMoney;
@property (nonatomic,strong) MallGoodsModel * mallGoodsModel;
@property (nonatomic,assign) NSInteger GoodsSizeCount;
@property (nonatomic,assign) NSInteger PayCount;
@property (nonatomic,strong) NSString * Code;
@property (nonatomic,strong) NSString * money;
@end
