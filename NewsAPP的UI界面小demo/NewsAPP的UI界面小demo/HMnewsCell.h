//
//  HMnewsCell.h
//  newsAPP的demo展示（UI刷新）
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMnewsModel.h"

@interface HMnewsCell : UITableViewCell

//用于接收数据
@property(nonatomic,strong)HMnewsModel *model;



@property (weak, nonatomic) IBOutlet UILabel *newsTitle;

@property (weak, nonatomic) IBOutlet UILabel *newsSource;

@property (weak, nonatomic) IBOutlet UILabel *newsTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end
