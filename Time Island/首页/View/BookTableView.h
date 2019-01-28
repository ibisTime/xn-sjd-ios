//
//  BookTableView.h
//  Time Island
//
//  Created by shaojianfei on 2019/1/14.
//  Copyright © 2019年 ChengLian. All rights reserved.
//

#import "TLTableView.h"
#import "BookModel.h"
@interface BookTableView : TLTableView
@property (nonatomic,strong) NSArray<BookModel * > * BookModel;
@end
