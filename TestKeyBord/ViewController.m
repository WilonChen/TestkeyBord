//
//  ViewController.m
//  TestKeyBord
//
//  Created by 陈威 on 16/4/26.
//  Copyright © 2016年 Wilon. All rights reserved.
//

#import "ViewController.h"
#import "SecretKeybord.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (nonatomic, strong) SecretKeybord *keybords;
@property (nonatomic, strong) UITextField *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 100, 20)];
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    textField.layer.borderWidth = 1.0f;
    [self.view addSubview:textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordDidHidden:) name:UIKeyboardDidHideNotification object:nil];
    
    UIButton *ss = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 100, 50)];
    ss.backgroundColor = [UIColor yellowColor];
    [ss addTarget:self action:@selector(showKeybords) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ss];
    
    UIButton *qq = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 50)];
    qq.backgroundColor = [UIColor redColor];
    [qq addTarget:self action:@selector(keybordWillShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qq];
    
}

- (void)keybordDidShow:(NSNotification *)notificition {
    UIView *keyView = [self getKeybord];
    _keybords = [[SecretKeybord alloc] init];
    
    [keyView addSubview:_keybords];
}

- (void)keybordDidHidden:(NSNotification *)notificition {
    
}

- (void)keybordWillShow {
    [_keybords hiddenKeybords];
    _keybords = nil; // 之所以要置 nil  是为了保证键盘只有一个。
}

- (UIView *)getKeybord {
    UIView* kbView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
//    　NSArray *windows = [[UIApplication sharedApplication] windows];
//    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        for (UIView *subwiew in windows) {
            NSArray *subsViews  = [subwiew subviews];
            for (UIView *keyView in subsViews) {
                for (UIInputViewController *inpt in keyView.subviews) {
                    NSLog(@"%@",[NSString stringWithUTF8String:object_getClassName(inpt)]);
                    if ([[NSString stringWithUTF8String:object_getClassName(inpt)] isEqualToString:@"UIPeripheralHostView"]) {
                        kbView = keyView;
                        return kbView;
                    }
                }
                
//                if (strstr(object_getClassName(keyView), "UIKeybord")) {
//                    kbView = keyView;
//                    return kbView;
//                }
            }
            if (kbView) {
                break;
            }
        }
//    }
//    　　for(UIView *w in ws){
//        　　NSArray *vs = [w subviews];
//        　　for(UIView *v in vs){
//            　　if([[NSString stringWithUTF8String:object_getClassName(v)] isEqualToString:@"UIPeripheralHostView"]){
//                　　kbView = v;
//                　　// NSLog(@"h %f",kbView.bounds.size.height);
//                　　break;
//                　　}
//            　　}
//        　　if (kbView) {
//            　　break;
//        }
//    }
    return nil;
//    UIView *keyboardView = nil;
//    NSArray *windows = [[UIApplication sharedApplication] windows];
//    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
//    {
//        keyboardView = [self findKeyboardInView:window];
//        if (keyboardView)
//        {
//            return keyboardView;
//        }
//    }
//    return nil;
    
}

- (void)showKeybords {
    if (!_keybords) {
        _keybords = [[SecretKeybord alloc] init];
        [self.view addSubview:_keybords];
        [_keybords showKeybords];
        __weak typeof(self) weakSelf = self;
        
        _keybords.dismiss = ^(void) {
            [weakSelf keybordWillShow];
        };
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
