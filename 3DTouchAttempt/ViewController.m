//
//  ViewController.m
//  3DTouchAttempt
//
//  Created by mac on 16/1/27.
//
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL isLogin;
}
@property (nonatomic, strong)NSArray *component;

@end

@implementation ViewController

- (IBAction)deleteShortcut:(id)sender {
    
    NSArray *shortcut = [UIApplication sharedApplication].shortcutItems;
    NSMutableArray *new = [shortcut mutableCopy];
    for (UIApplicationShortcutItem *item in new) {
        if ([item.type isEqualToString:@"changeIcon"]) {
            [new removeObject:item];
            break;
        }
    }
    [UIApplication sharedApplication].shortcutItems = new;
    
    UIAlertController *alerC = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"那个动态显示图标的标签已被删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [alerC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alerC addAction:okAction];
    [self presentViewController:alerC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height / 3 * 2)];
    self.component = @[@"UIApplicationShortcutIconTypeCompose",
                       @"UIApplicationShortcutIconTypePlay",
                       @"UIApplicationShortcutIconTypePause",
                       @"UIApplicationShortcutIconTypeAdd",
                       @"UIApplicationShortcutIconTypeLocation",
                       @"UIApplicationShortcutIconTypeSearch",
                       @"UIApplicationShortcutIconTypeShare",
                       @"UIApplicationShortcutIconTypeProhibit",
                       @"UIApplicationShortcutIconTypeContact",
                       @"UIApplicationShortcutIconTypeHome",
                       @"UIApplicationShortcutIconTypeMarkLocation",
                       @"UIApplicationShortcutIconTypeFavorite",
                       @"UIApplicationShortcutIconTypeLove",
                       @"UIApplicationShortcutIconTypeCloud",
                       @"UIApplicationShortcutIconTypeInvitation",
                       @"UIApplicationShortcutIconTypeConfirmation",
                       @"UIApplicationShortcutIconTypeMail",
                       @"UIApplicationShortcutIconTypeMessage",
                       @"UIApplicationShortcutIconTypeDate",
                       @"UIApplicationShortcutIconTypeTime",
                       @"UIApplicationShortcutIconTypeCapturePhoto",
                       @"UIApplicationShortcutIconTypeCaptureVideo",
                       @"UIApplicationShortcutIconTypeTask",
                       @"UIApplicationShortcutIconTypeTaskCompleted",
                       @"UIApplicationShortcutIconTypeAlarm",
                       @"UIApplicationShortcutIconTypeBookmark",
                       @"UIApplicationShortcutIconTypeShuffle",
                       @"UIApplicationShortcutIconTypeAudio",
                       @"UIApplicationShortcutIconTypeUpdate" ];
    pickView.dataSource = self;
    pickView.delegate = self;
    
    [self.view addSubview:pickView];
    
}
#pragma mark - data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.component.count;
}

#pragma mark - delegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"不操作";
    }
    return [NSString stringWithFormat:@"%@", [_component[row-1] stringByReplacingOccurrencesOfString:@"UIApplicationShortcutIconType" withString:@""]];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        return;
    }
    
    NSMutableArray *old = [[UIApplication sharedApplication].shortcutItems mutableCopy];
    NSLog(@"%@", old);
    
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:row-1];
    UIApplicationShortcutItem *newShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"changeIcon" localizedTitle:[_component[row-1] stringByReplacingOccurrencesOfString:@"UIApplicationShortcutIconType" withString:@""] localizedSubtitle:nil icon:icon userInfo:nil];
    
    [self updateShortcutWithArray:old Index:1 Object:newShortcut];
    
    [UIApplication sharedApplication].shortcutItems = old;
}

- (IBAction)login:(id)sender {
    NSArray *shortcut = [UIApplication sharedApplication].shortcutItems;
    NSMutableArray *new = [shortcut mutableCopy];
    
    if (isLogin) {
        [(UIBarButtonItem*)sender setTitle:@"未登录"];
        
        for (UIApplicationShortcutItem *item in new) {
            if ([item.type isEqualToString:@"checkin"]) {
                [new removeObject:item];
                break;
            }
        }
        [UIApplication sharedApplication].shortcutItems = new;
        
    }else {
        [(UIBarButtonItem*)sender setTitle:@"已登录"];
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
        UIApplicationShortcutItem *newShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"checkin" localizedTitle:@"今日签到"  localizedSubtitle:nil icon:icon userInfo:nil];
        
        [self updateShortcutWithArray:new Index:0 Object:newShortcut];
        [UIApplication sharedApplication].shortcutItems = new;
    }
    
    isLogin = !isLogin;
}

- (void)updateShortcutWithArray:(NSMutableArray*)array Index:(NSInteger)index Object:(UIApplicationShortcutItem*)object
{
    if (array.count == 2) {
        [array replaceObjectAtIndex:index withObject:object];
    }else if (array.count == 0 ) {
        [array addObject:object];
    }else {
        for (UIApplicationShortcutItem *item in array) {
            if ([item.type isEqualToString:@"checkin"]) {
                if (index == 0) {
                    [array replaceObjectAtIndex:index withObject:object];
                }else {
                    [array insertObject:object atIndex:index];
                }
            }else {
                if (index == 1) {
                    [array replaceObjectAtIndex:0 withObject:object];
                }else {
                    [array insertObject:object atIndex:index];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
