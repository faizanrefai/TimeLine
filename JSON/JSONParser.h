//
//  JSONParser.h
//  TestWebService
//
//  Created by apple on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"


@interface JSONParser : NSObject {

	NSURLConnection *con;
	NSMutableData *myWebData;
	NSObject *MainHandler;
	SEL targetSelector;
	NSMutableURLRequest *rq;
    }
@property (nonatomic,retain)NSObject *MainHandler;
@property (nonatomic)SEL targetSelector;
@property (nonatomic,retain) NSMutableURLRequest *rq;
-(id)initWithRequestForThread:(NSMutableURLRequest*)url sel:(SEL)seletor andHandler:(NSObject*)handler;

@end
