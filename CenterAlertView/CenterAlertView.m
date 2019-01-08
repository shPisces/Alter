//
//  CenterAlertView.m
//  XueGaoQunLite
//
//  Created by 宋航航 on 2017/11/3.
//  Copyright © 2017年 Adinnet. All rights reserved.
//

#import "CenterAlertView.h"

#define SCREEN_WIDTH    CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT   CGRectGetHeight([UIScreen mainScreen].bounds)

@interface CenterAlertView()<UIGestureRecognizerDelegate>{
    BOOL _isClickedBgDis;// 是否可以点击背景消失
}
@property (weak, nonatomic) IBOutlet UIView *alertBgView;                       // 提示背景
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;                       // 标题
@property (weak, nonatomic) IBOutlet UILabel *conntentLabel;                    // 提示内容
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;                         // 左侧按钮
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;                        // 右侧按钮
@property (weak, nonatomic) IBOutlet UIView *centerLineView;                    // 按钮中间分割线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopHeight;   // 标题距顶部的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnWidth;         // 右侧按钮的宽度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHeight;      // 标题的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelTopHeight; // 内容提示距离上部的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alterBgViewCenterY;    // 提示背景页面距离中心位置的高度

@end

@implementation CenterAlertView

+ (instancetype)setCenterAlertView{
    CenterAlertView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
     self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    // 设置提示背景圆角
    _alertBgView.layer.cornerRadius  = 14.f;
    _alertBgView.layer.masksToBounds = YES;
    _alterBgViewCenterY.constant = SCREEN_HEIGHT;
    
    _isClickedBgDis = YES;
}

- (void)setIsForcedClickedClose:(BOOL)isForcedClickedClose{
    _isForcedClickedClose = isForcedClickedClose;
    _isClickedBgDis = !_isForcedClickedClose;
}

- (void)showCenterAlertViewWithTitle:(NSString *)title content:(NSString *)content leftActionBtn:(NSString *)leftActionBtn rightActionBtn:(NSString *)rightActionBtn isClickedBgDis:(BOOL )isClickedBgDis {
    
    
    
    _titleLabel.text = title;
    _conntentLabel.text = content;
    
    if (title.length == 0) {
        [self showNoTitleHanding];
    }
    
    if (content.length == 0) {
        [self showNoCountHanding];
    }
    
    // 按钮显示 处理是否显示右侧按钮事件
    [_leftBtn setTitle:leftActionBtn forState:UIControlStateNormal];
    if (rightActionBtn) {
        [_rightBtn setTitle:rightActionBtn forState:UIControlStateNormal];
    }
    else{
        [self showOneBtnHanding];
    }
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        _alterBgViewCenterY.constant = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
    // 点击背景消失功能
    _isClickedBgDis = isClickedBgDis;
}

// 通用
- (void)showCenterAlertViewWithContent:(NSString *)content leftActionBtn:(NSString *)leftActionBtn rightActionBtn:(NSString *)rightActionBtn isShowAlerTitle:(BOOL)isShowAlerTitle{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
    if (!isShowAlerTitle) {
        [self showNoTitleHanding];
    }
    
    _conntentLabel.text = content;
    
    [_leftBtn setTitle:leftActionBtn forState:UIControlStateNormal];
    
    if (rightActionBtn) {
        [_rightBtn setTitle:rightActionBtn forState:UIControlStateNormal];
    }
    else{
        [self showOneBtnHanding];
    }
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    // 点击背景消失功能
//    _isClickedBgDis = !isForcedClickedClose;
}

// 申请互动提示
- (void)showAplyInteractiveAlertWithAplyUserName:(NSString *)aplyUserName leftActionBtn:(NSString *)leftActionBtn rightActionBtn:(NSString *)rightActionBtn{
    
    // 关闭 小提示 字样
    [self showNoTitleHanding];
    _conntentLabel.font = [UIFont systemFontOfSize:16];
    
    NSString *content = [NSString stringWithFormat:@"刚才上头条的用户\n@%@申请与您互动",aplyUserName];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:content];
    NSRange aplyUserNameRange = NSMakeRange([content rangeOfString:aplyUserName].location - 1, [content rangeOfString:aplyUserName].length +1);
    
    [attrStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff5e86) range: aplyUserNameRange];
    _conntentLabel.attributedText = attrStr;
    
    [_leftBtn setTitle:leftActionBtn forState:UIControlStateNormal];
    
    if (rightActionBtn) {
        [_rightBtn setTitle:rightActionBtn forState:UIControlStateNormal];
    }
    else{
        [self showOneBtnHanding];
    }
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    // 取消点击背景消失功能
    _isClickedBgDis = NO;
}

- (IBAction)leftBtnAction:(UIButton *)sender {
    [self removeFromSuperview];
    if (_centerAlertViewBtnClikcedBlock) {
        _centerAlertViewBtnClikcedBlock(sender.titleLabel.text);
    }
}

- (IBAction)rightBtnAction:(UIButton *)sender {
    [self removeFromSuperview];
    if (_centerAlertViewBtnClikcedBlock) {
        _centerAlertViewBtnClikcedBlock(sender.titleLabel.text);
    }
}


#pragma mark - 不显示 标题 字样
- (void)showNoTitleHanding{
    _titleLabel.hidden = YES;
    _titleLabel.text = @"";
    _titleLabelTopHeight.constant = 0.001f;
    _contentLabelTopHeight.constant = 0.001f;
}

#pragma mark - 不显示提示内容字样
- (void)showNoCountHanding {
    _conntentLabel.hidden = YES;
    _conntentLabel.text = @"";
    _contentLabelTopHeight.constant = 10.f;
    
}

#pragma mark - 显示一个按钮
- (void)showOneBtnHanding {
    _rightBtn.hidden        = YES;
    _rightBtnWidth.constant = 0.001f;
    _centerLineView.hidden  = YES;
}

- (void)drawRect:(CGRect)rect{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewTapClick:)];
    tap.cancelsTouchesInView = NO;
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)shareViewTapClick:(UITapGestureRecognizer *)tap {
    
    if (!_isClickedBgDis) {
        return;
    }
    
    // 移除view
    [self removeView];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.alertBgView]) {
        return NO;
    }
    return YES;
}

- (void)removeView {
    
    [UIView animateWithDuration:0.3 animations:^{
        _alterBgViewCenterY.constant = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
