//
//  BookView.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/1/16.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "BookView.h"
#import "BookCell.h"
#import "BoolVideoDetailVC.h"
static NSString *identifierCell = @"BookVideoCell";

@implementation BookView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        self.backgroundColor = kBackgroundColor;
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[BookCell class] forCellReuseIdentifier:identifierCell];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.BookModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BookCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    cell.state = self.state;
    cell.BookModel = self.BookModels[indexPath.row];
    cell.selectionStyle = UIAccessibilityTraitNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    NSLog(@"%s",__func__);
//    BoolVideoDetailVC * vc = [BoolVideoDetailVC new];
//    vc.BookModel = self.BookModels[indexPath.row];
//    
//    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
//        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
//    }
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 15;
//}
-(void)setBookModels:(NSMutableArray<BookModel *> *)BookModels{
    _BookModels = BookModels;
}

@end
