//
//  ViewController.m
//  test
//
//  Created by Admin on 2017/12/11.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "ViewController.h"
#import "FunctionCell.h"
#import "XYSLogManager.h"
#import "MyDragAndDropCollectionViewLayout.h"
#define SCREENWIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

static NSString *HTKDraggableCollectionViewCellIdentifier = @"HTKDraggableCollectionViewCellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XYSLogVerbose(@"测试日志输出与保存");
    [self testCollectionView];
}

- (void)testCollectionView{
    
    MyDragAndDropCollectionViewLayout *layOut=[[MyDragAndDropCollectionViewLayout alloc]init];
    layOut.itemSize=CGSizeMake((SCREENWIDTH-4)/4, (SCREENWIDTH-4)/4);
    layOut.horizonSpace=1;
    layOut.verticalSpace=1;
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
//    layOut.itemSize=CGSizeMake((SCREENWIDTH-4)/4, (SCREENWIDTH-4)/4);
//    layOut.minimumInteritemSpacing=1;
//    layOut.minimumLineSpacing=1;
//    layOut.scrollDirection=UICollectionViewScrollDirectionHorizontal;
//    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionView *funcView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, (SCREENWIDTH-4)/2+3) collectionViewLayout:layOut];
    funcView.pagingEnabled = YES;
    funcView.showsVerticalScrollIndicator = NO;
    funcView.showsHorizontalScrollIndicator = NO;
    funcView.decelerationRate = UIScrollViewDecelerationRateFast;
    funcView.delegate = self;
    funcView.dataSource = self;
    [funcView registerNib:[UINib nibWithNibName:@"FunctionCell" bundle:nil]  forCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier];
    [self.view addSubview:funcView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FunctionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:HTKDraggableCollectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYSLogVerbose(@"点击了%d",indexPath.row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
