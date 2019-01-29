//
//  GoodsDetailsInfomationCell.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
@interface GoodsDetailsInfomationCell : UITableViewCell
@property (nonatomic,strong) TreeModel * TreeModel;
@property (nonatomic,strong) UILabel *nameLbl;
@property (nonatomic,strong) UILabel *TheLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *numberLbl;
@property (nonatomic,copy) NSArray *targetNumber;
@property (nonatomic,strong) UIView *progressView;
@end
