//
//  StringGroupingSortVC.m
//  BMChineseSorting
//
//  Created by lzw on 2018/8/3.
//  Copyright © 2018 BruceYu. All rights reserved.
//

#import "StringGroupingSortVC.h"
#import "BMChineseSort.h"

@interface StringGroupingSortVC (){
    NSMutableArray<NSString*>* dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *firstLetterArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray<NSMutableArray *> *sortedModelArr;

@end

@implementation StringGroupingSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    [self request];
}

- (IBAction)reloadData:(UIButton*)sender {
    //选择拼音 转换的 方法
    BMChineseSortSetting.share.sortMode = sender.tag; // 1或2
    //排序 Person对象
    [BMChineseSort sortAndGroup:dataArr key:nil finish:^(bool isSuccess, NSMutableArray *unGroupArr, NSMutableArray *sectionTitleArr, NSMutableArray<NSMutableArray *> *sortedObjArr) {
        if (isSuccess) {
            self.firstLetterArray = sectionTitleArr;
            self.sortedModelArr = sortedObjArr;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.firstLetterArray objectAtIndex:section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.firstLetterArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sortedModelArr[section] count];
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.firstLetterArray;
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
    NSString *s = self.sortedModelArr[indexPath.section][indexPath.row];
    cell.textLabel.text = s;
    return cell;
}


//请求数据
-(void)request{
    dataArr = @[@"北京",@"河北",@"黑龙江",@"上海",@"江苏",@"浙江",@"福建",@"湖北",@"湖南",@"广东",@"海南",@"重庆",@"四川",@"贵州",@"云南",@"西藏",@"陕西",@"沈阳",@"长春",@"abc",@"baba"].mutableCopy;
}



@end
