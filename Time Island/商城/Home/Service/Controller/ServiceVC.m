//
//  ServiceVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/3/5.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "ServiceVC.h"
#import "MesModel.h"
#import "ServiceTableView.h"
@interface ServiceVC ()<RefreshDelegate>
{
    NSArray *array;
    NSArray *array1;
}
@property (nonatomic,strong) MesModel * MesModels;
@property (nonatomic,strong) NSMutableArray<MesModel*> * model;
@property (nonatomic,strong) ServiceTableView * tableview;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) UITextField * textfield;

@end

@implementation ServiceVC
-(void)viewDidAppear:(BOOL)animated{
    [self.tableview setContentOffset:CGPointMake(0, self.tableview.contentSize.height-self.tableview.frame.size.height)animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
     self.state = @"go";
}
-(void)viewWillDisappear:(BOOL)animated{
    self.state = @"back";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    [self.view addSubview:self.tableview];
    [self loadData];
    [self createview];
}
-(ServiceTableView *)tableview{
    if (!_tableview) {
        _tableview = [[ServiceTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)];
        _tableview.refreshDelegate = self;
        _tableview.backgroundColor = RGB(236, 236, 236);
    }
    return _tableview;
}
-(void)createview{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - kNavigationBarHeight - 70 , SCREEN_WIDTH, 70)];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 115, 60)];
    self.textfield.placeholder = @"说点啥呗";
    
    [view addSubview:self.textfield];
    
    self.content = self.textfield.text;
    NSLog(@"%@",self.content);
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(self.textfield.xx, 10, 85, 40) title:@"发送" backgroundColor:RGB(209, 170, 91)];
    [btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    kViewRadius(btn, 4);
    
    [btn addTarget:self action:@selector(sendMessage) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:btn];
    view.backgroundColor = kWhiteColor;
    [self.view addSubview:view];
}
-(void)loadData{
    
    if (![self.state isEqualToString:@"back"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"629785";
        http.parameters[@"start"] = @"1";
        http.parameters[@"limit"] = @"1";
        http.parameters[@"user1"] = [TLUser user].userId;
        http.parameters[@"user2"] = self.user2;
        [http postWithSuccess:^(id responseObject) {
            self.MesModels = responseObject[@"data"][@"list"];
            
            self.tableview.model = [MesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            array = self.tableview.model[0].messageList;
            if (array.count != array1.count) {
                [self.tableview reloadData];
            }
            array1 = self.tableview.model[0].messageList;
            
            self.model = [MesModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self loadData];
        } failure:^(NSError *error) {
            
        }];
        
    }
}
-(void)sendMessage{
    //629781
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"629781";
    http.parameters[@"code"] = self.model[0].code;
    http.parameters[@"content"] = self.textfield.text;
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.textfield.text = @"";
        [self loadData];
        [self.tableview setContentOffset:CGPointMake(0, self.tableview.contentSize.height - self.tableview.frame.size.height)animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
//-(void)scrollToBottom {
//    if (self.model[0].messageList.count > 0) {
//        if ([self.tableview numberOfRowsInSection:0] > 0) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.tableview numberOfRowsInSection:0]-1) inSection:0];
//            [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
//        }
//    }
//}

@end
