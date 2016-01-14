//
//  MainCollectionView.h
//  MyTravelApp
//
//  Created by cq on 16/1/11.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionView : UICollectionView<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSArray *imageNames;
@property (nonatomic,strong) NSArray *imageData;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles imageData:(NSArray *)imageData imageNames:(NSArray*)imageNAmes;

@end
