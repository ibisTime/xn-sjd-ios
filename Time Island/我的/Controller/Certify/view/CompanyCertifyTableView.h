//
//  CompanyCertifyTableView.h
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/25.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DicDelegrate <NSObject>

-(void)DicVlaueDelegrate:(NSMutableDictionary *)dic;

@end

@interface CompanyCertifyTableView : TLTableView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,strong) NSArray * placeholderArray;
@property (nonatomic,strong) NSArray * KeyArray;
@property (nonatomic,strong) NSMutableDictionary * ValueDic;
@property (nonatomic,weak) id<DicDelegrate> delegate;
@end

NS_ASSUME_NONNULL_END
