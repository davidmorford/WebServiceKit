
#import <FoundationKit/FKNSObject.h>

@implementation NSObject (FKClassName)
	
	-(NSString *) className {
		return NSStringFromClass([self class]);
	}
	
	+(NSString *) className {
		return [NSString stringWithUTF8String:class_getName(self)];
	}

@end
