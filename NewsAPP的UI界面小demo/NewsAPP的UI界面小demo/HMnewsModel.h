//
//  HMnewsModel.h
//  newsAPP的demo展示（UI刷新）
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMnewsModel : NSObject

//新闻标题
@property(nonatomic,copy)NSString *title;

//新闻图片
@property(nonatomic,copy)NSString *src_img;

//新闻来源
@property(nonatomic,copy)NSString *sitename;

//新闻时间
@property(nonatomic,copy)NSString *addtime;

@end
