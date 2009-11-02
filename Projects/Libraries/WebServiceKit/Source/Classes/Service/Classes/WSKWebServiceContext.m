
#import <WebServiceKit/WSKWebServiceContext.h>
#import <WebServiceKit/WSKWebService.h>
#import <WebServiceKit/WSKWebServiceOperation.h>
#import <FoundationKit/FKPointerArray.h>

@interface WSKWebServiceContext ()
	@property (readwrite, nonatomic, retain) NSString *identifier;
	@property (readwrite, nonatomic, retain) FKPointerArray *delegatePointers;
@end

#pragma mark -

@implementation WSKWebServiceContext
	
	@synthesize identifier;
	@synthesize delegatePointers;
	@synthesize	webService;
	@synthesize	webServiceAPIName;
	@synthesize	webServiceRequestMethod;
	@synthesize	webServiceResponseMethod;
	@synthesize	request;
	@synthesize	HTTPMethod;
	@synthesize	requestHeaders;
	@synthesize	requestData;
	@synthesize	requestElement;
	@synthesize	responseType;
	@synthesize	response;
	@synthesize	responseData;
	@synthesize	responseElement;


	#pragma mark Initializer

	-(id) init {
		self = [super init];
		if (self != nil) {
			self.delegatePointers	= [[FKPointerArray alloc] init];
			self.HTTPMethod			= WSKWebServiceHTTPMethodPOST;
			self.responseType		= @"public.data";
			self.responseData		= [[NSMutableData alloc] init];
		}
		return self;
	}


	-(id) initWithIdentifier:(NSString *)anIdentifier delegates:(NSArray *)delegateList {
		self = [self init];
		if (self) {
			self.identifier = anIdentifier;
			for (id contextDelegate in delegateList) {
				NSAssert([contextDelegate conformsToProtocol:@protocol(WSKWebServiceContextDelegate)], @"Delegate does not conform to <WSKWebServiceContextDelegate>");
				[self.delegatePointers addPointer:contextDelegate];
			}
		}
		return self;
	}


	#pragma mark Delegation

	-(NSArray *) delegates {
		NSMutableArray *delegateList = [NSMutableArray arrayWithCapacity:self.delegatePointers.count];
		for (id <WSKWebServiceContextDelegate> aDelegate in self.delegatePointers) {
			[delegateList addObject:aDelegate];
		}
		return (delegateList);
	}

	-(void) addDelegate:(id <WSKWebServiceContextDelegate>)aDelegate {
		[self.delegatePointers addPointer:aDelegate];
	}

	-(void) invalidate {
		self.delegatePointers = nil;
	}


	#pragma mark <WSKWebServiceOperation>

	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation willStartConnection:(NSURLConnection *)connection {
		//WSKLOG(operation);
	}

	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didReceiveResponse:(NSURLResponse *)aResponse {
		[self.responseData setLength:0];
		self.response = (NSHTTPURLResponse *)aResponse;
	}

	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didReceiveData:(NSData *)data {
		[self.responseData appendData:data];
	}

	-(void) webServiceRequestOperationDidFinishLoading:(WSKWebServiceOperation *)operation {
		//self.responseElement = [[XUDocument alloc] initWithData:self.responseData options:0 error:nil];

		for (id <WSKWebServiceContextDelegate> aDelegate in self.delegatePointers) {
			if ([aDelegate respondsToSelector:@selector(webServiceContext:didFinishWebServiceAPI:withResult:)]) {
				[aDelegate webServiceContext:self 
					  didFinishWebServiceAPI:self.webServiceAPIName 
								  withResult:nil];
			}
		}
	}

	-(void) webServiceRequestOperation:(WSKWebServiceOperation *)operation didFailWithError:(NSError *)error {
		//WSKLOG(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	}

	-(NSString *) description {
		return ([NSString stringWithFormat:@"WebService Method = %@\n, HTTP Method = %@\n, Request Data = %@\n, Request Element = %@\n, URL Response = %@\n, Response Data = %@\n, Response Element = %@\n", 
												self.webServiceAPIName, 
												self.HTTPMethod, 
												self.requestData, 
												self.requestElement, 
												self.responseType, 
												self.response, 
												self.responseData, 
												self.responseElement]);
	}

	#pragma mark Destructor

	-(void) dealloc {
		[webServiceResponseMethod release]; webServiceResponseMethod = nil;
		[webServiceRequestMethod release]; webServiceRequestMethod = nil;
		[webServiceAPIName release]; webServiceAPIName = nil;
		[request release]; request = nil;
		[HTTPMethod release]; HTTPMethod = nil;
		[requestHeaders release]; requestHeaders = nil;
		[requestData release]; requestData = nil;
		[requestElement release]; requestElement = nil;
		[responseType release]; responseType = nil;
		[response release]; response = nil;
		[responseData release]; responseData = nil;
		[responseElement release]; responseElement = nil;
		[webService release]; webService = nil;
		[identifier release]; identifier = nil;
		[delegatePointers release]; self.delegatePointers = nil;
		[super dealloc];
	}

@end
