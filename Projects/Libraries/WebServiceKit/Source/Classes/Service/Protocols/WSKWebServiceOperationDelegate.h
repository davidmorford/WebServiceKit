
/*!
@project    WebServiceKit
@header     WSKWebServiceOperationDelegate.h
@copyright  (c) 2009, Semantap
@created    09/09/09 - david [at] semantap.com
*/

#import <Foundation/Foundation.h>

@class WSKWebServiceOperation;

/*!
@protocol WSKWebServiceOperationDelegate <NSObject>
@abstract
*/
@protocol WSKWebServiceOperationDelegate <NSObject>

@optional
	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation willStartConnection:(NSURLConnection *)connection;
	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didReceiveResponse:(NSURLResponse *)response;
	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didReceiveData:(NSData *)data;
	-(void) webServiceRequestOperationDidFinishLoading:(WSKWebServiceOperation *)operation;
	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didFailWithError:(NSError *)error;
	-(NSURLRequest *) webServiceRequestOperation:(WSKWebServiceOperation *)operation willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;

@end