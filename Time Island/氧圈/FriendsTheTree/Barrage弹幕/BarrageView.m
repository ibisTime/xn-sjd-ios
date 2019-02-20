//
//  BarrageView.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "BarrageView.h"
#import "BarrageCollCell.h"
#define BarrageColl @"BarrageCollCell"
#import "UICollectionViewLeftAlignedLayout.h"
@interface BarrageView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@end




@implementation BarrageView

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {

//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kHeight(635)/2, SCREEN_WIDTH, kHeight(635)/2 + 100)];
//        backView.backgroundColor = kWhiteColor;
//        [self addSubview:backView];

//        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 25, backView.y + 15, 25, 25);
//        [ShutDownBtn setImage:kImage(@"删除 灰色") forState:(UIControlStateNormal)];
//        self.ShutDownBtn = ShutDownBtn;
//        [self addSubview:ShutDownBtn];
        
        
//        view1 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, kHeight(96)/2, 180, kHeight(40))];
//        view1.nameLabel.text = @"感谢帮我收能量";
//        view1.rightImg.image = kImage(@"1");
//        [backView addSubview:view1];
//
//        BarrageEncapsulationView *view2 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(view1.xx + 18 , kHeight(96)/2, 150, kHeight(40))];
//        view2.nameLabel.text = @"给你点个赞";
//        view2.rightImg.image = kImage(@"点赞@2x");
//        [backView addSubview:view2];
//
//
//        BarrageEncapsulationView *view3 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view1.yy + kHeight(15), 210, kHeight(40))];
//        view3.nameLabel.text = @"我控制不住我自己啊~";
//        view3.rightImg.image = kImage(@"2");
//        [backView addSubview:view3];
//
//        BarrageEncapsulationView *view4 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view3.yy + kHeight(15), 190, kHeight(40))];
//        view4.nameLabel.text = @"勤快的宝宝有能量~";
//        view4.rightImg.image = kImage(@"3");
//        [backView addSubview:view4];
//
//        BarrageEncapsulationView *view5 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(view4.xx + 8, view3.yy + kHeight(15), 155, kHeight(40))];
//        view5.nameLabel.text = @"我对你已绝望";
//        view5.rightImg.image = kImage(@"4");
//        [backView addSubview:view5];
//
//        BarrageEncapsulationView *view6 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view4.yy + kHeight(15), 335, kHeight(40))];
//        view6.nameLabel.text = @"你行行好，别把我的能量全收走，可以吗~";
//        view6.rightImg.image = kImage(@"5");
//        [backView addSubview:view6];
//
//        BarrageEncapsulationView *view7 = [[BarrageEncapsulationView alloc]initWithFrame:CGRectMake(15, view6.yy + kHeight(15), 210, kHeight(40))];
//        view7.nameLabel.text = @"你怎么每天这么勤快呢";
//        view7.rightImg.image = kImage(@"6");
//        [backView addSubview:view7];
    
//    }
//    return self;
//}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor whiteColor];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kHeight(635)/2, SCREEN_WIDTH, kHeight(635)/2 + 100)];
//        backView.alpha = 0.5;
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        UIButton *ShutDownBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDownBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 25, backView.y + 15, 25, 25);
        [ShutDownBtn setImage:kImage(@"删除 灰色") forState:(UIControlStateNormal)];
        self.ShutDownBtn = ShutDownBtn;
        [self addSubview:ShutDownBtn];
        
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumLineSpacing = 15;
        // 2.设置 最小列间距
        layout. minimumInteritemSpacing  = 15;
        layout.sectionInset = UIEdgeInsetsMake(15,15,15,15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, kHeight(635)/2 - 55) collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BarrageCollCell class] forCellWithReuseIdentifier:BarrageColl];
        [backView addSubview:self.collectionView];
    }
    return self;
}

#pragma mark -- Collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _BarrageModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BarrageCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BarrageColl forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    if (self.BarrageModels.count > 0) {
        cell.model = self.BarrageModels[indexPath.row];
    }
    
    return cell;
}






//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0.01;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//
//    return 0.01;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self.BarrageModels[indexPath.row].content sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT(14),NSFontAttributeName,nil]];
    // 名字的H
    CGFloat nameW = size.width;

    return CGSizeMake(nameW + 65, 40);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH, 0.001);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(SCREEN_WIDTH, 0.001);
//}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}


#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate BarrageViewSelectRow:indexPath.row];
}


-(void)setBarrageModels:(NSMutableArray<BarrageModel *> *)BarrageModels{
//    for (int i = 0; i < BarrageModels.count; i++) {
//        BarrageModel * model = BarrageModels[i];
//        view1.nameLabel.text = model.content;
//        [view1.rightImg sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]]];
//    }
    
    _BarrageModels = BarrageModels;
    [self.collectionView reloadData];
}
@end
