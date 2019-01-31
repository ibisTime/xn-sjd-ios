//
//  GoodsDetailsTableView.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "TreeModel.h"
#import "RenYangUserModel.h"
@interface GoodsDetailsTableView : TLTableView

@property (nonatomic , assign)NSInteger SelectHeader;

@property (nonatomic,strong) TreeModel * TreeModel;
@property (nonatomic,strong) NSMutableArray<RenYangUserModel * > * RenYangModel;
@end
