//
//  RecordVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/20.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "RecordVC.h"
#import "RecordCell.h"
#import "RecordModel.h"
@interface RecordVC ()
@property (nonatomic,strong) NSMutableArray<RecordModel *> * RecordModels;
@end

@implementation RecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"养护记录";
    [self getdata];
    // Do any additional setup after loading the view.
}
//获取养护记录数据
-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629635";
    http.parameters[@"treeNumber"] = self.treeNumber;
    http.parameters[@"start"] = @(1);
    http.parameters[@"limit"] = @(10);
    [http postWithSuccess:^(id responseObject) {
        self.RecordModels = [RecordModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
    } failure:^(NSError *error) {
        
    }];
}

@end
