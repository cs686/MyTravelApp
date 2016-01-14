//
//  UIView+UIViewController.m
//  MyTravelApp
//
//  Created by cq on 16/1/12.
//  Copyright © 2016年 顺苹亓. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController {
    UIResponder *next=self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)next;
        }
        next=next.nextResponder;
    }
    return nil;
}

@end
