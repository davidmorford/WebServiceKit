
/*!
@project    FoundationKit
@header     FKNSObject.h
@copyright  (c) 2009 - Semantap
*/

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

/*!
@class NSObject (FKClassName)
@abstract NSObject does not provide the className method on iPhone OS.
@discussion ￼className belongs to the NSScripting categories on Mac OS X.
*/
@interface NSObject (FKClassName)

	@property (readonly) NSString * className;
	+(NSString *) className;

@end
