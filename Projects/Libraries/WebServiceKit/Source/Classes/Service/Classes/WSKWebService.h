
/*!
@project    WebServiceKit
@header     WSKWebService.h
@copyright  (c) 2009 Semantap
*/

#import <Foundation/Foundation.h>
#import <WebServiceKit/WSKWebServiceOperation.h>
#import <WebServiceKit/WSKWebServiceContext.h>
//#import <XMLKit/XMLKit.h>
//#import <JSONKit/JSONKit.h>

extern NSString* const WSKWebServiceHTTPMethodDELETE;
extern NSString* const WSKWebServiceHTTPMethodGET;
extern NSString* const WSKWebServiceHTTPMethodHEAD;
extern NSString* const WSKWebServiceHTTPMethodPOST;
extern NSString* const WSKWebServiceHTTPMethodPUT;

@class WSKWebServiceContext, WSKWebServiceOperation;
@protocol WSKWebServiceDelegate;

/*!
@class WSKWebService
@superclass NSObject <WSKWebServiceOperationDelegate>
@abstract
@discussion
*/
@interface WSKWebService : NSObject <WSKWebServiceContextDelegate> {
	NSOperationQueue *operationQueue;
	WSKWebServiceContext *currentContext;
	NSURL *webServiceURL;
	NSString *userAgent;
	NSTimeInterval requestTimeout;
	BOOL requireValidSSL;
}

	@property (nonatomic, retain) NSURL *webServiceURL;
	@property (nonatomic, retain) WSKWebServiceContext *currentContext;

	@property (nonatomic, retain, readonly) NSOperationQueue *operationQueue;
	@property (nonatomic, assign) NSUInteger maxOperationCount;
	@property (nonatomic, retain, readonly) NSArray *operations;

	@property (nonatomic, retain) NSString *userAgent;
	@property (nonatomic, assign) NSTimeInterval requestTimeout;
	@property (nonatomic, assign) BOOL requireValidSSL;

	#pragma mark Initializers

	-(id) init;
	
	/*!
	@method initWithWebServiceURL:
	@abstract
	@param aURL 
	@result 
	*/
	-(id) initWithWebServiceURL:(NSURL *)aURL;


	#pragma mark Operations

	/*!
	@method addOperation:
	@abstract 
	@param operation 
	*/
	-(void) addOperation:(WSKWebServiceOperation *)operation;
	
	/*!
	@method addOperation:priority:
	@abstract 
	@param operation 
	@param priority 
	*/
	-(void) addOperation:(WSKWebServiceOperation *)operation priority:(NSOperationQueuePriority)priority;
	
	/*!
	@method  cancelOperations
	@abstract 
	*/
	-(void) cancelOperations;


	#pragma mark Perform

	/*!
	@method performWebServiceMethod:withArguments:context:
	@abstract
	@param methodName
	@param argumentMap
	@param context
	*/
	-(void) performWebServiceMethod:(NSString *)methodName withArguments:(NSDictionary *)argumentMap context:(WSKWebServiceContext *)context;

	/*!
	@method performWebServiceContext:
	@abstract
	@param context
	*/
	-(void) performWebServiceContext:(WSKWebServiceContext *)context;

@end
