//
//  MallTreeModel.m
//  Time Island
//
//  Created by shaojianfei on 2019/1/28.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "MallTreeModel.h"
#import "SpecsListModel.h"
@implementation MallTreeModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description": @"description"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"courses" : [SpecsListModel class]};
}

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
