//
//  KeybordTextField.h
//  TestKeyBord
//
//  Created by Wilon on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeybordTextField : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)changeValues:(NSString *)string;

- (void)deleteNumber;

@end
