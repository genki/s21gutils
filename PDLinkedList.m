//
//  PDPriorityQueue.m
//  PocketDiary
//
//  Created by takiuchi on 08/10/06.
//  Copyright 2008 s21g LLC. All rights reserved.
//

#import "PDLinkedList.h"
#import "PDLinkedListNode.h"

@implementation PDLinkedList
@synthesize head = _head;
@synthesize tail = _tail;

- (id)init
{	
	if(![super init]) return self;
	_head = _tail = nil;
	_size = 0;
	return self;
}

- (NSUInteger)size
{
	return _size;
}

- (PDLinkedListNode *)
push:(id)object
{
	PDLinkedListNode *node = [PDLinkedListNode new];
	if(!node) return nil;
	node.object = object;
	if(_tail){
		if(_tail.prev){
			_tail.next = node;
			node.prev = _tail;
			_tail = node;
		}else{
			_tail = node;
			_head.next = _tail;
			_tail.prev = _head;
		}
	}else{
		_head = _tail = node;
	}
	_size++;
	return node;
}

- (PDLinkedListNode *)
unshift:(id)object
{
	PDLinkedListNode *node = [PDLinkedListNode new];
	if(!node) return nil;
	node.object = object;
	if(_head){
		if(_head.next){
			_tail.prev = node;
			node.next = _head;
			_head = node;
		}else{
			_head = node;
			_head.next = _tail;
			_tail.prev = _head;
		}
	}else{
		_head = _tail = node;
	}
	_size++;
	return node;
}

- (id)pop
{
	if(!_tail) return nil;
	id object = [_tail.object retain];
	if(_tail.prev){
		_tail = _tail.prev;
		[_tail.next release];
		_tail.next = nil;
	}else{
		[_tail release];
		_head = _tail = nil;
	}
	_size--;
	return object;
}

- (id)shift
{
	if(!_head) return nil;
	id object = [_head.object retain];
	if(_head.next){
		_head = _head.next;
		[_head.prev release];
		_head.prev = nil;
	}else{
		[_head release];
		_head = _tail = nil;
	}
	_size--;
	return object;
}

- (void)
remove:(PDLinkedListNode *)node
{
	if(node.prev) node.prev.next = node.next;
	if(node.next) node.next.prev = node.prev;
	if(node == _head) _head = node.next;
	if(node == _tail) _tail = node.prev;
	[node release];
	_size--;
}

- (void)clear
{
	while(_head){
		_tail = _head;
		_head = _head.next;
		[_tail release];
	}
	_head = _tail = nil;
	_size = 0;
}

- (NSArray *)
sortedArrayUsingSelector:(SEL)comparator
{
	NSMutableArray *array = [NSMutableArray new];
	for(id object in self){
		[array addObject:object];
	}
	[array sortUsingSelector:comparator];
	return array;
}

#pragma mark NSFastEnumerationState methods

- (NSUInteger)
countByEnumeratingWithState:(NSFastEnumerationState *)state
objects:(id *)stackbuf
count:(NSUInteger)len
{
	state->itemsPtr = stackbuf;

	PDLinkedListNode *node = _head;
	NSUInteger count = MIN(_size - state->state, len);
	if(count > 0 && state->state > 0) node = (PDLinkedListNode*)state->extra[0];
	for(NSUInteger i = 0; i < count; ++i){
		stackbuf[i] = node.object;
		node = node.next;
	}
	state->state += count;
	state->mutationsPtr = (unsigned long*)self;
	if(count) state->extra[0] = (unsigned long)node;
	return count;
}

- (void)dealloc
{
	[self clear];
	[super dealloc];
}

@end
