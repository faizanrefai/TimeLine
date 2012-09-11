/*
	SDZServices.m
	Creates a list of the services available with the SDZ prefix.
	Generated by SudzC.com
*/
#import "SDZServices.h"

@implementation SDZServices

@synthesize logging, server, defaultServer;

@synthesize timeline;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
		self.server = serverName;
	}
	return self;
}

+(SDZServices*)service{
	return (SDZServices*)[[[SDZServices alloc] init] autorelease];
}

+(SDZServices*)serviceWithServer:(NSString*)serverName{
	return (SDZServices*)[[[SDZServices alloc] initWithServer:serverName] autorelease];
}

#pragma mark Methods

-(void)setLogging:(BOOL)value{
	logging = value;
	[self updateServices];
}

-(void)setServer:(NSString*)value{
	[server release];
	server = [value retain];
	[self updateServices];
}

-(void)updateServices{

	[self updateService: self.timeline];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(SDZTimeline*)timeline{
	if(timeline == nil) {
		timeline = [[SDZTimeline alloc] init];
	}
	return timeline;
}


@end
			