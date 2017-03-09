//
//  HMnewsCell.m
//  newsAPP的demo展示（UI刷新）
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "HMnewsCell.h"
#import "UIImageView+WebCache.h"


@implementation HMnewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

-(void)setModel:(HMnewsModel *)model {
    
    _model = model;
    
    //赋值
    _newsTitle.text = model.title;
    _newsSource.text = model.sitename;
    _newsTime.text = [NSDate dateWithTimeIntervalSince1970:[model.addtime doubleValue]].description;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.src_img] placeholderImage:[UIImage imageNamed:@"xzq.jpg"]];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
