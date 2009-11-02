
#import <FoundationKit/FKPointerArray.h>

@interface FKPointerArray ()
	@property (readwrite, nonatomic, assign) void **buffer;
@end

#pragma mark -

@implementation FKPointerArray

	@synthesize count;
	@synthesize buffer;


	#pragma mark -

	-(id) init {
		if ((self = [super init]) != nil) {
			count	= 0;
			buffer	= nil;
		}
		return (self);
	}

	-(void) dealloc {
		self.buffer = nil;
		[super dealloc];
	}


	#pragma mark -

	-(NSUInteger) count {
		return (count);
	}

	-(void) setCount:(NSUInteger)aCount {
		if (count != aCount) {
			const NSUInteger oldCount	= count;
			const size_t oldSize		= sizeof(void *) * oldCount;
			const size_t newSize		= sizeof(void *) * aCount;
			
			void **newBuffer			= nil;
			
			if (oldSize == 0) {
				newBuffer = malloc(newSize);
			}
			else{
				newBuffer = realloc(self.buffer, newSize);
			}
			
			if (newBuffer == nil) {
				[NSException raise:NSMallocException format:@"realloc failed trying to allocate %d bytes, (errno: %d)", newSize, errno];
			}
			
			if (newSize > oldSize) {
				memset(newBuffer + oldCount, 0, newSize - oldSize);
			}
			
			buffer	= newBuffer;
			count	= aCount;
		}
	}

	-(void **) buffer {
		if ((buffer == nil) && (self.count > 0) ) {
			const size_t theSize	= sizeof(void *) * self.count;
			void **newBuffer		= malloc(theSize);
			memset(newBuffer, 0, theSize);
			if (newBuffer == nil) {
				[NSException raise:NSMallocException format:@"-[CPointerArray buffer] malloc failed trying to allocate %d bytes, (errno: %d)", theSize, errno];
			}
			buffer = newBuffer;
		}
		return (buffer);
	}

	-(void) setBuffer:(void **)aBuffer {
		if (buffer != aBuffer) {
			buffer = aBuffer;
			if (buffer == NULL) {
				self.count = 0;
			}
		}
	}


	#pragma mark -

	-(void *) pointerAtIndex:(NSUInteger)anIndex {
		if (anIndex > count - 1) {
			[NSException raise:NSRangeException format:@"-[ZJPointerArray pointerAtIndex:] inIndex (%d) is greater than count (%d) - 1", anIndex, count];
		}
		return (buffer[anIndex]);
	}

	-(void) addPointer:(void *)aPointer {
		self.count += 1;
		self.buffer[self.count - 1] = aPointer;
	}


	#pragma mark -

	-(NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len {
		const NSUInteger startIndex		= state->state;
		const NSUInteger startCount		= MIN(self.count - startIndex, len);
		
		if (startCount > 0) {
			state->itemsPtr = (id *)&buffer[startIndex];
		}
		else {
			state->itemsPtr = NULL;
		}
		
		state->state		= startIndex + startCount;
		state->mutationsPtr = (unsigned long *)&buffer;
		return (startCount);
	}

@end

/*
@copyright	2008 toxicsoftware.com. All rights reserved.
@origin		Jonathan Wight, 9/10/08, TouchCode
@text		Permission is hereby granted, free of charge, to any person
			obtaining a copy of this software and associated documentation
			files (the "Software"), to deal in the Software without
			restriction, including without limitation the rights to use,
			copy, modify, merge, publish, distribute, sublicense, and/or sell
			copies of the Software, and to permit persons to whom the
			Software is furnished to do so, subject to the following
			conditions:

			The above copyright notice and this permission notice shall be
			included in all copies or substantial portions of the Software.

			THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
			EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
			OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
			NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
			HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
			WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
			FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
			OTHER DEALINGS IN THE SOFTWARE.
*/