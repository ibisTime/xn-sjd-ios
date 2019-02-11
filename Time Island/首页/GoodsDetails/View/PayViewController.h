//
//  PayViewController.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/30.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLBaseVC.h"
#import "TreeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayViewController : TLBaseVC
@property (nonatomic,strong) UIImageView * IconImg;
@property (nonatomic,strong) UILabel * TreeName;
@property (nonatomic,strong) UILabel * TreeAddress;
@property (nonatomic,strong) UILabel * TreeSize;
@property (nonatomic,strong) UILabel * TreeCount;
@property (nonatomic,strong) UILabel * TreeMoney;
@property (nonatomic,strong) UILabel * PayMoney;
@property (nonatomic,strong) TreeModel * TreeModel;
@property (nonatomic,assign) int TreeSizeCount;
@property (nonatomic,assign) int PayCount;
@property (nonatomic,strong) NSString * Code;
@end

NS_ASSUME_NONNULL_END
