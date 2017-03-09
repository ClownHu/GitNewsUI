//
//  ViewController.m
//  newsAPP的demo展示（UI刷新）
//
//  Created by 胡卓 on 2017/3/8.
//  Copyright © 2017年 胡卓. All rights reserved.
//

#import "ViewController.h"
#import "HMnewsCell.h"
#import "HMnewsModel.h"
#import "YYModel.h"
#import "MJRefresh.h"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//用模型数组接受数据
@property(nonatomic,strong) NSMutableArray *modelList;

//定义下拉控件属性
@property(nonatomic,strong)MJRefreshNormalHeader *refreshHeader;

//定义上拉控件属性
@property(nonatomic,strong)MJRefreshAutoNormalFooter *refreshFooter;

@end

static NSString *rid = @"news";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化
    _modelList = [NSMutableArray array];
    
    //集成下拉刷新属性
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    _tableView.mj_header = _refreshHeader;
    _tableView.mj_footer = _refreshFooter;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //注册
    [_tableView registerNib:[UINib nibWithNibName:@"HMnewsCell" bundle:nil] forCellReuseIdentifier:rid];
    
    //设置数据源
    _tableView.dataSource = self;
    
    //设置预估行高
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    //加载数据
    [self loadData];
    
}

//加载网络数据
-(void)loadData {
    
    NSInteger type = 0;
    NSString *time = @"0";
    
    //判断下拉还是上拉
    //下拉
    if (_refreshHeader.isRefreshing) {
        
        time = _modelList.count > 0 ? [_modelList.firstObject addtime] : @"0";
    }
    
    //上拉
    if (_refreshFooter.isRefreshing) {
        
        type = 1;
        time = _modelList.count > 0 ? [_modelList.lastObject addtime] : @"0";
    }
    
    //字符串拼接URL
    NSString *urlString = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/%@/type/%ld",time,type];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //发起请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //如果出现错误回来调用的方法
        if (error != nil) {
            
            NSLog(@"%@",error);
            return;
        }
        
        //反序列化
        NSArray *newsArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@",newsArr);
        
        
        //字典数组转模型数组
        NSArray *newsModelArr = [NSArray yy_modelArrayWithClass:[HMnewsModel class] json:newsArr];
        
        //产生可变数组
        NSMutableArray *newsMutableArr = [NSMutableArray arrayWithArray:newsModelArr];
        
        //下拉操作
        if (type == 0) {
            
            _modelList = newsMutableArr;
            
        } else {    //上拉操作
            
            [_modelList addObjectsFromArray:newsMutableArr];
            
        }
        
        //主线程里刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //判断是上拉还是下拉
            if (type == 0) {
                //下拉则刷新结束
                [_refreshHeader endRefreshing];
                
            } else {
                
                //上拉则结束刷新
                [_refreshFooter endRefreshing];
            }
            
            //刷新UI
            [self.tableView reloadData];
        });
        
    }] resume];
    
}


#pragma  mark ---实现数据源方法
//返回行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return _modelList.count;
    
}

//返回cell
-(HMnewsCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMnewsCell *cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    
    //将数据传给cell,更新cell
    HMnewsModel *model = _modelList[indexPath.row];
    cell.model = model;
    
    return cell;
}
@end
