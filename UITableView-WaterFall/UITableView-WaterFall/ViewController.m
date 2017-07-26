//
//  ViewController.m
//  UITableView-WaterFall
//
//  Created by luds on 15/9/1.
//  Copyright (c) 2015年 luds. All rights reserved.
//

#import "ViewController.h"

#import "TableViewCell.h"

#define baseTableViewTag  99887

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    CGFloat HetTab0;
    CGFloat HetTab1;
    CGFloat HetTab2;

}
// 数据源数组
@property (nonatomic, retain) NSMutableArray *dataSource;

// 存放所有的tableView
@property (nonatomic, retain) NSMutableArray *allTables;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 1. 初始化数据
    [self initData];
    // 2. 先搭界面
    [self initView];
}

- (void)initData {
    // 1.
//    self.dataSource = [[NSMutableArray alloc] init];
    
    // 2. 三个数组
    NSMutableArray *arr0 = [[NSMutableArray alloc] init];
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    
    // 3. 将3个数组, 都放到self.dataSource里面去
    self.dataSource = [NSMutableArray arrayWithArray:@[arr0, arr1, arr2]];
    
    // 4. 填充数组
    for (int i = 1; i < 19; i++) {
        // 4.1 取出所有图片的名字
        NSString *name = [NSString stringWithFormat:@"%d.jpg", i%19];
        
        //将图片放在高度最低的 数组中。相等放在第一个
        if(HetTab0<=HetTab1 && HetTab0 <=HetTab2){
            
            HetTab0 += [self dataArrayAddImagename:name index:0];
            
        }
        
        
       else if(HetTab1<HetTab0 && HetTab1 <=HetTab2){
            
            HetTab1 += [self dataArrayAddImagename:name index:1];
            
        }
        
        
       else if(HetTab2<HetTab1 && HetTab2 <HetTab1){
            
            HetTab2 += [self dataArrayAddImagename:name index:2];
            
        }
        
        
       else if(HetTab0 == HetTab1 && HetTab0 == HetTab2){
            
            HetTab0 += [self dataArrayAddImagename:name index:0];
            
        }
        
       
    }
}

-(CGFloat)dataArrayAddImagename:(NSString *)name  index:(NSInteger)index{
    
    
    // 4.2 将所有的图片的名字存到数组中去
    UIImage *image = [UIImage imageNamed:name];
    // 返回高度
    // 宽度是屏幕的 1/3
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3;
    // 高度
    // 图片           650     325
    // imageView     width
    // 根据比例算出高度
    float height = image.size.height * width / image.size.width;

    NSMutableArray *arr = self.dataSource[index];
    [arr addObject:name];

    
    return height;
}

- (void)initView {
    self.allTables = [[NSMutableArray alloc] init];
    // 循环创建tableView
    float width = self.view.frame.size.width / 3.f;
    float height = self.view.frame.size.height;
    for (int i = 0; i < 3; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(width * i, 0, width, height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = baseTableViewTag + i;
        
        tableView.showsVerticalScrollIndicator = NO;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:tableView];
        
        // 添加到数组中
        [self.allTables addObject:tableView];
    }
}

#pragma mark ---------- tableView的数据源协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#if 0
    switch (tableView.tag - baseTableViewTag) {
        case 0:
            return [self.dataSource[0] count];
            break;
            
        case 1:
            return [self.dataSource[1] count];
            break;
            
        case 2:
            return [self.dataSource[2] count];
            break;
            
        default:
            break;
    }
    return 0;
    
#else
    
    return [self.dataSource[tableView.tag - baseTableViewTag] count];
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"cell";
    // 系统的cell已经不能满足我们了, 所以, 我们还需要自定义cell
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    // 我们希望在cell上显示一张图片, 首先, 得给cell一个图片
#if 0
    NSString *imageName;
    // 要区分tableView
    switch (tableView.tag - baseTableViewTag) {
        case 0: {
            NSArray *arr = self.dataSource[0];
            imageName = arr[indexPath.row];
            break;
        }
        case 1: {
            NSArray *arr = self.dataSource[1];
            imageName = arr[indexPath.row];
            break;
        }
        case 2: {
            NSArray *arr = self.dataSource[2];
            imageName = arr[indexPath.row];
            break;
        }
            
        default:
            break;
    }
#else
    NSString *name = self.dataSource[tableView.tag - baseTableViewTag][indexPath.row];
#endif
    cell.imageName = name;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 分tableView拿图片
    NSString *name = self.dataSource[tableView.tag - baseTableViewTag][indexPath.row];
    // 制作image
    UIImage *image = [UIImage imageNamed:name];
    // 返回高度
    // 宽度是屏幕的 1/3
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) / 3;
    // 高度
    // 图片           650     325
    // imageView     width
    // 根据比例算出高度
    float height = image.size.height * width / image.size.width;
    
    return height;
}


#pragma mark ---------- 联动
// scrollView滑动会不停调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    UITableView *t = (UITableView *)scrollView;
    
    // 还是要区分是哪个tableView动了
    for (UITableView *tableView in self.allTables) {
        if (tableView == scrollView) {
            // 当前响应滚动的tableView
            continue;
        }
        // 设置剩下的两个tableView的contentOffset 与当前滚动的一致
        [tableView setContentOffset:scrollView.contentOffset];
    }
}







@end
