
/*!
@project	WebServiceKit
@header     WSKWebServiceContext.h
@copyright  (c) 2009, Semantap
*/

#import <Foundation/Foundation.h>
#import <WebServiceKit/WSKWebServiceContextDelegate.h>
#import <WebServiceKit/WSKWebServiceOperationDelegate.h>

@class FKPointerArray;
@class WSKWebService;
@class WSKWebServiceContext;

/*!
@class WSKWebServiceContext
@superclass NSObject <WSKWebServiceOperationDelegate>
@abstract
@discussion
*/
@interface WSKWebServiceContext : NSObject <WSKWebServiceOperationDelegate> {
	NSString *identifier;
	FKPointerArray *delegatePointers;
	WSKWebService *webService;
	NSString *webServiceAPIName;
	NSString *webServiceRequestMethod;
	NSString *webServiceResponseMethod;
	NSMutableURLRequest *request;
	NSString *HTTPMethod;
	NSDictionary *requestHeaders;
	NSData *requestData;
	NSString *responseType;
	NSHTTPURLResponse *response;
	NSMutableData *responseData;
	id requestElement;
	id responseElement;
}

	@property (nonatomic, retain, readonly) NSString *identifier;
	@property (nonatomic, retain, readonly) NSArray *delegates;
	@property (nonatomic, retain) WSKWebService *webService;
	
	@property (nonatomic, retain) NSString *webServiceAPIName;
	@property (nonatomic, retain) NSString *webServiceRequestMethod;
	@property (nonatomic, retain) NSString *webServiceResponseMethod;

	@property (nonatomic, retain) NSMutableURLRequest *request;
	@property (nonatomic, retain) NSString *HTTPMethod;
	@property (nonatomic, retain) NSDictionary *requestHeaders;
	@property (nonatomic, retain) NSData *requestData;
	@property (nonatomic, retain) id requestElement;
	
	@property (nonatomic, retain) NSString *responseType;
	@property (nonatomic, retain) NSHTTPURLResponse *response;
	@property (nonatomic, retain) NSMutableData *responseData;
	@property (nonatomic, retain) id responseElement;

	
	#pragma mark Initializer

	-(id) initWithIdentifier:(NSString *)anIdentifier delegates:(NSArray *)delegateList;
	
	-(void) addDelegate:(id <WSKWebServiceContextDelegate>)aDelegate;

@end
