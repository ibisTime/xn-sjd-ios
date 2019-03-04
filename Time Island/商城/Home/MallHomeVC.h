//
//  MallHomeVC.h
//  Time Island
//
//  Created by 郑勤宝 on 2019/1/18.
//  Copyright © 2019 ChengLian. All rights reserved.
//

#import "MallBaseVC.h"
#import "PYSearch.h"
@interface MallHomeVC : MallBaseVC<UITableViewDelegate,UITableViewDataSource,RefreshDelegate,UISearchBarDelegate,PYSearchViewControllerDelegate>

@end
