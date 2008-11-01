//
//  PDLinkedListTest.m
//  PocketDiary
//
//  Created by takiuchi on 08/10/07.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDLinkedListTest.h"
#import "PDLinkedListNode.h"

@implementation PDLinkedListTest

- (void)setUp
{
	_linkedList = [PDLinkedList new];
}

- (void)tearDown
{
	[_linkedList release];
}

- (void)testRetainCountAtInitialState
{
	STAssertEquals([_linkedList retainCount], 1U,
				   @"Check retainCount at initial state.");
	STAssertEquals([_linkedList size], 0U, @"the size should be zero.");
}

- (void)testPushAndPopObject
{
	id object = [NSDate new];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	
	PDLinkedListNode *node = [_linkedList push:object];
	
	STAssertNotNil(node, @"node should not be nil.");
	STAssertEqualObjects([node object], object,
						 @"these objects should be same.");
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([_linkedList size], 1U, @"the size should be one.");
	
	id result = [_linkedList pop];
	STAssertEqualObjects(result, object, @"the result should be same to the object");
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([_linkedList size], 0U, @"the size should be zero.");
	
	[result release];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	[object release];
}

- (void)testUnshiftAndShiftObject
{
	id object = [NSDate new];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	
	PDLinkedListNode *node = [_linkedList unshift:object];
	
	STAssertNotNil(node, @"node should not be nil.");
	STAssertEqualObjects([node object], object,
						 @"these objects should be same.");
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([_linkedList size], 1U, @"the size should be one.");
	
	id result = [_linkedList shift];
	STAssertEqualObjects(result, object, @"the result should be same to the object");
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([_linkedList size], 0U, @"the size should be zero.");
	
	[result release];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	[object release];
}

- (void)testRetainCountWhileRemoval
{
	id object = [NSDate new];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	
	PDLinkedListNode *node = [_linkedList push:object];
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	
	id object2 = [NSDate new];
	[_linkedList push:object2];
	[object2 release];
	
	id object3 = [NSDate new];
	[_linkedList push:object3];
	[object3 release];
	
	int count = 0;
	for(PDLinkedListNode *node in _linkedList){
		count++;
	}
	STAssertEquals(count, 3, @"the count should be 3.");
	
	NSArray *array = [_linkedList sortedArrayUsingSelector:@selector(compare:)];
	STAssertEquals([array retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([array count], 3U, @"the count should be 3");
	STAssertEqualObjects([array objectAtIndex:2], object3,
						 @"the last object should be object3");
	[array release];
	
	[node retain];
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([node retainCount], 2U, @"the retainCount should be 3");
	
	[_linkedList remove:node];
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	
	[node release];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([_linkedList size], 2U, @"the size should be 2");
	
	[object release];
}

- (void)testRetainCountWhileShifting
{
	id object = [NSDate new];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	
	PDLinkedListNode *node = [_linkedList push:object];
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	
	id object2 = [NSDate new];
	[_linkedList push:object2];
	[object2 release];
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	
	id object3 = [NSDate new];
	[_linkedList push:object3];
	[object3 release];
	
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	
	STAssertEqualObjects(node, _linkedList.head, @"the node should be the head.");
	STAssertNil(node.prev, @"the node should be the head");
	STAssertEquals([node.next retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([node.next.next retainCount], 1U, @"the retainCount should be 1");
	
	PDLinkedListNode *head = _linkedList.head;
	PDLinkedListNode *tail = _linkedList.tail;
	STAssertEquals([head retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([tail retainCount], 1U, @"the retainCount should be 1");
	
	[node retain];
	id result = [_linkedList shift];
	[result release];
	STAssertEqualObjects(result, object, @"the result should equal to the object.");
	STAssertEquals([node retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([object retainCount], 2U, @"the retainCount should be 2");
	
	[node release];
	STAssertEquals([object retainCount], 1U, @"the retainCount should be 1");
	STAssertEquals([_linkedList size], 2U, @"the size should be 2");
	
	[object release];
}

- (void)testSorting
{
	NSNumber *number4 = [NSNumber numberWithInt:4];
	[_linkedList push:number4];
	NSNumber *number1 = [NSNumber numberWithInt:1];
	[_linkedList push:number1];
	NSNumber *number2 = [NSNumber numberWithInt:2];
	[_linkedList push:number2];
	
	NSArray *array = [_linkedList sortedArrayUsingSelector:@selector(compare:)];
	STAssertEquals([array count], 3U, @"Sorting operation shouldn't change size");
	STAssertEqualObjects([array objectAtIndex:0], number1, @"number1 should be the head");
	STAssertEqualObjects([array objectAtIndex:1], number2, @"number2 should be the middle");
	STAssertEqualObjects([array objectAtIndex:2], number4, @"number4 should be the tail");
	[array release];
	
	[number2 release];
	[number1 release];
	[number4 release];
}

@end
