//
//  CenterAlertView.h
//  XueGaoQunLite
//
//  Created by 宋航航 on 2017/11/3.
//  Copyright © 2017年 Adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CenterAlertViewBtnClikcedBlock)(NSString *btnTitle);
@interface CenterAlertView : UIView


/// 是否强制点击关闭
@property (nonatomic, assign) BOOL isForcedClickedClose;

// 点击按钮返回block（通用）
@property (nonatomic, copy) CenterAlertViewBtnClikcedBlock centerAlertViewBtnClikcedBlock;

+ (instancetype) setCenterAlertView;

- (void)showCenterAlertViewWithContent:(NSString *)content leftActionBtn:(NSString *)leftActionBtn rightActionBtn:(NSString *)rightActionBtn isShowAlerTitle:(BOOL)isShowAlerTitle;

/**
 * @brief   显示提示弹窗
 * @param   title               标题
 * @param   content             提示内容
 * @param   leftActionBtn       左侧按钮名称
 * @param   rightActionBtn      右侧按钮名称
 * @param   isClickedBgDis      点击背景取消功能 YES 取消 NO 不取消
 * 标题和提示内容，返回nil为不显示
 * 只显示一个按钮时，右侧按钮名称返回nil
 */
- (void)showCenterAlertViewWithTitle:(NSString*)title content:(NSString *)content leftActionBtn:(NSString *)leftActionBtn rightActionBtn:(NSString *)rightActionBtn isClickedBgDis:(BOOL)isClickedBgDis;

@end
