//
//  PDLinkedListNode.h
//  PocketDiary
//
//  Created by takiuchi on 08/10/07.
//  Copyright 2008 s21g LLC. All rights reserved.
//

@interface PDLinkedListNode : NSObject
{
	PDLinkedListNode *_prev;
	PDLinkedListNode *_next;
	id _object;
}

@property (nonatomic, assign) PDLinkedListNode *prev;
@property (nonatomic, assign) PDLinkedListNode *next;
@property (nonatomic, retain) id object;

@end
