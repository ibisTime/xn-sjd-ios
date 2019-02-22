//
//  CardVC.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/15.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "CardVC.h"
#import "CardVCCell.h"
#import "AddCardVC.h"
#import "CardModel.h"
@interface CardVC ()
@property (nonatomic,strong) TLTableView * table;
@property (nonatomic , strong)NSMutableArray <CardModel *>*CardModels;
@end

@implementation CardVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refresh];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的银行卡";
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
//    self.RightButton.font = FONT(16);
    self.RightButton.titleLabel.font = FONT(16);
    self.RightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-57.5, 30, 42.5, 45)];
    [self.RightButton setTitle:@"绑定" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.view addSubview:self.table];
    
    [self refresh];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CardModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 173.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardVCCell * cell = [[CardVCCell alloc]init];
    
    cell.LogoImage.image = kImage(@"邮政logo");
    cell.BackgroundImage.image = kImage(@"邮政银行");
    cell.CardName.text = self.CardModels[indexPath.row].bankName;
    NSString * str = self.CardModels[indexPath.row].bankcardNumber;
//    NSString * str1 = [str substringToIndex:4];
    NSString * str2 = [str substringFromIndex:15];
    cell.CardCount.text = [NSString stringWithFormat:@"**** **** **** %@",str2];
    cell.CardType.text = @"借记卡";
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

-(void)myRecodeClick{
    AddCardVC * vc = [[AddCardVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"删除");
    CardModel * model = self.CardModels[indexPath.row];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"802021";
    http.parameters[@"code"] = model.code;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"删除成功!"];
        [self refresh];
    } failure:^(NSError *error) {
    }];
}

-(void)refresh{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"802026";
    http.parameters[@"userId"] = [TLUser user].userId;
    [http postWithSuccess:^(id responseObject) {
        self.CardModels = [CardModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.table reloadData];
    } failure:^(NSError *error) {
    }];
}
@end
