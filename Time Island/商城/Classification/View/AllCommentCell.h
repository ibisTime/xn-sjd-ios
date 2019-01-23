//
//  AllCommentCell.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsEditModel.h"
@interface AllCommentCell : BaseTableViewCell
@property (nonatomic ,strong) UILabel *moreLab;

@property (nonatomic ,strong) UILabel *detailLab;

@property (nonatomic ,strong) NSArray *imagesName;

@property (nonatomic ,strong) GoodsEditModel *editModel;

@property (nonatomic ,assign) CGFloat maxFloat;
@property (nonatomic, copy) void (^TotalHeightBlock)(CGFloat flo);

@end
