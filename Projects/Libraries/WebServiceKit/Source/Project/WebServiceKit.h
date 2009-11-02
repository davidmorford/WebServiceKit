
/*!
@project	WebServiceKit
@header		WebServiceKit.h
@copyright	(c) 2009 = Semantap
*/

#import <WebServiceKit/WSKWebService.h>
#import <WebServiceKit/WSKWebServiceContext.h>
#import <WebServiceKit/WSKWebServiceOperation.h>

#import <WebServiceKit/WSKWebServiceContextDelegate.h>
#import <WebServiceKit/WSKWebServiceOperationDelegate.h>

#ifdef DEBUG
	#define		__WSK_HTTPS_TEST__
	#define		WSKLOG(object)			NSLog(@"%@", object)
	#define		WSKLOGMETHOD(object)	NSLog(@"%s called: -[%@ %s] (line %d in %s) -- %@", _cmd, self, _cmd, __LINE__, __FILE__, object)
#else
	#define		WSKLOG(object
	#define		WSKLOGMETHOD(object)
#endif
