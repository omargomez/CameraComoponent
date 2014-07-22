//
//  LeadsController.h
//  HelloWorld
//
//  Created by Omar Gómez on 7/21/14.
//  Copyright (c) 2014 Erica Sadun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraImageHelper.h"
#import "ScannerHelper.h"

@interface LeadsController : UIViewController<ScannerHelperDelegate, CameraHelperDelegate>

@end
