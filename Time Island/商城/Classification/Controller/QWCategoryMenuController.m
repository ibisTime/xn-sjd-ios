//
//  QWCategoryMenuController.m
//  QW京东Demo
//
//  Created by mac on 16/1/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "QWCategoryMenuController.h"
#import "QWCategoryCommon.h"

#import "QWCategory.h"
#import "UIColor+Extension.h"
#import "QWCategory.h"
#define QWCellTextFont [UIFont systemFontOfSize:15]

@interface QWCategoryMenuController ()

@property (nonatomic, strong) NSMutableArray <QWCategory *>*catelogyList;
@property (nonatomic, weak) QWCategory *selectedCategory;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation QWCategoryMenuController

#pragma mark - 懒加载
- (NSMutableArray *)catelogyList {
    if (_catelogyList == nil) {
        _catelogyList = [NSMutableArray array];
    }
    return _catelogyList;
}


#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 取消滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 不允许下拉
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = kLineColor;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 返回本页面时，重新选中原来的选项
    [self.tableView selectRowAtIndexPath:_selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - 加载一级分类数据
- (void)loadData {
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"629005";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"10";
    http.parameters[@"type"] = @"2";
    http.parameters[@"level"] = @"1";
    http.parameters[@"status"] = @"1";

    CoinWeakSelf;
    [http postWithSuccess:^(id responseObject) {
        self.catelogyList = [QWCategory mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.catelogyList = (NSMutableArray *)[[self.catelogyList reverseObjectEnumerator]allObjects];
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    } failure:^(NSError *error) {
        
    }];
    
//    [QWCatelogListTool GETCatelogyListWithLevel:@"0" catelogyId:@"0" success:^(NSArray *catelogyList) {
//        
//        [self.catelogyList addObjectsFromArray:catelogyList];
//        // 注意：得到数据后，一定要刷新列表
//        [self.tableView reloadData];
//        
//        // 加载即选中第一行
//        if (self.catelogyList.count) {
//            
    
//        }
//        
//    } failure:^(NSError *error) {
//        QWLog(@"请求分类信息出错:%@", error);
//    }];
}

#pragma mark - <UITableViewDataSource>
#pragma mark 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
#pragma mark 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.catelogyList.count;
}

#pragma mark cell长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // 设置cell背景
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[kLineColor convertToImage].CGImage]];
    // 设置cell被选中时的背景
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_cell_redline"]];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (cell.isSelected == YES) {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
    }else{
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor textColor];

    }
    // 设置cell内容
//    QWCategory *category = self.catelogyList[indexPath.row];
//    category.name = [NSString stringWithFormat:@"测试%ld",indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.catelogyList[indexPath.row].name];
    
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark 取消选中后做什么
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 点击cell会怎么样
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 保存所选cell位置
    _selectedIndexPath = indexPath;
    // 滚到顶端
    [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    // 字体变红
    [tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = kBlackColor;
    // 取出分类id
    QWCategory *selectedCategory = self.catelogyList[indexPath.row];
    if ([_selectedCategory.code isEqualToString: selectedCategory.code] == NO) { // 不重复点击
//
//        _selectedCategory = selectedCategory;
        // 发送通知,传递参数cid
        [[NSNotificationCenter defaultCenter] postNotificationName:QWDetailCategoryDataWillLoadNotification object:selectedCategory];
    }
}


@end
