//
//  ViewController.m
//  YUChineseSorting
//
//  Created by yuzhx on 15/4/19.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "ViewController.h"
#import "BMChineseSort.h"
#import "Person.h"

@interface ViewController (){
    NSMutableArray<Person *> *array;
}

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"李白",@"张三",
                            @"黄晓明",@"成龙",@"斑马",@"盖伦",
                            @"幻刺",@"暗影猎手",@"小白",@"小明",@"千珏",
                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",
                            nil];
    //模拟网络请求接收到的数组对象
    array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[stringsToSort count]; i++) {
        Person *p = [[Person alloc] init];
        p.name = [stringsToSort objectAtIndex:i];
        p.number = i;
        [array addObject:p];
    }
    
    //排序
    self.indexArray = [BMChineseSort IndexWithArray:array Key:@"name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:array Key:@"name"];

    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark - UITableViewDataSource
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.indexArray objectAtIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArr objectAtIndex:section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    //获得对应的Person对象
    Person *p = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    return cell;
}





@end
