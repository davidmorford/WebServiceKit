
#import <WebServiceKit/WSKWebServiceOperation.h>
#import <WebServiceKit/WSKWebServiceContext.h>

#ifdef __WSK_HTTPS_TEST__
@interface NSURLRequest (WSKPrivate)
	+(void) setAllowsAnyHTTPSCertificate:(BOOL)flag forHost:(NSString *)aHostName;
@end
#endif

#pragma mark -

@interface WSKWebServiceOperation ()
	-(void) finish;
@end

#pragma mark -

@implementation WSKWebServiceOperation

	@synthesize delegate;
	@synthesize context;
	@synthesize connection;
	@synthesize requestTimeout;

	#pragma mark KVO

	+(BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
		if ([key isEqualToString:@"isExecuting"] || [key isEqualToString:@"isFinished"]) {
			return YES;
		}
		return [super automaticallyNotifiesObserversForKey:key];
	}


	#pragma mark Initializer
	
	-(id) initWithWebServiceContext:(WSKWebServiceContext *)serviceContext {
		self = [super init];
		if (self != nil) {
			self.context			= serviceContext;
			self.delegate			= serviceContext;
			executing				= FALSE;
			finished				= FALSE;
			self.requestTimeout		= [serviceContext.request timeoutInterval];
		}
		return self;
	}
	

	#pragma mark -

	-(void) start {
		if ([self.delegate respondsToSelector:@selector(webServiceRequestOperation:willStartConnection:)]) {
			#ifdef __WSK_HTTPS_TEST__
			[NSURLRequest setAllowsAnyHTTPSCertificate:TRUE forHost:[[self.context.request URL] host]];
			#endif
			self.connection = [[NSURLConnection alloc] initWithRequest:self.context.request delegate:self startImmediately:TRUE];
			[self.delegate webServiceRequestOperation:self willStartConnection:self.connection];
		}
		[self willChangeValueForKey:@"isExecuting"];
		executing = TRUE;
		[self didChangeValueForKey:@"isExecuting"];
		if (!self.connection) {
			[self finish];
		}
	}

	-(void) finish {
		[connection release]; connection = nil;
				
		[self willChangeValueForKey:@"isExecuting"];
		[self willChangeValueForKey:@"isFinished"];
		
		executing	= NO;
		finished	= YES;
		
		[self didChangeValueForKey:@"isExecuting"];
		[self didChangeValueForKey:@"isFinished"];
	}


	#pragma mark -

	-(BOOL) isConcurrent {
		return TRUE;
	}

	-(BOOL) isExecuting {
		return executing;
	}

	-(BOOL) isFinished {
		return finished;
	}


	#pragma mark <NSURLConnectionDelegate>
	
	
	-(void) connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse {
		#ifdef DEBUG
		NSLog(@"%@", aResponse);
		#endif
		if ([self.delegate respondsToSelector:@selector(webServiceRequestOperation:didReceiveResponse:)]) {
			[self.delegate webServiceRequestOperation:self didReceiveResponse:aResponse];
		}
	}

	-(void) connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
		if ([self.delegate respondsToSelector:@selector(webServiceRequestOperation:didReceiveData:)]) {
			[self.delegate webServiceRequestOperation:self didReceiveData:data];
		}
	}

	-(void) connectionDidFinishLoading:(NSURLConnection *)aConnection {
		#ifdef DEBUG
		NSLog(@"%@", aConnection);
		#endif
		if ([self.delegate respondsToSelector:@selector(webServiceRequestOperationDidFinishLoading:)]) {
			[self.delegate webServiceRequestOperationDidFinishLoading:self];
		}
		[self finish];
	}

	-(void) connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
		if ([self.delegate respondsToSelector:@selector(webServiceRequestOperation:didFailWithError:)]) {
			[self.delegate webServiceRequestOperation:self didFailWithError:error];
		}
		[self finish];
	}


	#pragma mark Destructor

	-(void) dealloc {
		[context release]; context = nil;
		[connection release]; connection = nil;
		delegate = nil;
		[super dealloc];
	}

@end
