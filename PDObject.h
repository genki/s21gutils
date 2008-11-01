//
//  PDObject.h
//  PocketDiary
//
//  Created by takiuchi on 08/10/09.
//  Copyright 2008 s21g LLC. All rights reserved.
//

@protocol PDIdentity

@property (nonatomic, readonly) id identifier;

@end

@interface PDObject : NSObject <PDIdentity>
{
}

@end
