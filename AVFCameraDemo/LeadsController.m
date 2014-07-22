//
//  LeadsController.m
//  HelloWorld
//
//  Created by Omar Gómez on 7/21/14.
//  Copyright (c) 2014 Erica Sadun. All rights reserved.
//

#import "LeadsController.h"
#import "Utility.h"

@interface LeadsController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong) CameraImageHelper *cameraHelper;
@property (strong) ScannerHelper *scannerHelper;
@property (strong) NSLock *scannerLock;

@end

@implementation LeadsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scannerLock = [[NSLock alloc] init];
    self.cameraHelper = [CameraImageHelper helperWithCamera:kCameraBack];
    self.cameraHelper.delegate = self;
    self.scannerHelper = [[ScannerHelper alloc] init];
    self.scannerHelper.delegate = self;
    [self.scannerHelper registerCode:@{}];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.cameraHelper startRunningSession];
    [self.cameraHelper embedPreviewInView:self.imageView];
    [self.cameraHelper layoutPreviewInView:self.imageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.view layoutIfNeeded];
    [self.cameraHelper layoutPreviewInView:self.imageView];
}

- (void) didScanResult:(id) result
{
    NSLog(@"didScanResult");
}

- (void) didCaptureSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    if ([self.scannerLock tryLock]) {
        
        [self.scannerHelper resetFrameBuffer: sampleBuffer];
        
        //Free
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                NSString *str = [self.scannerHelper scanBuffer];
                NSLog(@"Decoded, %@", str);
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.scannerLock unlock];
            });
        });
        
    }
    else {
        //lets try later
        NSLog(@"later...");
        return;
    }
    
}

@end
