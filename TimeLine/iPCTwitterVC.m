//
//  iPCTwitterVC.m
//  TimeLine
//
//  Created by Udayan Mandavia on 9/7/12.
//  Copyright (c) 2012 iPatientCare, Inc. All rights reserved.
//

#import "iPCTwitterVC.h"
#import "JSONParser.h"

@interface iPCTwitterVC ()
{
    NSInteger twitCount ;
    NSInteger priviousTwittCount ;
    BOOL dontReload;
}

@end

@implementation iPCTwitterVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    twitCount=20;
    dontReload=YES;
    tweetArry = [[NSMutableArray alloc]initWithObjects:@"Loading...",@"Loading...",@"Loading...",@"Loading...", nil] ;
    imageArray = [[NSMutableArray alloc]initWithObjects:@"Loading...",@"Loading...",@"Loading...",@"Loading...", nil] ;

    [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
    
    [self performSelectorInBackground:@selector(getTwit) withObject:nil];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)getTwit {
    
	NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=iPatientCareEHR&count=%d",twitCount]];
	//NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"https://api.twitter.com/1/statuses/user_timeline.json?screen_name=djanthonyrey&count=%d",twitCount]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    JSONParser *parsor = [[JSONParser alloc]initWithRequestForThread:request sel:@selector(gott:) andHandler:self];
    
    // NSLog(@"%@",parsor.rq );

    
    [url release];
    [request release];
    [parsor release];
    
    twitCount += 5;
   // NSLog(@"%d",twitCount);

}

-(void)gott:(NSDictionary*)dic

{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=false;
    if(priviousTwittCount== [[dic valueForKey:@"text"] count])
    {
        dontReload=NO;
        return;
    }
    
    // Get all data using this dic :) ;) text content twits.
    
    //	NSLog(@"Response Data : %@", dic);
    //NSLog(@"Response Dictionary ::: %@",[dic valueForKey:@"text"]);
    
    [tweetArry removeAllObjects];
    [tweetArry addObjectsFromArray: [dic valueForKey:@"text"]];
    
   // NSLog(@"%@",tweetArry);
    
    [imageArray  removeAllObjects];
	
    NSString *strID = [[[dic valueForKey:@"user"] valueForKey:@"id_str"]objectAtIndex:0];
	[imageArray addObject:[NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@?size=original",strID]];
  
   
    priviousTwittCount= [[dic valueForKey:@"text"] count];
        [myTable reloadData];

}

- (void)viewDidUnload
{
    [myTable release];
    myTable = nil;
    [cellCustm release];
    cellCustm = nil;
    [label release];
    label = nil;
    [imagViw release];
    imagViw = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark -
#pragma mark TableView management 
// customize the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetArry.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
	static NSString *CellIdentifier = @"LazyTableCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell=cellCustm;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    label.text = [tweetArry objectAtIndex:indexPath.row];
    imagViw.imageURL = [NSURL URLWithString:[imageArray objectAtIndex:0]];
        
    if (indexPath.row==(tweetArry.count-5) && dontReload) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=TRUE;
        [self performSelectorInBackground:@selector(getTwit) withObject:nil];

    }
    return cell;
}






- (void)dealloc {
    [myTable release];
    [cellCustm release];
    [label release];
    [imagViw release];
    [super dealloc];
}
@end
