
#import <WebServiceKit/WSKWebService.h>
//#import <FoundationKit/FKNSData.h>

NSString* const WSKWebServiceHTTPMethodDELETE	= @"DELETE";
NSString* const WSKWebServiceHTTPMethodGET		= @"GET";
NSString* const WSKWebServiceHTTPMethodHEAD		= @"HEAD";
NSString* const WSKWebServiceHTTPMethodPOST		= @"POST";
NSString* const WSKWebServiceHTTPMethodPUT		= @"PUT";

#pragma mark -

@interface WSKWebService ()
	@property (nonatomic, retain, readwrite) NSOperationQueue *operationQueue;
@end

#pragma mark -

@implementation WSKWebService

	@synthesize operationQueue;
	@synthesize webServiceURL;
	@synthesize currentContext;
	@synthesize requestTimeout;
	@synthesize requireValidSSL;
	@synthesize userAgent;

	#pragma mark Initializer

	-(id) init {
		self = [super init];
		if (self != nil) {
			self.operationQueue			= [[NSOperationQueue alloc] init];
			self.operationQueue.maxConcurrentOperationCount = 1;
			self.requestTimeout			= 30.0;
			self.requireValidSSL		= TRUE;
			self.userAgent				= @"WSKWebService (1.0) / iPhone OS 3.1.2";
		}
		return self;
	}

	-(id) initWithWebServiceURL:(NSURL *)aURL {
		self = [self init];
		if (self != nil) {
			self.webServiceURL			= aURL;
		}
		return self;
	}


	#pragma mark Properties

	-(NSArray *) operations {
		return [self.operationQueue operations];
	}
	
	-(NSUInteger) maxOperationCount {
		return [self.operationQueue maxConcurrentOperationCount];
	}

	-(void) setMaxOperationCount:(NSUInteger)count {
		return [self.operationQueue setMaxConcurrentOperationCount:count];
	}


	#pragma mark -

	-(void) cancelOperations {
		[self.operationQueue cancelAllOperations];
	}


	#pragma mark Internal
	
	-(void) addOperation:(WSKWebServiceOperation *)operation {
		self.currentContext = operation.context;
		[self.operationQueue addOperation:operation];
	}

	-(void) addOperation:(WSKWebServiceOperation *)operation priority:(NSOperationQueuePriority)priority {
		self.currentContext = operation.context;
		[operation setQueuePriority:priority];
		[self.operationQueue addOperation:operation];
	}


	#pragma mark Web Service Perform

	-(void) performWebServiceMethod:(NSString *)methodName withArguments:(NSDictionary *)argumentMap context:(WSKWebServiceContext *)context {
		context.webServiceAPIName			= methodName;
		context.webServiceRequestMethod		= @"";
		context.webServiceResponseMethod	= @"";
		
		/*
		XKElement *requestRootElement;
		requestRootElement = [[[XKElement alloc] initWithName:context.webServiceRequestMethod] autorelease];
		
		for (NSString *argumentName in argumentMap) {
			NSString *argumentValue = [argumentMap valueForKey:argumentName]);
			XKElement *element = [[XKElement alloc] initWithName:argumentName stringValue:argumentValue];
			[requestRootElement addChild:element];
			[element release];
		}
		*/

		//context.requestElement = requestRootElement;
		[self performWebServiceContext:context];
	}

	-(void) performWebServiceContext:(WSKWebServiceContext *)context {
		context.request			= [[NSMutableURLRequest alloc] initWithURL:self.webServiceURL 
															   cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData  
														   timeoutInterval:self.requestTimeout];
		[context.request addValue:self.userAgent forHTTPHeaderField:@"User-Agent"];
		[context.request setHTTPMethod:context.HTTPMethod];
		[context.request setHTTPBody:context.requestData];
		
		[context addDelegate:self];
		WSKWebServiceOperation *webServiceRequestionOperation = [[WSKWebServiceOperation alloc] initWithWebServiceContext:context];
		[self addOperation:webServiceRequestionOperation];
		[webServiceRequestionOperation release];
	}


	#pragma mark <WSKWebServiceContextDelegate>
	
	-(void) webServiceContext:(WSKWebServiceContext *)context didFinishWebServiceAPI:(NSString *)apiName withResult:(NSDictionary *)result {
		#ifdef __DEBUG__
		NSLog(@"API      = %@", apiName);
		NSLog(@"RESULT   = %@", result);
		#endif
		[currentContext release]; currentContext = nil;
	}
	

	#pragma mark Destructor

	-(void) dealloc {
		[currentContext release];
		[self cancelOperations];
		[operationQueue release], operationQueue = nil;
		[userAgent release], userAgent = nil;
		[webServiceURL release]; webServiceURL = nil;
		[super dealloc];
	}

@end
