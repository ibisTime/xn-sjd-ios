//
//  DynamicModel.m
//  Time Island
//
//  Created by 郑勤宝 on 2019/2/14.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "DynamicModel.h"

@implementation DynamicModel

-(NSString *)time
{
    if (!_time) {
        _time = [_createDatetime convertDate];
    }
    return _time;
}

@end
