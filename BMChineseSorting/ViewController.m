//
//  ViewController.m
//  YUChineseSorting
//
//  Created by yuzhx on 15/4/19.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "ViewController.h"
#import "BMChineseString.h"
#import "Person.h"

@interface ViewController (){
    NSMutableArray<Person *> *array;
}
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property(nonatomic,strong)NSMutableArray *indexArray2;
@property(nonatomic,strong)NSMutableArray *letterResultArr2;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //    排序1
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"李白",@"张三",
                            @"黄晓明",@"成龙",@"斑马",@"盖伦",
                            @"幻刺",@"暗影猎手",@"小白",@"小明",@"千珏",
                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",
                            nil];
    self.indexArray = [BMChineseString IndexArray:stringsToSort];
    self.letterResultArr = [BMChineseString LetterSortArray:stringsToSort];
    //    排序2
    //模拟网络请求接收到的数组对象
    array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[stringsToSort count]; i++) {
        Person *p = [[Person alloc] init];
        p.name = [stringsToSort objectAtIndex:i];
        p.number = i;
        [array addObject:p];
    }
    NSLog(@"%@",[array objectAtIndex:1]);
    
    self.indexArray2 = [BMChineseString IndexWithArray:array Key:@"name"];
    self.letterResultArr2 = [BMChineseString sortObjectArray:array Key:@"name"];

    UITableView *table = [[UITableView alloc] initWithFrame:self.view.frame];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}

#pragma mark - UITableViewDataSource

//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.letterResultArr objectAtIndex:section] count];
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //    cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    Person *p = [[self.letterResultArr2 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = p.name;
    
    return cell;
}

//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lab.backgroundColor = [UIColor grayColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}
//头高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}




@end
