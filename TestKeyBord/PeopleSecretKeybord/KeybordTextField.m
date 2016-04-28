//
//  KeybordTextField.m
//  TestKeyBord
//
//  Created by Wilon on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import "KeybordTextField.h"
#import "KeybordNumbers.h"

@interface KeybordTextField ()
@property (nonatomic, strong) UILabel *pwdLabel;
@property (nonatomic, copy) NSMutableString *pwd;
@end

@implementation KeybordTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
         _pwd = [[NSMutableString alloc] init];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)creatUI {
    _pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _pwdLabel.tag = 100;
    [self addSubview:_pwdLabel];
    _pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _pwdLabel.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _pwdLabel.layer.borderWidth = 1.0f;
    _pwdLabel.textColor = [UIColor redColor];
    [self addSubview:_pwdLabel];
}

- (void)changeValues:(NSString *)string {
    if (_pwd.length > 3) {
        return;
    }
    [_pwd appendString:string];
    _pwdLabel.text = _pwd;
    
}
- (void)deleteNumber {
    NSUInteger length = _pwd.length;
    NSString *string = [[NSString alloc] initWithString:_pwd];
    if (length > 1) {
      _pwd = (NSMutableString *)[string substringToIndex:length -1];
    } else {
        _pwd = [NSMutableString stringWithFormat:@""];
    }
    _pwdLabel.text = _pwd;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
