//
//  OrderView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "OrderView.h"

@interface OrderView ()
@property (nonatomic,strong) TLTableView * table;
@end

@implementation OrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table = [[TLTableView alloc]initWithFrame:self.view.frame];
//    self.table.delegate = self;
//    self.table.dataSource = self;
    self.table.refreshDelegate = self;
    [self.view addSubview:self.table];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}


@end
