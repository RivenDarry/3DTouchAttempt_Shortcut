//
//  CheckinViewController.m
//  3DTouchAttempt
//
//  Created by mac on 16/2/16.
//
//

#import "CheckinViewController.h"

@interface CheckinViewController ()

@end

@implementation CheckinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *shortcut = [UIApplication sharedApplication].shortcutItems;
    NSMutableArray *new = [shortcut mutableCopy];
    for (UIApplicationShortcutItem *item in new) {
        if ([item.type isEqualToString:@"checkin"]) {
            UIMutableApplicationShortcutItem *newItem = [item mutableCopy];
            [newItem setLocalizedTitle:@"已签到" ];
            [newItem setLocalizedSubtitle:@"当前积分：688"];
            [new replaceObjectAtIndex:0 withObject:newItem];
            break;
        }
    }
    [UIApplication sharedApplication].shortcutItems = new;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
