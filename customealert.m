//
//  customealert.m
//  popalock
//
//  Created by apple on 12/1/11.
//  Copyright 2011 fgbfg. All rights reserved.
//

#import "customealert.h"


@implementation customealert

@synthesize lblAlertTitle;
@synthesize lblAlertMessage;
@synthesize _userDelegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

+(void)showAlert:(NSString*)strHeader message:(NSString*)strMessage delegate:(id)sender{
	
	UIViewController *controller = [[UIViewController alloc] initWithNibName:@"customealert" bundle:[NSBundle mainBundle]];
	customealert *customeAlertView = (customealert *)controller.view;
	customeAlertView.lblAlertTitle.text = strHeader;
	customeAlertView.lblAlertMessage.text = strMessage;
	customeAlertView._userDelegate =sender;
	[customeAlertView show];
	[controller release];
}
- (void)dialogWillAppear {
	[super dialogWillAppear];
}


- (void)dialogWillDisappear {
	[super dialogWillDisappear];
}


- (void)dealloc {
	[lblAlertTitle release];
	[lblAlertMessage release];
    [super dealloc];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



@end
