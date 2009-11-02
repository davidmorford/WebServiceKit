
/*!
@header FKPointerArray
@abstract
@discussion
@origin		Jonathan Wight, 9/10/08, TouchCode
@copyright	2008 toxicsoftware.com. All rights reserved.
@changes	2009, Semantap. All rights reserved.
*/

#import <Foundation/Foundation.h>

/*!
@class FKPointerArray
@superclass NSObject <NSFastEnumeration>
@abstract
@discussion
*/
@interface FKPointerArray : NSObject <NSFastEnumeration> {
	NSUInteger count;
	void **buffer;
}

	@property (readwrite, nonatomic, assign) NSUInteger count;

	-(void *) pointerAtIndex:(NSUInteger)anIndex;

	-(void) addPointer:(void *)aPointer;

@end
