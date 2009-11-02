
/*!
@project    WebServiceKit
@header     WSKWebServiceContextDelegate.h
@copyright  (c) 2009 - Semantap
*/

#import <Foundation/Foundation.h>

@class WSKWebServiceContext;

/*!
@protocol WSKWebServiceContextDelegate <NSObject>
@abstract
*/
@protocol WSKWebServiceContextDelegate <NSObject>
	
@optional
	-(void) webServiceContext:(WSKWebServiceContext *)context didFinishWebServiceAPI:(NSString *)apiName;
	-(void) webServiceContext:(WSKWebServiceContext *)context didFinishWebServiceAPI:(NSString *)apiName withResult:(NSDictionary *)result;
	
@end
