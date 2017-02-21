//
//  SIDADView.m
//  SIDAdView
//
//  Created by XU JUNJIE on 13/7/15.
//  Copyright (c) 2015 ISNC. All rights reserved.
//

#import "SIDADView.h"

#define superid_ad_color_title          HEXRGB(0x0099cc)
#define superid_ad_color_tips           HEXRGB(0x333333)

//RGB Color transform（16 bit->10 bit）
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//Screen Height and width
#define Screen_height   [[UIScreen mainScreen] bounds].size.height
#define Screen_width    [[UIScreen mainScreen] bounds].size.width
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height)
//Get View size:
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//iPhone4
#define   isIphone4  [UIScreen mainScreen].bounds.size.height < 500

@interface SIDADView()

@property(retain, nonatomic) IBOutletCollection(NSObject) NSArray* superid_ad_closeTargets;
@property(retain,nonatomic) UIButton        *closeBtn;
@property(retain,nonatomic) UIView          *bgView;
@property(retain,nonatomic) UILabel         *titleLable;
@property(retain,nonatomic) UILabel         *subTitleLable;
@property(retain,nonatomic) UIView          *titleBgView;
@property(retain,nonatomic) UIImageView     *adImageView;
@property(retain,nonatomic) NSDictionary    *characterDitionary;

@end

@implementation SIDADView

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, Screen_width, Screen_height);
        self.backgroundColor = [UIColor clearColor];
        UIView *maskView = ({
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.7;
            view;
        });
        [self addSubview:maskView];
        
        _bgView = ({
        
            UIView *view =[[UIView alloc]initWithFrame: CGRectMake(0, 0, 0.8125*Screen_width, 1.46*0.825*Screen_width)];
            view.frame = CGRectMake(0, 0, 0.8125*Screen_width, 1.46*0.825*Screen_width);
            view.center = CGPointMake(Screen_width/2, Screen_height/2);
            if (isIphone4) {
                
                self.center = CGPointMake(Screen_width/2, Screen_height/2+20);
            }
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 6.0;
            view.clipsToBounds = YES;
            view.layer.borderWidth=1;
            view.layer.borderColor=superid_ad_color_title.CGColor;
            view;
            
        });
        
        [self addSubview:_bgView];
        
        _closeBtn = ({
        
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];;
            btn.frame = CGRectMake(VIEW_BX(_bgView)-32, 30, 33, 33);
            if (isIphone4) {
                
                btn.frame = CGRectMake(VIEW_BX(_bgView)-32, 12, 33, 33);
                
            }
            [btn setBackgroundImage:[self imageOfSuperid_ad_close] forState:normal];
            [btn addTarget:self action:@selector(closeBtnClickEventHandle) forControlEvents:UIControlEventTouchUpInside];
            
            btn;
        });
        
        [self addSubview:_closeBtn];
        
        _titleBgView = ({
        
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_W(_bgView), 0.2105*VIEW_H(_bgView))];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
        [_bgView addSubview:_titleBgView];
        
        _titleLable = ({
        
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0.3*VIEW_H(_titleBgView), VIEW_W(_titleBgView), 18)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:16];
            lable.textColor = superid_ad_color_title;
            lable;
        });
        [_titleBgView addSubview:_titleLable];
        
        _subTitleLable = ({
        
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, VIEW_BY(_titleLable)+0.075*VIEW_H(_titleBgView), VIEW_W(_titleBgView), 14)];
            lable.backgroundColor = [UIColor clearColor];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:12];
            lable.textColor = superid_ad_color_tips;
            lable.text = @"一登权威鉴定";
            lable;
        });
        
        [_titleBgView addSubview:_subTitleLable];
        
        _adImageView = ({
        
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, VIEW_BY(_titleBgView), VIEW_W(_bgView), VIEW_H(_bgView)-VIEW_H(_titleBgView))];
            
            view;
            
        });
        [_bgView addSubview:_adImageView];
        
        NSArray *textArray = [[NSArray alloc]initWithObjects:@"含蓄",@"活泼",@"成熟",@"风趣",@"严肃",@"和蔼", nil];
        NSArray *keyArray  = [[NSArray alloc]initWithObjects:@"reserved",@"lively",@"mature",@"humorous",@"serious",@"kindly", nil];
        
        _characterDitionary = [[NSDictionary alloc]initWithObjects:textArray forKeys:keyArray];
    }
    
    return self;
}

- (void)showInFaceInfo: (NSDictionary *)info advertisementImage: (UIImage *)image borderColor: (UIColor *)color{
    
    if (!info) {
        
        return;
    }
    
    _titleLable.text  =[self featureTransform:info];
    _adImageView.image = image;
    if (color) {
        
        _bgView.layer.borderColor = color.CGColor;
        
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
}

- (void)showWithFaceInfo: (NSDictionary *)info advertisementImage: (UIImage *)image borderColor: (UIColor *)color{
    
    if (!info) {
        
        return;
    }

    _titleLable.text  =[self featureTransform:info];
    _adImageView.image = image;
    if (color) {
        
        _bgView.layer.borderColor = color.CGColor;

    }
    [[self getCurrentVC].view addSubview:self];
    
}

- (void)closeBtnClickEventHandle{
    
    [self removeFromSuperview];
    _adImageView.image = nil;
    _titleLable.text = nil;

}

- (void)dealloc{
    
    _titleLable = nil;
    _adImageView = nil;
    _subTitleLable = nil;
    _bgView = nil;
    _titleBgView = nil;
    _closeBtn = nil;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)drawSuperid_ad_close
{
    //// Color Declarations
    UIColor* white = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// yuan Drawing
    UIBezierPath* yuanPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(2, 2, 60, 61)];
    [white setStroke];
    yuanPath.lineWidth = 2;
    [yuanPath stroke];
    
    
    //// mid Drawing
    UIBezierPath* midPath = UIBezierPath.bezierPath;
    [midPath moveToPoint: CGPointMake(30.01, 32.5)];
    [midPath addLineToPoint: CGPointMake(18.74, 43.96)];
    [midPath addCurveToPoint: CGPointMake(18.74, 45.98) controlPoint1: CGPointMake(18.2, 44.51) controlPoint2: CGPointMake(18.19, 45.42)];
    [midPath addCurveToPoint: CGPointMake(20.73, 45.98) controlPoint1: CGPointMake(19.29, 46.54) controlPoint2: CGPointMake(20.18, 46.54)];
    [midPath addLineToPoint: CGPointMake(32, 34.52)];
    [midPath addLineToPoint: CGPointMake(43.27, 45.98)];
    [midPath addCurveToPoint: CGPointMake(45.26, 45.98) controlPoint1: CGPointMake(43.82, 46.54) controlPoint2: CGPointMake(44.71, 46.54)];
    [midPath addCurveToPoint: CGPointMake(45.26, 43.96) controlPoint1: CGPointMake(45.81, 45.42) controlPoint2: CGPointMake(45.8, 44.51)];
    [midPath addLineToPoint: CGPointMake(33.99, 32.5)];
    [midPath addLineToPoint: CGPointMake(45.26, 21.04)];
    [midPath addCurveToPoint: CGPointMake(45.26, 19.02) controlPoint1: CGPointMake(45.8, 20.49) controlPoint2: CGPointMake(45.81, 19.58)];
    [midPath addCurveToPoint: CGPointMake(43.27, 19.02) controlPoint1: CGPointMake(44.71, 18.46) controlPoint2: CGPointMake(43.82, 18.46)];
    [midPath addLineToPoint: CGPointMake(32, 30.48)];
    [midPath addLineToPoint: CGPointMake(20.73, 19.02)];
    [midPath addCurveToPoint: CGPointMake(18.74, 19.02) controlPoint1: CGPointMake(20.18, 18.46) controlPoint2: CGPointMake(19.29, 18.46)];
    [midPath addCurveToPoint: CGPointMake(18.74, 21.04) controlPoint1: CGPointMake(18.19, 19.58) controlPoint2: CGPointMake(18.2, 20.49)];
    [midPath addLineToPoint: CGPointMake(30.01, 32.5)];
    [midPath closePath];
    midPath.miterLimit = 4;
    
    midPath.usesEvenOddFillRule = YES;
    
    [white setFill];
    [midPath fill];
}

#pragma mark Generated Images
static UIImage* _imageOfSuperid_ad_close = nil;

- (UIImage*)imageOfSuperid_ad_close
{
    if (_imageOfSuperid_ad_close)
        return _imageOfSuperid_ad_close;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(64, 64), NO, 0.0f);
    [self drawSuperid_ad_close];
    
    _imageOfSuperid_ad_close = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return _imageOfSuperid_ad_close;
}

#pragma mark Customization Infrastructure

- (void)setSuperid_ad_closeTargets: (NSArray*)superid_ad_closeTargets
{
    _superid_ad_closeTargets = superid_ad_closeTargets;
    
    for (id target in self.superid_ad_closeTargets)
        [target setImage: self.imageOfSuperid_ad_close];
}

- (NSString *)featureTransform:(NSDictionary *)info{
    
    NSString *str = [NSString stringWithFormat:@"我是一个%@%@的%@",[self getUserCharacterStr:info],[self getUserAppearanceStrFromInfo:info],[self getGenerationStr:info]];
    return str;
    
}

- (NSString *)getUserCharacterStr:(NSDictionary *)dict{
    
    NSString *key = [dict objectForKey:@"character"];

    if (dict && key ) {
        
        if ([_characterDitionary objectForKey:key]) {
            
            return [_characterDitionary objectForKey:key];
        }else{
            
            return @"幸运";
        }
        
        
    }else{
        
        return @"幸运";
    }
}

- (NSString *)getUserAppearanceStrFromInfo: (NSDictionary *)dict{
    
    NSArray *tagsArray = [dict objectForKey:@"tags"];

    if (!tagsArray) {
        
        return @"";
    }
    BOOL isGoodLooking = NO;
    
    for (int i = 0; i<[tagsArray count]; i++) {
        
        if ([[tagsArray objectAtIndex:i]isEqualToString:@"goodLooking"]) {
            
            isGoodLooking = YES;
            
        }
    }
    if (isGoodLooking == YES) {
        
        if ([[dict objectForKey:@"gender"] isEqualToString:@"male"]) {
            
            return @"帅气";
        }else{
            
            return @"漂亮";
        }
        
    }else{
        
        return @"";
    }

}

- (NSString *)getGenerationStr:(NSDictionary *)info{

    NSString *str = [info objectForKey:@"generation"];
    if (str) {
        
        NSString *ageStr = [str substringToIndex:2];
        ageStr = [NSString stringWithFormat:@"%@后",ageStr];
        return ageStr;
    }else{
        
        return @"人";
    }
    
}

@end
