//
//  MainCollectionView.m
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "MainCollectionView.h"

@implementation MainCollectionView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles imageData:(NSArray *)imageData imageNames:(NSArray *)imageNAmes{
    _titles=titles;
    _imageData=imageData;
    _imageNames=imageNAmes;
    //布局设置
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(43, 43);
    layout.minimumLineSpacing=30;
    layout.minimumInteritemSpacing=20;
    layout.sectionInset=UIEdgeInsetsMake(10, 15, 20, 15);
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.showsHorizontalScrollIndicator=NO;
    }
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    [imageView sd_setImageWithURL:_imageData[indexPath.row] placeholderImage:[UIImage imageNamed:_imageNames[indexPath.row]]];
    cell.backgroundView=imageView;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-5, 28, 50, 50)];
    label.text=_titles[indexPath.row];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:10];
    [cell addSubview:label];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index=indexPath.item;
    NSArray *urlArray =@[kScenicRecommend,kRouteReForeign,kRouteReInland];
    NSArray *searchArray =@[kScenic,kAround,kInland];
    
}

@end
