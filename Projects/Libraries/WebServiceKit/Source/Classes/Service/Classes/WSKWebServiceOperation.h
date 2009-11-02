
/*!
@project	WebServiceKit
@header     WSKWebServiceOperation.h
@copyright  (c) 2009 - Semantap
@created    09/09/09 - david [at] semantap.com
*/

#import <Foundation/Foundation.h>
#import <WebServiceKit/WSKWebServiceContextDelegate.h>
#import <WebServiceKit/WSKWebServiceOperationDelegate.h>

@class WSKWebService, WSKWebServiceContext;

/*!
@class WSKWebServiceOperation
@superclass NSOperation
@abstract
@discussion
*/
@interface WSKWebServiceOperation : NSOperation {
	id <WSKWebServiceOperationDelegate> delegate;
	WSKWebServiceContext *context;
	NSURLConnection *connection;
	NSTimeInterval requestTimeout;
	BOOL finished;
	BOOL executing;
}



	@property (nonatomic, assign) id <WSKWebServiceOperationDelegate> delegate;
	@property (nonatomic, retain) WSKWebServiceContext *context;
	@property (nonatomic, retain) NSURLConnection *connection;
	@property (nonatomic, assign) NSTimeInterval requestTimeout;
	

	#pragma mark Initializer

	-(id) initWithWebServiceContext:(WSKWebServiceContext *)serviceContext;


	#pragma mark Operation State
	
	-(BOOL) isConcurrent;
	-(BOOL) isExecuting;
	-(BOOL) isFinished;

@end

