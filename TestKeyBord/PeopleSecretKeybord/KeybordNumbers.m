//
//  KeybordNumber.m
//  TestKeyBord
//
//  Created by Wilon on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import "KeybordNumbers.h"

#define BtnTag 500

@interface KeybordNumbers ()
@property (nonatomic, strong) NSMutableArray *numberArray;

@end

@implementation KeybordNumbers

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initData];
        [self messNumber];
    }
    return self;
}

- (void)initData {
    _numberArray = [[NSMutableArray alloc] initWithCapacity:10];
}

- (void)creatNumberView {
    CGFloat width = self.frame.size.width / 4;
    CGFloat height = self.frame.size.height / 3;
    
    for (int i = 0; i < 12; i++) {
         UIButton *buttons = [UIButton buttonWithType:UIButtonTypeCustom];
        buttons.frame = CGRectMake(width * (i % 4), height * (i / 4), width, height);
        buttons.layer.borderColor = [UIColor grayColor].CGColor;
        buttons.layer.borderWidth = 1.0f;
        buttons.backgroundColor = [UIColor lightGrayColor];
        buttons.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        if (i % 4 == 3 && i / 4 == 1) {
            [buttons setTitle:
             [NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
        } else if (i % 4 == 3 && i / 4 == 2) {
            [buttons setTitle:
             [NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
        } else {
            if (i / 4 == 2) {
                [buttons setTitle:
                 [NSString stringWithFormat:@"%@",[_numberArray objectAtIndex:i - 1]]forState:UIControlStateNormal];
            } else {
                [buttons setTitle:
                 [NSString stringWithFormat:@"%@",[_numberArray objectAtIndex:i]]forState:UIControlStateNormal];
            }
        }
        
        [buttons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [buttons addTarget:self action:@selector(numberPut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttons];
    }
}

- (void)messNumber {
    [_numberArray removeAllObjects];
    for (int i = 0; i < 10; i++) {
        [_numberArray addObject:[NSNumber numberWithInt:i]];
    }
    for (int j = 1 ; j < _numberArray.count; j++) {
        int m = arc4random() % j;
        [_numberArray exchangeObjectAtIndex:j - 1 withObjectAtIndex:m];
    }
    [self creatNumberView];
}


- (void)numberPut:(UIButton *)btn {
    if ([btn.currentTitle isEqualToString:@"删除"]) {
        if (_deleteNumber) {
            _deleteNumber();
        }
    } else if ([btn.currentTitle isEqualToString:@"确定"]) {
        if (_confirm) {
            _confirm();
        }
    } else {
        if (_numberKey) {
            _numberKey(btn.titleLabel.text);
        }
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
