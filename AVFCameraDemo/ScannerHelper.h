//
//  ScannerHelper.h
//  HelloWorld
//
//  Created by Omar Gómez on 7/21/14.
//  Copyright (c) 2014 Erica Sadun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScannerHelperDelegate <NSObject>
- (void) didScanResult:(id) result;
@end

@interface ScannerHelper : NSObject

@property (nonatomic, weak) id <ScannerHelperDelegate>delegate;
@property (nonatomic, assign) BOOL scannig;

-(void) registerCode:(NSDictionary *) codeMap;
-(NSString *) scanBuffer;
-(void) resetFrameBuffer:(CMSampleBufferRef) sampleBuffer;

@end
