//
//  SecretKeybord.h
//  TestKeyBord
//
//  Created by 陈威 on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretKeybord : UIView

@property (nonatomic, copy) void(^dismiss)(void);

- (void)showKeybords;

-(void)hiddenKeybords;

@end
