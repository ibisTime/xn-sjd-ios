//
//  CompanyCertifyTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN


@interface CompanyCertifyTableView : TLTableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) NSArray * placeholderArray;
@property (nonatomic,strong) NSArray * KeyArray;
@property (nonatomic,strong) NSArray * ValueArray;
@property (nonatomic,strong) NSMutableDictionary * ValueDic;
@end

NS_ASSUME_NONNULL_END
