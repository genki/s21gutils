//
//  PDPriorityQueue.h
//  PocketDiary
//
//  Created by takiuchi on 08/10/06.
//  Copyright 2008 s21g LLC. All rights reserved.
//

@class PDLinkedListNode;

@interface PDLinkedList : NSObject <NSFastEnumeration>
{		
	PDLinkedListNode *_head;
	PDLinkedListNode *_tail;
	NSUInteger _size;
}

@property (nonatomic, assign, readonly) PDLinkedListNode *head;
@property (nonatomic, assign, readonly) PDLinkedListNode *tail;

- (NSUInteger)size;
- (PDLinkedListNode*)push:(id)object;
- (id)pop;
- (PDLinkedListNode*)unshift:(id)object;
- (id)shift;
- (void)remove:(PDLinkedListNode*)node;
- (void)clear;
- (NSArray *)sortedArrayUsingSelector:(SEL)comparator;

@end
