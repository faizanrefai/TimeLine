//
//  DrowTimeLineViewViewController.h
//  TimeLine
//
//  Created by Udayan Mandavia on 8/13/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPCmyView.h"
#import "SDZTimeline.h"
#include <QuartzCore/CoreAnimation.h>

@interface DrowTimeLineViewViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{

    NSMutableArray *dataDic;
    NSArray *monthArry;
    
    IBOutlet UITextView *textView;
    
    IBOutlet UIActivityIndicatorView *indicator;
    UIView *viewZom;
    
    IBOutlet UIButton *suckBtn;
   // IBOutlet UIView *myView;
    
  //  iPCmyView *myView;
    UIView *myView;
    
    CGPoint point;
    UIScrollView *botm;
    IBOutlet UITableView *myTable;
    
    CGPoint originalImagePos; 

}
@property (retain, nonatomic) IBOutlet UIScrollView *scrolllView;

-(void)dataStatic;
- (void)callingSevice ;
-(void)addingComponent;
- (IBAction)sucking:(id)sender;


@end
