//
//  DrowTimeLineViewViewController.m
//  TimeLine
//
//  Created by Udayan Mandavia on 8/13/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import "DrowTimeLineViewViewController.h"
#import "customealert.h"


@interface DrowTimeLineViewViewController ()
{
    NSMutableArray *yearArray;
    NSInteger yearLabelWidth;
}

@end

@implementation DrowTimeLineViewViewController
@synthesize scrolllView;




#pragma mark -
#pragma mark View Life Cycle Division 



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataDic  = [[NSMutableArray alloc]init];    
    yearArray  = [[NSMutableArray alloc]init];    
    
    //Calling self data method; 
    
    
    [indicator startAnimating];
    
    [self dataStatic];
    [self performSelector:@selector(callingSevice) withObject:nil afterDelay:1];
    
    // Do any additional setup after loading the view from its nib.
}





#pragma mark -
#pragma mark Scroll View Delegate Method 



- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    
    if (scrollView.tag==2){
        
        return;
    }
    
    
  //  myView.scale = scale;
    
    NSLog(@"scrollViewDidEndZooming  %f",scale);

    
   // NSLog(@"scrollViewDidEndZooming  %f",scrolllView.);
    NSLog(@"scrollViewDidEndZooming  %f",scale);

    
//    [myView setNeedsDisplay];
   // [self resetImageZoom];

    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag==2){
        
        return nil;
    }

    return myView;

}



-(void)scrollViewDidZoom:(UIScrollView *)scrollView{

     
    
    if (scrollView.tag==2){
        
        return;
    }
    
    NSLog(@"scrollViewDidZoom");
    NSLog(@"scrollViewDidEndZooming at Scale %f",scrolllView.zoomScale);
    
  //  int val = [[NSString stringWithFormat:@"%0.f",scrolllView.zoomScale] intValue];
    
   // imageView1.image =[UIImage imageNamed:[NSString stringWithFormat:@"Photo%d.jpg",val]]; 
    


}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{

    NSLog(@"scrollViewWillBeginZooming");
}


-(void)resetImageZoom {
    
    NSLog(@"Resetting any image zoom");
    
    CGAffineTransform transform = CGAffineTransformMakeScale(2.0, 2.0);
    myView.transform = transform;
    scrolllView.contentSize = CGSizeMake(myView.frame.size.width, myView.frame.size.height) ;

   // [scrolllView setContentSize:CGSizeZero];
    
   // myView.center = originalImagePos;
    myView.center = scrolllView.center;
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.tag==2) {
        
        point = scrollView.contentOffset;
        CGPoint po = CGPointMake(point.x* ((myView.frame.size.width/yearArray.count) /(yearLabelWidth-1)), point.y);
//        NSLog(@" point.x*10   %f",point.x*25.6);
//        NSLog(@"point.y  %f",point.y);
//        NSLog(@"myView.frame.size.width/20)/12  %f",(myView.frame.size.width/20));
        [scrolllView setContentOffset:po animated:YES];
        return;

    }
  //  NSLog(@"scrollViewDidScroll");

}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{


}

//-(NSArray *)scrolllViewAtIndexes:(NSIndexSet *)indexes
//{
//
//
//}



-(void)dataStatic
{
    
    monthArry = [[NSArray alloc]initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"June",@"July",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    
}


#pragma mark -
#pragma mark  Webservice Integration Section !!

- (void)callingSevice {
	
    
    // Create the service
    
	SDZTimeline* service = [SDZTimeline service];
	service.logging = YES;
	// service.username = @"username";
	// service.password = @"password";
	
    NSLog(@"Calling WS");

    [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
    
	// Returns CXMLNode*. 
	[service GetTimeLineData:self action:@selector(GetTimeLineDataHandler:)];
    
	// Returns CXMLNode*. 
	//[service GetTimeLineDataWithRequest:self action:@selector(GetTimeLineDataWithRequestHandler:) PatientID: @"0"];
}

// Handle the response from GetTimeLineDataWithRequest.

- (void) GetTimeLineDataWithRequestHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
    
    
	// Do something with the CXMLNode* result
    CXMLNode* result = (CXMLNode*)value;
	NSLog(@"GetTimeLineDataWithRequest returned the value: %@", result);
    
}


// Handle the response from GetTimeLineData.

- (void) GetTimeLineDataHandler: (id) value {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=FALSE;
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
    
    
	// Do something with the CXMLNode* result
    
    
   // CXMLNode* result = (CXMLNode*)value;
    
    [dataDic removeAllObjects];
    [dataDic addObjectsFromArray:[[[[value  valueForKey:@"GetTimeLineDataResponse"] valueForKey:@"GetTimeLineDataResult"] valueForKey:@"Datasets"]valueForKey:@"Data"] ];
    
//	NSLog(@"GetTimeLineData returned the value: %@",dataDic );
    [self addingComponent];
     
}



#pragma mark -
#pragma mark  Drow Timleine !!


-(void)addingComponent
{

    [myTable reloadData];
    // NSLog(@"%@", [self findMaximumMinimun:dataDic]);
    
    NSDictionary *dic = [self findMaximumMinimun:dataDic];
    // My View Purple Coordinate Set
    [yearArray removeAllObjects];

    NSInteger min=  [[dic valueForKey:@"minimumYear"] intValue];
    NSInteger max= [[dic valueForKey:@"maximumYear"] intValue];
    
    for (int i = min ;max>=i ; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
        
    //NSLog(@"%@",yearArray);
        
    
    myView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,  scrolllView.frame.size.width*(2*yearArray.count), scrolllView.frame.size.height)];
   // myView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"backGround.png"]];
    
    UIImageView *imge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backGround.png"]];
    imge.frame = myView.frame;
    [myView addSubview:imge];
    [imge release];

  
    // Scroll View Property set
    
    scrolllView.maximumZoomScale = 10.0;
	scrolllView.minimumZoomScale = 1.0;
    scrolllView.tag=1;
    [scrolllView setCanCancelContentTouches:NO];
    scrolllView.clipsToBounds = YES;
    scrolllView.contentSize = CGSizeMake(myView.frame.size.width, myView.frame.size.height) ;
    [scrolllView addSubview:myView];
    

    // Year label Width Set
 
    if (yearArray.count <4) {
        
        yearLabelWidth = (scrolllView.frame.size.width *0.6);

    }else if(yearArray.count<7) {
        
        yearLabelWidth = (scrolllView.frame.size.width *0.4);
        
    }else  {
        
        yearLabelWidth = (scrolllView.frame.size.width *0.2);
        
    }
    
   // NSLog(@"yearLabelWidth  == %d",yearLabelWidth);
    
    
    // Boottom year label and Bottom Scrollview Property
    
    
    botm = [[UIScrollView alloc]initWithFrame:CGRectMake( scrolllView.frame.
                                                         origin.x, scrolllView.frame.
                                                         origin.y+scrolllView.frame.size.height+3, scrolllView.frame.size.width, 40)];
    
    for (int i =0; yearArray.count>i; i++) {
        
        UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake( ((yearLabelWidth)*i)+self.view.center.x, botm.frame.size.height-40, yearLabelWidth-1, 40)];
        yearLabel.text = [NSString stringWithFormat:@"%d",[[yearArray objectAtIndex:0] intValue]+i];
        yearLabel.backgroundColor = [UIColor yellowColor];
        yearLabel.textAlignment = UITextAlignmentCenter;
        yearLabel.textColor = [UIColor blackColor];
        [botm addSubview:yearLabel];
        botm.delegate=self;
        botm.tag=2;
        [yearLabel release];
        
    }
    
    
    botm.contentSize = CGSizeMake((yearLabelWidth*yearArray.count)+768, 40)  ;
    botm.backgroundColor = [UIColor underPageBackgroundColor];
    [self.view addSubview:botm];
    

    /// Date formattor
    
    
    NSDate *date ;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];

    
    
    // Bottom View Property set and add Month label
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, myView.frame.size.height-40, myView.frame.size.width, 40)];
    bottomView.backgroundColor =[UIColor whiteColor];
    [myView addSubview:bottomView];
    
    int labelWidth  =  (bottomView.frame.size.width/yearArray.count)/[monthArry count] ;
    
    NSMutableArray *monthTemp = [NSMutableArray array];
    
    for (int i =0; yearArray.count >i; i++) {
        
        [monthTemp addObjectsFromArray:monthArry];
        
    }
    

   // NSLog(@"%d",[monthTemp count]);
    
    for (int i =0; [monthTemp count] >i; i++) {
        
        UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake((0+labelWidth)*i, myView.frame.size.height-39, labelWidth-1, 39)];
        monthLabel.text =[NSString stringWithFormat:@"%@ - %d", [monthTemp objectAtIndex:i] , [[yearArray objectAtIndex:0] intValue]+(i/12)];
        monthLabel.backgroundColor = [UIColor blackColor];
        monthLabel.textAlignment = UITextAlignmentCenter;
        monthLabel.textColor = [UIColor whiteColor];
        [myView addSubview:monthLabel];
       // NSLog(@"%f",monthLabel.frame.origin.x);
        
        NSInteger year =   [[yearArray objectAtIndex:0] intValue]+(i/12);
        NSInteger month;// =   [NSString stringWithFormat:@"%d", [[yearArray objectAtIndex:0] intValue]+(i/12)];
       // NSInteger day;// =   [NSString stringWithFormat:@"%d", [[yearArray objectAtIndex:0] intValue]+(i/12)];
         
        
        if ( (i+1)/12 > 0) {
        //    NSLog(@"NSString stringWithFormat    == = == =********==** %d    (i+1)2  == == == = %d",i+1,(i%12)+1 );
            
            month = (i%12)+1;

        }else  {
            
          //  NSLog(@"NSString stringWithFormat    == = == =********==** %d    (i+1)2  == == == = %d",i+1,i+1 );
            
            month =i+1 ;
            
        } 
        
        for (int j=0; dataDic.count>j; j++) {
            
            [dateFormat setDateFormat:@"yyyyMMdd"];    
            date =     [dateFormat dateFromString:[[[dataDic objectAtIndex:j]valueForKey:@"StartDate"]valueForKey:@"text"]];
          //  NSLog(@"%@",date);
           
            
            [dateFormat setDateFormat:@"yyyy"];
            NSString *yearFrmData = [dateFormat stringFromDate:date];
          //  NSLog(@"  *yearFrmData  %@",[dateFormat stringFromDate:date]);
           // NSLog(@"  year  %d",year);
            
            
            [dateFormat setDateFormat:@"MM"];
            NSString *monthFrmData = [dateFormat stringFromDate:date];
         //   NSLog(@"*monthFrmData  %@",[dateFormat stringFromDate:date]);
          //  NSLog(@"  month  %d",month);

            
            [dateFormat setDateFormat:@"dd"];
            NSString *dayFrmData = [dateFormat stringFromDate:date];
          //  NSLog(@"*dayFrmData %@",[dateFormat stringFromDate:date]);
            
            
            
            if (year == [yearFrmData intValue]) {
                
              //  NSLog(@"[dateFormat stringFromDate:date]  %@",yearFrmData);
                
                
                if (month ==[monthFrmData intValue]) {
                 
                   // NSLog(@"monthAcailable  %d",month);

                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [btn setBackgroundImage:[UIImage imageNamed:@"bar.png"] forState:UIControlStateNormal];
                    [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal] ;
                    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = j;
                    
                    btn.frame =  CGRectMake((0+labelWidth)*i, myView.frame.size.height-400-39, 30, 420);
                    float cen = [self findButtonCenterlabelWidth:labelWidth currentMonthX:monthLabel.frame.origin.x daysNo:[dayFrmData intValue]];
                    btn.center = CGPointMake(cen, 300)  ;
                    [myView addSubview:btn];
 
                    
                    
                }

                
                
            }
            
            
        }        
        

        
        
        [monthLabel release];

        
    }
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shadow.png"]];
    img.frame = CGRectMake(0, 0, 200, 50);
    img.center=CGPointMake(self.view.center.x, self.view.center.y+330);
    [self.view addSubview:img];
    [img release];

    
    
    
    
    [indicator stopAnimating];

    [dateFormat release];
 

}






#pragma mark -
#pragma mark Functions


-(float)findButtonCenterlabelWidth:(NSInteger)labelWidth  currentMonthX:(float)frameX  daysNo:(NSInteger)day
{

  float  oneDay =   labelWidth/30;
    return frameX+ (day*oneDay);;
}

-(NSDictionary*)findMaximumMinimun :(NSArray*)arrry
{

    NSInteger minimumYear=0 ;
    NSInteger maximumYear =0;
    

    
    NSDate *date ;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];    
    
    for (int i=0;[ arrry count]>i; i++) {
        date = [dateFormat dateFromString:[[[arrry objectAtIndex:i]valueForKey:@"StartDate"]valueForKey:@"text"]]; 
        [[dataDic objectAtIndex:i]setObject:date forKey:@"StartDate"];
    }
   // NSLog(@"%@",[dataDic  valueForKey:@"StartDate"]);
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"StartDate"  ascending:YES];
    [dataDic sortUsingDescriptors:[NSArray arrayWithObject:nameSort]];
    nameSort=nil;

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:(NSDate*)[[dataDic lastObject]  valueForKey:@"StartDate"]];
    maximumYear = [dateComponents year];
    dateComponents =nil;
  
    NSDateComponents *dateComponents1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:(NSDate*)[[dataDic objectAtIndex:0]  valueForKey:@"StartDate"]];
    minimumYear = [dateComponents1 year];
    dateComponents1=nil;
    
//    NSLog(@"%@",[[dataDic objectAtIndex:0]  valueForKey:@"StartDate"]);
//    NSLog(@"%@",[[dataDic lastObject]  valueForKey:@"StartDate"]);
    
    for (int i=0;[ dataDic count]>i; i++){
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[dateFormat stringFromDate:[[dataDic objectAtIndex:i]valueForKey:@"StartDate"]] forKey:@"text"];
         [[dataDic objectAtIndex:i]setObject:dic forKey:@"StartDate"];
    }
    NSLog(@"%@",dataDic );  
    [dateFormat release];
    
    NSString *max = [NSString stringWithFormat:@"%d",maximumYear];
    NSString *min = [NSString stringWithFormat:@"%d",minimumYear];
    
    NSDictionary *dicc = [NSDictionary dictionaryWithObjectsAndKeys:max,@"maximumYear",min,@"minimumYear", nil];
    
    return dicc;
}



#pragma mark -
#pragma mark TableView management 
// customize the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	    return dataDic.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	static NSString *CellIdentifier = @"LazyTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    NSDate *date ;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];    
    date = [dateFormat dateFromString:[[[dataDic objectAtIndex:indexPath.row]valueForKey:@"StartDate"]valueForKey:@"text"]]; 

    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Diseases  Name ==  %@ ",[[[dataDic objectAtIndex:indexPath.row]valueForKey:@"Name"]valueForKey:@"text"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Starting Date ==  %@",[dateFormat stringFromDate:date]];
    [dateFormat release];
    
    return cell;
}



#pragma mark -
#pragma mark IBAction Division 


- (IBAction)sucking:(id)sender {

//    CATransition *animation = [CATransition animation];
//    animation.type = @"suckEffect";
//    animation.duration = 2.0f;
//   // [UIView  setAnimationTransition:103  forView:myView  cache:NO];
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    myView.opacity = 1.0f;
//    [myView.layer addAnimation:animation forKey:@"transitionViewAnimation"];
    
//    
//    [UIView beginAnimations:@"genieEffect" context:NULL];
//    [UIView setAnimationTransition:108 forView:scrolllView cache:YES];
//    [UIView setAnimationDuration:1.0];
//   // [UIView setAnimationPosition:suckBtn.center];
//    [UIView commitAnimations];
    //[myImg removeFromSuperview];
    

}


-(void)buttonPressed:(UIButton*)sender
{
    NSLog(@"%d",sender.tag);
    
    NSString *str = [NSString stringWithFormat:@"I pressed Button %d == & ==",sender.tag+1];
    
    textView.text= [textView.text stringByAppendingString:str];
    
    NSString *messae = [NSString stringWithFormat:@"Patient diseases  =%@\nStarting Date =%@\nType =%@\nPriority =%@\nEnd Date =%@\nDetail =%@",[[[dataDic objectAtIndex:sender.tag]valueForKey:@"Name"]valueForKey:@"text"],[[[dataDic objectAtIndex:sender.tag]valueForKey:@"StartDate"]valueForKey:@"text"],[[[dataDic objectAtIndex:sender.tag]valueForKey:@"Type"]valueForKey:@"text"],[[[dataDic objectAtIndex:sender.tag]valueForKey:@"Priority"]valueForKey:@"text"],[[[dataDic objectAtIndex:sender.tag]valueForKey:@"EndDate"]valueForKey:@"text"],[[[dataDic objectAtIndex:sender.tag]valueForKey:@"Detail"]valueForKey:@"text"]];
    
   [ customealert  showAlert:@"Patient Detail" message:messae delegate:self];

    
  //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Patient Detail" message:messae delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  
    //[alert show];
   // [alert release];
    
}


#pragma mark -
#pragma mark Memory management 

- (void)viewDidUnload
{
    [self setScrolllView:nil];
    [myView release];
    myView = nil;
    [textView release];
    textView = nil;
    [myTable release];
    myTable = nil;
    [indicator release];
    indicator = nil;
    [suckBtn release];
    suckBtn = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)dealloc {
    [scrolllView release];
    [yearArray release];
    [dataDic release];
    [myView release];
    [textView release];
    [myTable release];
    [indicator release];
    [suckBtn release];
    [super dealloc];
}
@end
