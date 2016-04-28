//
//  SecretKeybord.m
//  TestKeyBord
//
//  Created by 陈威 on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import "SecretKeybord.h"
#import "KeybordNumbers.h"
#import "KeybordTextField.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface SecretKeybord ()
@property (nonatomic, strong) KeybordNumbers *keyNumber ;
@end



@implementation SecretKeybord

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0,  kHeight, kWidth, 216)];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self creatBackView];
    }
    return self;
}

- (void)creatBackView {
    KeybordTextField *textField = [[KeybordTextField alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 50)];
    [self addSubview:textField];
    
    _keyNumber = [[KeybordNumbers alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(textField.frame) + 10, kWidth - 20, self.frame.size.height - CGRectGetMaxY(textField.frame))];
    _keyNumber.numberKey = ^ (NSString *number) {
        [textField changeValues:number];
    };
    _keyNumber.deleteNumber = ^ (void) {
        [textField deleteNumber];
    };
    
    __weak typeof(self) weakSelf = self;
    _keyNumber.confirm = ^(void) {
        if (weakSelf.dismiss) {
            weakSelf.dismiss();
        }
    };
    
    [self addSubview:_keyNumber];
}

- (void)showKeybords {
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.frame;
        CGFloat floatY = kHeight - 216;
        frame.origin.y = floatY;
        self.frame = frame;
    }];
}

- (void)hiddenKeybords {
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.frame;
        CGFloat floatY = kHeight + 216;
        frame.origin.y = floatY;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
