//
//  MallGoodsModel.m
//  Time Island
//
//  Created by 梅敏杰 on 2019/2/13.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallGoodsModel.h"
#import "SpecsListModel.h"
@implementation MallGoodsModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description": @"description"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"courses" : [SpecsListModel class]};
}
//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
//    
//    if ([propertyName isEqualToString:@"id"]) {
//        return @"sizeid";
//    }
//    
//    return propertyName;
//}

- (NSArray *)bannerPics {
    
    if (!_bannerPics) {
        
        NSArray *imgs = [self.bannerPic componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _bannerPics = newImgs;
    }
    
    return _bannerPics;
}
@end
