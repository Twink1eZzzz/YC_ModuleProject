//
//  YC_ProgressHUD.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/6.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YC_ProgressHUD.h"
#import <objc/runtime.h>
#import <CoreMotion/CoreMotion.h>

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface YC_ProgressHUD ()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) UIInterfaceOrientation lastOrientation;

@end

@implementation YC_ProgressHUD

+ (void)initialize
{
    [self setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
    [self setInfoImage:[UIImage imageNamed:@"HUD_info"]];
    [self setErrorImage:[UIImage imageNamed:@"HUD_error"]];
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    [self setCornerRadius:8.0];
    [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
    [self setForegroundColor:[UIColor whiteColor]];
    
}


- (NSTimeInterval)maximumDismissTimeInterval
{
    return 2;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if([self.motionManager isAccelerometerAvailable]){
        [self orientationChange];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    if (self.motionManager) {
        [self.motionManager stopAccelerometerUpdates];
        self.motionManager = nil;
    }
}

#pragma mark - 屏幕方向旋转
- (void)orientationChange
{
    WEAKSELF(weakSelf);
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration acceleration = accelerometerData.acceleration;
        __block UIInterfaceOrientation orientation;
        if (acceleration.x >= 0.75) {
            orientation = UIInterfaceOrientationLandscapeLeft;
        }
        else if (acceleration.x <= -0.75) {
            orientation = UIInterfaceOrientationLandscapeRight;
            
        }
        else if (acceleration.y <= -0.75) {
            orientation = UIInterfaceOrientationPortrait;
            
        }
        else if (acceleration.y >= 0.75) {
            orientation = UIInterfaceOrientationPortraitUpsideDown;
            return ;
        }
        else {
            // Consider same as last time
            return;
        }
        
        if (orientation != weakSelf.lastOrientation) {
            [weakSelf configHUDOrientation:orientation];
            weakSelf.lastOrientation = orientation;
            NSLog(@"%tu=-------%tu",orientation,weakSelf.lastOrientation);
        }
        
    }];
}

- (void)configHUDOrientation:(UIInterfaceOrientation )orientation
{
    CGFloat angle = [self calculateTransformAngle:orientation];
    self.transform = CGAffineTransformRotate(self.transform, angle);
}


- (CGFloat)calculateTransformAngle:(UIInterfaceOrientation )orientation
{
    CGFloat angle;
    if (self.lastOrientation == UIInterfaceOrientationPortrait) {
        switch (orientation) {
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = -M_PI_2;
                break;
            default:
                break;
        }
    } else if (self.lastOrientation == UIInterfaceOrientationLandscapeRight) {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = -M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = M_PI;
                break;
            default:
                break;
        }
    } else if (self.lastOrientation == UIInterfaceOrientationLandscapeLeft) {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI;
                break;
            default:
                break;
        }
    }
    return angle;
}

#pragma mark - Lazy Load
- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1./15.;
        
    }
    return _motionManager;
}


@end
