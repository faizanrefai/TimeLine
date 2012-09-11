//
//  iPCViewController.m
//  TimeLine
//
//  Created by Udayan Mandavia on 8/9/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import "DrowTimeLineViewViewController.h"
#import "GenieView.h"

#import "iPCViewController.h"

@interface iPCViewController ()

@end

@implementation iPCViewController

@synthesize myImg = hideView;
@synthesize sukBtn=hideButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
   

    //Get Current Year into i2
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"yyyy"];
    int i2  = [[formatter stringFromDate:[NSDate date]] intValue]+50;
    
    
    //Create Years Array from 1960 to This year
    years = [[NSMutableArray alloc] init];
    for (int i=1960; i<=i2; i++) {
        [years addObject:[NSString stringWithFormat:@"%d",i]];
    }

   // pickerDate set
    
    
}

- (void)viewDidUnload
{
    [fromBtn release];
    fromBtn = nil;
    [toBtn release];
    toBtn = nil;
    [pickerDate release];
    pickerDate = nil;
    [toolBar release];
    toolBar = nil;
    [myImg release];
    myImg = nil;
    [sukBtn release];
    sukBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)twittPressed:(id)sender {
    
    iPCTwitterVC *obj = [[iPCTwitterVC alloc]initWithNibName:@"iPCTwitterVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:obj animated:YES];
    [obj release];

    
}

- (IBAction)suckEff:(id)sender {
    
    
    
    
    
    // render the view to an offline context
	CGColorSpaceRef csp = CGColorSpaceCreateDeviceRGB();
	if (csp == NULL) {
		[sender setEnabled:YES];
		return;
	}
	CGContextRef bmc = CGBitmapContextCreate(NULL, hideView.bounds.size.width, hideView.bounds.size.height, 
											 8, hideView.bounds.size.width * 4, csp, kCGImageAlphaPremultipliedLast);
	if (bmc == NULL) {
		CGColorSpaceRelease(csp);
		[sender setEnabled:YES];
		return;
	}
    
    
	
	CGContextTranslateCTM(bmc, 0, hideView.bounds.size.height);
	CGContextScaleCTM(bmc, 1, -1);
	[hideView.layer renderInContext:bmc];
	
	CGImageRef renderref = CGBitmapContextCreateImage(bmc);
	UIImage *render = [UIImage imageWithCGImage:renderref scale:1.0 orientation:UIImageOrientationDownMirrored];
	
	((GenieView *)myImg).viewRendered = render;
	CGImageRelease(renderref);
	
	CGContextRelease(bmc);
	CGColorSpaceRelease(csp);
	
	// calculate the bezier path
	CGMutablePathRef pathRef = CGPathCreateMutable();
	CGPathMoveToPoint(pathRef, NULL, 0, 0);
	CGPathAddCurveToPoint(pathRef, NULL, hideButton.frame.origin.x/3, hideView.bounds.size.height* 2/3, hideButton.frame.origin.x* 2/3, hideView.bounds.size.height/3, hideButton.frame.origin.x, hideButton.frame.origin.y);
	CGPathAddLineToPoint(pathRef, NULL, hideButton.frame.origin.x + hideButton.frame.size.width, hideButton.frame.origin.y);
	CGPathAddCurveToPoint(pathRef, NULL, hideView.frame.size.width* 2/3, hideView.bounds.size.height/3, hideButton.frame.size.width, hideView.bounds.size.height* 2/3, hideView.bounds.size.width, 0);
	CGPathCloseSubpath(pathRef);
	
	((GenieView *)myImg).pathRef = pathRef;
	CGPathRelease(pathRef);

    
    
    // start the draw process
	CATransition *trans = [[CATransition alloc]init];
	trans.duration = .25;
	trans.type = kCATransitionFade;
	[hideView.layer addAnimation:trans forKey:@"fade"];
	[trans release];
	hideView.hidden = YES;

    
    
//    myImg.alpha = 1.0f;
//
//    CATransition *animation = [CATransition animation];
//    animation.type = @"genieEffect";
//    [animation setAutoreverses:YES];
//    [animation setDuration:2];
//    [animation setRemovedOnCompletion:YES];
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    myImg.alpha = 0.0f;
//
//    [myImg.layer addAnimation:animation forKey:@"transitionViewAnimation"];
//
    
    
//    [UIView beginAnimations:@"genieEffect" context:NULL];
//    [UIView setAnimationTransition:108 forView:myImg cache:YES];
//    [UIView setAnimationDuration:1.0];
// //   [UIView _setAnimationFilter:200 forView:myImg];
//  //  [UIView _setAnimationFilterValue:9];
//     [UIView setAnimationPosition:CGPointMake(12, 345)];
//    [UIView commitAnimations];
//    //[myImg removeFromSuperview];


}

- (IBAction)fromPressed:(id)sender {
    

    pickerDate.hidden=FALSE;
    toolBar.hidden=FALSE;
    pickerDate.tag=1;
    
    [pickerDate selectRow:25 inComponent:0 animated:YES];

    
}

- (IBAction)backPressed:(id)sender {
    
    
    pickerDate.hidden=TRUE;
    toolBar.hidden=TRUE;
    

    
    
}

- (IBAction)drowTimeLinePressed:(id)sender {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        
        DrowTimeLineViewViewController *obj = [[DrowTimeLineViewViewController alloc]initWithNibName:@"DrowTimeLineViewViewController_iPad" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];

        
        
    } else {
        
        DrowTimeLineViewViewController *obj = [[DrowTimeLineViewViewController alloc]initWithNibName:@"DrowTimeLineViewViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:obj animated:YES];
        [obj release];

    }

    
}

- (IBAction)toPressed:(id)sender {
    

    pickerDate.hidden=FALSE;
    toolBar.hidden=FALSE;
    pickerDate.tag=2;

    [pickerDate selectRow:25 inComponent:0 animated:YES];

    
}



- (NSInteger)numberOfComponentsInPickerView: (UIPickerView*)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return [years count];
}
- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [years objectAtIndex:row];
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (pickerDate.tag==1) {
        
        [fromBtn setTitle:[years objectAtIndex:row] forState:UIControlStateNormal];
        
    }else {
        [toBtn setTitle:[years objectAtIndex:row] forState:UIControlStateNormal];
    }
    
    
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [fromBtn release];
    [toBtn release];
    [pickerDate release];
    [toolBar release];
    [myImg release];
    [sukBtn release];
    [super dealloc];
}
@end
