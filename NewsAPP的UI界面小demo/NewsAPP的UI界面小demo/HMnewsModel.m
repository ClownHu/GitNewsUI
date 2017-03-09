//
//  HMnewsModel.m
//  newsAPP的demo展示（UI刷新）
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "HMnewsModel.h"
#import "YYModel.h"


@implementation HMnewsModel

//重写description方法，返回对象的描述信息
-(NSString *)description {
    
    return [self yy_modelDescription];
}


@end
