//
//  iPCViewController.h
//  TimeLine
//
//  Created by Udayan Mandavia on 8/9/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "iPCTwitterVC.h"

@interface iPCViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>
{


    IBOutlet UIButton *sukBtn;
    IBOutlet UIImageView *myImg;
    IBOutlet UIButton *fromBtn;
    IBOutlet UIButton *toBtn;
    IBOutlet UIPickerView *pickerDate;
    IBOutlet UIToolbar *toolBar;
    NSMutableArray *years;
    


}
- (IBAction)twittPressed:(id)sender;

- (IBAction)suckEff:(id)sender;
 @property(nonatomic,retain) IBOutlet UIImageView *myImg;
@property(nonatomic,retain) IBOutlet UIButton *sukBtn;

- (IBAction)fromPressed:(id)sender ;
- (IBAction)backPressed:(id)sender;
- (IBAction)drowTimeLinePressed:(id)sender;

- (IBAction)toPressed:(id)sender ;


@end
