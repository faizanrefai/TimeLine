/*
	SDZTimeline.h
	The interface definition of classes and methods for the Timeline web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				

/* Interface for the service */
				
@interface SDZTimeline : SoapService
		
	/* Returns CXMLNode*.  */
	- (SoapRequest*) GetTimeLineData: (id <SoapDelegate>) handler;
	- (SoapRequest*) GetTimeLineData: (id) target action: (SEL) action;

	/* Returns CXMLNode*.  */
	- (SoapRequest*) GetTimeLineDataWithRequest: (id <SoapDelegate>) handler PatientID: (NSString*) PatientID;
	- (SoapRequest*) GetTimeLineDataWithRequest: (id) target action: (SEL) action PatientID: (NSString*) PatientID;

		
	+ (SDZTimeline*) service;
	+ (SDZTimeline*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	