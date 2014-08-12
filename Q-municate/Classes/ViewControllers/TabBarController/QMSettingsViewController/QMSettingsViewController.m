//
//  QMSettingsViewController.m
//  Q-municate
//
//  Created by Igor Alefirenko on 06/03/2014.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMSettingsViewController.h"
#import "REAlertView+QMSuccess.h"
#import "SVProgressHUD.h"
#import "SDWebImageManager.h"
#import "QMApi.h"

@interface QMSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *logoutCell;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *changePasswordCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *profileCell;
@property (weak, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cacheSize;

@end

@implementation QMSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([FBSession activeSession].state == FBSessionStateOpen) {
        [self cell:self.changePasswordCell setHidden:YES];
    }
    
    [self configureSettingsViewController];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak __typeof(self)weakSelf = self;
    [[[SDWebImageManager sharedManager] imageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        weakSelf.cacheSize.text = [NSString stringWithFormat:@"Cache size: %.2f mb", (float)totalSize / 1024.f / 1024.f];
    }];
}

- (void)configureSettingsViewController {
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:kSettingsCellBundleVersion];
    self.versionLabel.text = appVersion;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.logoutCell) {
        
        __weak __typeof(self)weakSelf = self;
        [REAlertView presentAlertViewWithConfiguration:^(REAlertView *alertView) {
            
            alertView.message = NSLocalizedString(@"QM_STR_ARE_YOU_SURE", nil);
            [alertView addButtonWithTitle:NSLocalizedString(@"QM_STR_LOGOUT", nil) andActionBlock:^{
                [[QMApi instance] logout:^(BOOL success) {
                    [weakSelf performSegueWithIdentifier:kSplashSegueIdentifier sender:nil];
                }];
            }];
            
            [alertView addButtonWithTitle:NSLocalizedString(@"QM_STR_CANCEL", nil) andActionBlock:^{}];
        }];
    }
}

- (IBAction)pressClearCache:(id)sender {
    
    __weak __typeof(self)weakSelf = self;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:^{
        
        [SVProgressHUD dismiss];
        [[[SDWebImageManager sharedManager] imageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
            weakSelf.cacheSize.text = [NSString stringWithFormat:@"Cache size: %.2f mb", (float)totalSize / 1024.f / 1024.f];
        }];
    }];
}

@end