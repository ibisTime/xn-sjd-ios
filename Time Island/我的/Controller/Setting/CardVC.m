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
@interface CardVC ()
@property (nonatomic,strong) TLTableView * table;
@end

@implementation CardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    self.RightButton.font = FONT(16);
    [self.RightButton setFrame:CGRectMake(SCREEN_WIDTH-47.5, 30, 32.5, 45)];
    [self.RightButton setTitle:@"绑定" forState:UIControlStateNormal];
    [self.RightButton addTarget:self action:@selector(myRecodeClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.table = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.view addSubview:self.table];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 173.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardVCCell * cell = [[CardVCCell alloc]init];
    if (indexPath.row == 0) {
        cell.CardName.text = @"中国邮政储蓄银行";
        cell.LogoImage.image = kImage(@"邮政logo");
        cell.BackgroundImage.image = kImage(@"邮政银行");
        cell.CardType.text = @"借记卡";
        cell.CardCount.text = @"**** **** **** 9987";
    }
    else if (indexPath.row == 1){
        cell.CardName.text = @"中国招商银行";
        cell.LogoImage.image = kImage(@"招商logo");
        cell.BackgroundImage.image = kImage(@"招商银行");
        cell.CardType.text = @"借记卡";
        cell.CardCount.text = @"**** **** **** 9987";
    }
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
}
@end
