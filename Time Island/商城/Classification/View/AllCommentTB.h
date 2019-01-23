//
//  AllCommentTB.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/22.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "GoodsEditModel.h"
@interface AllCommentTB : TLTableView
@property (nonatomic ,assign) CGFloat rowHe;
@property (nonatomic ,strong) NSArray *imagesName;
@property (nonatomic, strong) NSMutableArray <GoodsEditModel *>*models;

@end
