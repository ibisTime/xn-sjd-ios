//
//  MineVC.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/2.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MineVC.h"
#import "TLUserLoginVC.h"
#define titlearray @[@"我的碳泡泡",@"我的认养",@"我的订单",@"我的文章",@"我的收藏",@"邀请有礼",@"设置"]
@interface MineVC ()
@property (nonatomic,retain) UIView * topview;
@property (nonatomic,strong) UITableView * table;
@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    self.topview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2.5)];
    self.topview.backgroundColor = kAppCustomMainColor;
    [self setupview];
    [self.view addSubview:self.topview];
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topview.yy + 10, kScreenWidth, kScreenHeight)];
    self.table.delegate = (id)self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

-(void)setupview{
    
    //头像框
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, kScreenWidth/4-50, 100, 100)];
    img.image = [UIImage imageNamed:@"果树预售"];
    img.layer.cornerRadius = 50;
    img.layer.masksToBounds = YES;
    
    //姓名
    UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, img.yy+15, 100, 10)];
    name.font = [UIFont systemFontOfSize:15];
    name.text = @"姓名";
    name.textAlignment = NSTextAlignmentCenter;
    name.adjustsFontSizeToFitWidth = YES;
    
    
    //签名
    UILabel * sign = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, name.yy+15, 100, 50)];
    sign.text = @"此人很懒，没留下什么";
    sign.font = [UIFont systemFontOfSize:13];
    sign.textAlignment = NSTextAlignmentCenter;
    sign.adjustsFontSizeToFitWidth = YES;
    sign.numberOfLines = 0;
    
    [self.topview addSubview:img];
    [self.topview addSubview:name];
    [self.topview addSubview:sign];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TLUserLoginVC * login = [[TLUserLoginVC alloc]init];
    [self.navigationController pushViewController:login animated:YES];
    
    //    TLUserRegisterVC * registeruser = [[TLUserRegisterVC alloc]init];
    //    [self.navigationController pushViewController:registeruser animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titlearray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSString * identifier= @"cell";
    //    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    //    }
    //    cell.imageView.image = [UIImage imageNamed:imagearray[indexPath.row]];
    //    cell.textLabel.text = imagearray[indexPath.row];
    //    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //    cell.selectionStyle = UIAccessibilityTraitNone;
    
    MineVcCell * cell = [[MineVcCell alloc]initWithfirstimage:titlearray[indexPath.row] title:titlearray[indexPath.row] lastimage:@"积分更多"];
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d %@",(int)indexPath.row , titlearray[indexPath.row]);
}

@end
