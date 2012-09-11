//
//  iPCTwitterVC.h
//  TimeLine
//
//  Created by Udayan Mandavia on 9/7/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface iPCTwitterVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
{

    IBOutlet UITableView *myTable;
    NSURLConnection *conn;
    IBOutlet UITableViewCell *cellCustm;
    
    IBOutlet EGOImageView *imagViw;
    NSMutableArray*    tweetArry;
    NSMutableArray*  imageArray;
    IBOutlet UITextView *label;


}


@end
