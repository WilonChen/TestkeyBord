//
//  KeybordNumber.h
//  TestKeyBord
//
//  Created by Wilon on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeybordNumbers : UIView

@property (nonatomic, copy) void(^numberKey)(NSString *value);

@property (nonatomic, copy) void(^deleteNumber)(void);
@property (nonatomic, copy) void(^confirm)(void);

- (void)messNumber;

- (instancetype)initWithFrame:(CGRect)frame;

@end
