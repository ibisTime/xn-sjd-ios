//
//  GoodsDetailsTableView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/21.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "GoodsDetailsTableView.h"

#import "GoodsDetailsInfomationCell.h"
#define GoodsDetailsInfomation @"GoodsDetailsInfomationCell"
#import "RenYangListCell.h"
#define RenYangList @"RenYangListCell"
#import "TreeFiledCell.h"
#define TreeFiled @"TreeFiledCell"
#import "GoodsDetailsHeadView.h"
#import "GoodsDetailsCell.h"
#define GoodsDetails @"GoodsDetailsCell"
@interface GoodsDetailsTableView()<UITableViewDelegate, UITableViewDataSource,GoodsDetailsHeadDelegate>

@property (nonatomic,strong) GoodsDetailsCell  *cell;
@property (nonatomic,assign) CGFloat webViewHeight1;

@end

@implementation GoodsDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[GoodsDetailsInfomationCell class] forCellReuseIdentifier:GoodsDetailsInfomation];
        self.SelectHeader = 0;
        [self registerClass:[RenYangListCell class] forCellReuseIdentifier:RenYangList];
        [self registerClass:[TreeFiledCell class] forCellReuseIdentifier:TreeFiled];
//        [self registerClass:[GoodsDetailsCell class] forCellReuseIdentifier:GoodsDetails];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 1) {
        if (self.SelectHeader == 1) {
            return 9;
        }
        else if (self.SelectHeader == 0){
            return 1;
        }
        else
        {
            return self.RenYangModel.count;
        }
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        GoodsDetailsInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetailsInfomation forIndexPath:indexPath];
        cell.TreeModel = self.TreeModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (self.SelectHeader == 1) {
        TreeFiledCell *cell = [tableView dequeueReusableCellWithIdentifier:TreeFiled forIndexPath:indexPath];
        NSArray *titles = @[@"树木名称",@"树木学名",@"树木级别",@"树木品种",@"所在市县",@"乡镇街道",@"树木产地",@"认养时间",@"树木定位"];
        NSArray *details;
        if (self.TreeModel.treeList.count>0||self.TreeModel.productSpecsList.count>0) {
            details = @[[TLUser convertNull:self.TreeModel.name],
                        [TLUser convertNull:self.TreeModel.treeList[0][@"scientificName"]],
                        [TLUser convertNull:self.TreeModel.treeList[0][@"rank"]],
                        [TLUser convertNull:self.TreeModel.treeList[0][@"variety"]],
                        [NSString stringWithFormat:@"%@ %@",[TLUser convertNull:self.TreeModel.city],[TLUser convertNull:self.TreeModel.treeList[0][@"area"]]],
                        [TLUser convertNull:self.TreeModel.treeList[0][@"town"]],
                        [TLUser convertNull:self.TreeModel.treeList[0][@"originPlace"]],
                        [NSString stringWithFormat:@"%@ - %@",[TLUser convertNull:[self.TreeModel.productSpecsList[0][@"startDatetime"] convertToDetailDate]],[TLUser convertNull:[self.TreeModel.productSpecsList[0][@"endDatetime"] convertToDetailDate]]],@""];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moreLab.text = [NSString stringWithFormat:@"[%@]",titles[indexPath.row]];
        cell.detailLab.text = [NSString stringWithFormat:@"%@",details[indexPath.row]];
        
        if (indexPath.row == 8) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        return cell;
    }else if(self.SelectHeader == 0){
        
        
        
        static NSString *identifier = @"webCell";
        _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!_cell){
            _cell = [[GoodsDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            _cell.backgroundColor = kWhiteColor;
        
        
        
//        _cell = [tableView dequeueReusableCellWithIdentifier:GoodsDetails forIndexPath:indexPath];
//        _cell.TreeModel = self.TreeModel;
        
            
        }
        if (self.TreeModel.Description) {
            [_cell.detail loadHTMLString:self.TreeModel.Description baseURL:nil];
            [_cell.detail.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        }
        return _cell;
        
        
    }else{
        RenYangListCell *cell = [tableView dequeueReusableCellWithIdentifier:RenYangList forIndexPath:indexPath];
        cell.RenYangModel = self.RenYangModel[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        _webViewHeight1 = [[_cell.detail stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
        _cell.detail.frame = CGRectMake(0, 0, SCREEN_WIDTH, _webViewHeight1);
        [self reloadData];
    }
}
-(void)dealloc{
//    [self removeObserver:self forKeyPath:@"contentSize"];
    [_cell.detail.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];

}
-(void)MyTreeHeadButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

-(void)MyFreeDynamicButton:(NSInteger)tag
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:tag];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
            [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath WithState:[NSString stringWithFormat:@"%ld",self.SelectHeader]];
    }
   
//    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if ([self.TreeModel.sellType isEqualToString:@"4"]) {
            return 180;
        }else{
            return 90;
        }
        
    }
    if (indexPath.section == 1) {
        if (self.SelectHeader == 0) {
            return _webViewHeight1;
        }
       else if (self.SelectHeader == 1) {
            return 40;
        }
        else
        {
            return 50;
        }
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 1) {
        return 40;
    }
    return 0.1;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:scrollView:)]) {
        [self.refreshDelegate refreshTableView:self scrollView:scrollView];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        
        GoodsDetailsHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (!headView) {
            headView = [[GoodsDetailsHeadView alloc]initWithReuseIdentifier:@"header"];
        }
        headView.delegate = self;
        return headView;
    }
    
    return [UIView new];
}

-(void)GoodsDetailsHeadButton:(NSInteger)tag
{
    self.SelectHeader = tag;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        UIView *footView = [[UIView alloc]init];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [footView addSubview:lineView];
        
        UIButton *moreBtn = [UIButton buttonWithTitle:@"更多查看" titleColor:kTextBlack backgroundColor:kClearColor titleFont:13];
        moreBtn.frame = CGRectMake(0, 1, SCREEN_WIDTH, 40);
        [footView addSubview:moreBtn];
        
        return footView;
    }
    return [UIView new];
}

@end
