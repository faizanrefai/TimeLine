//
//  customealert.h
//  popalock
//
//  Created by apple on 12/1/11.
//  Copyright 2011 fgbfg. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "OverlayView.h"


@protocol UserDelegate <NSObject>
@optional

@end

@interface customealert : OverlayView {
	
	UILabel *lblAlertTitle;
	UILabel *lblAlertMessage;
	id<UserDelegate>_userDelegate;
}

@property(nonatomic, retain) IBOutlet UILabel *lblAlertTitle;
@property(nonatomic, retain) IBOutlet UILabel *lblAlertMessage;
@property(nonatomic, assign)id<UserDelegate>_userDelegate;


+(void)showAlert:(NSString*)strHeader message:(NSString*)strMessage delegate:(id)sender;


@end