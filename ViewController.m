//
//  ViewController.m
//  UIConllectionViewDemo
//
//  Created by 刘东 on 16/7/18.
//  Copyright © 2016年 刘东. All rights reserved.
//

#import "ViewController.h"
#import "HeadView.h"
#import "FootView.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;

@end

@implementation ViewController

#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

static  NSString  *const myColl = @"myColl";
static  NSString  *const myHead = @"myHead";
static  NSString  *const myFoot = @"myFoot";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI{
    
    //布局对象
    _layout = [[UICollectionViewFlowLayout alloc]init];
    //横向间距
    _layout.minimumInteritemSpacing = 15;
    //纵向间距
    _layout.minimumLineSpacing = 10;
    //竖直滚动
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_layout];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:myColl];
    //注册页眉
    [_collectionView registerClass:[HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:myHead];
    //注册页脚
    [_collectionView registerClass:[FootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:myFoot];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark -- UICollectionViewDataSource

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 6;
    } if (section == 1) {
        return 8;
    }else
        return 11;
}

//为collection view添加一个补充视图(页眉或页脚),可自定义,对应表视图的section头和尾视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        HeadView *myHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:myHead forIndexPath:indexPath ];
        myHeadView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        return myHeadView;
        
    }else{
        
        FootView *myFootView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:myFoot forIndexPath:indexPath ];
        myFootView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        return myFootView;
    }
    
}

//每个Cell展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:myColl forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout
//定义页眉的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 44);
}
//定义页脚的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 16);
}
//指定 cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-40)/3-10, (SCREEN_WIDTH-40)/3-10);
}

//设定collectionView(指定区)的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(section == 0){
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else if (section == 1){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else{
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
}
//设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 15;
    
}
//设定指定区内Cell的最小行距，也可以直接设置UICollectionViewFlowLayout的minimumLineSpacing属性
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if(section == 0)
    {
        return 5;
    }
    else if(section == 1)
    {
        return 10;
    }else{
        return 15;
    }
}


#pragma mark -- UICollectionViewDelegate

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section: %ld  row: %ld",indexPath.section,indexPath.row);
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//如果要实现点击时(手指未松开)的显示状态与点击后(手指松开)的显示状态，则需要通过下面的方法来实现：
- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor purpleColor]];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor yellowColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
