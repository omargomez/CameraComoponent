//
//  ScannerHelper.m
//  HelloWorld
//
//  Created by Omar Gómez on 7/21/14.
//  Copyright (c) 2014 Erica Sadun. All rights reserved.
//

#import "ScannerHelper.h"
#import "BarcodeScanner.h"

#define PDF_OPTIMIZED false  

// !!! Rects are in format: x, y, width, height !!!
#define RECT_LANDSCAPE_1D       4, 20, 92, 60
#define RECT_LANDSCAPE_2D       20, 5, 60, 90
#define RECT_PORTRAIT_1D        20, 4, 60, 92
#define RECT_PORTRAIT_2D        20, 5, 60, 90
#define RECT_FULL_1D            4, 4, 92, 92
#define RECT_FULL_2D            20, 5, 60, 90
@interface ScannerHelper ()

@property (strong) NSData *frameBuffer;
@property (assign) int width;
@property (assign) int height;

@end

@implementation ScannerHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        _scannig = NO;
    }
    return self;
}


-(void) registerCode:(NSDictionary *) codeMap
{

    //register your copy of library with givern user/password
    MWB_registerCode(MWB_CODE_MASK_39,      "username", "key");
    MWB_registerCode(MWB_CODE_MASK_93,      "username", "key");
    MWB_registerCode(MWB_CODE_MASK_25,      "username", "key");
    MWB_registerCode(MWB_CODE_MASK_128,     "username", "key");
    MWB_registerCode(MWB_CODE_MASK_AZTEC,   "username", "key");
    MWB_registerCode(MWB_CODE_MASK_DM,      "username", "key");
    MWB_registerCode(MWB_CODE_MASK_EANUPC,  "username", "key");
    MWB_registerCode(MWB_CODE_MASK_QR,      "username", "key");
    MWB_registerCode(MWB_CODE_MASK_PDF,     "username", "key");
    MWB_registerCode(MWB_CODE_MASK_RSS,     "username", "key");
    MWB_registerCode(MWB_CODE_MASK_CODABAR, "username", "key");
    
  
    // choose code type or types you want to search for
    
    if (PDF_OPTIMIZED){
        MWB_setActiveCodes(MWB_CODE_MASK_PDF);
        MWB_setDirection(MWB_SCANDIRECTION_HORIZONTAL);
        MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_LANDSCAPE_1D);
    } else {
        // Our sample app is configured by default to search all supported barcodes...
        MWB_setActiveCodes(MWB_CODE_MASK_25    |
                           MWB_CODE_MASK_39     |
                           MWB_CODE_MASK_93     |
                           MWB_CODE_MASK_128    |
                           MWB_CODE_MASK_AZTEC  |
                           MWB_CODE_MASK_DM     |
                           MWB_CODE_MASK_EANUPC |
                           MWB_CODE_MASK_PDF    |
                           MWB_CODE_MASK_QR     |
                           MWB_CODE_MASK_CODABAR|
                           MWB_CODE_MASK_RSS);
        
        // Our sample app is configured by default to search both directions...
        MWB_setDirection(MWB_SCANDIRECTION_HORIZONTAL | MWB_SCANDIRECTION_VERTICAL);
        // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
        MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_93,     RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_FULL_2D);
        MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_FULL_2D);
        MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_FULL_2D);
        MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_FULL_1D);
        MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_FULL_1D);
    }
    
   
    // But for better performance, only activate the symbologies your application requires...
    // MWB_setActiveCodes( MWB_CODE_MASK_25 );
    // MWB_setActiveCodes( MWB_CODE_MASK_39 );
    // MWB_setActiveCodes( MWB_CODE_MASK_93 );
    // MWB_setActiveCodes( MWB_CODE_MASK_128 );
    // MWB_setActiveCodes( MWB_CODE_MASK_AZTEC );
    // MWB_setActiveCodes( MWB_CODE_MASK_DM );
    // MWB_setActiveCodes( MWB_CODE_MASK_EANUPC );
    // MWB_setActiveCodes( MWB_CODE_MASK_PDF );
    // MWB_setActiveCodes( MWB_CODE_MASK_QR );
    // MWB_setActiveCodes( MWB_CODE_MASK_RSS );
    // MWB_setActiveCodes( MWB_CODE_MASK_CODABAR );
    
    
    // But for better performance, set like this for PORTRAIT scanning...
    // MWB_setDirection(MWB_SCANDIRECTION_VERTICAL);
    // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
    // MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_93,     RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_PORTRAIT_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_PORTRAIT_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_PORTRAIT_1D);
    
    // or like this for LANDSCAPE scanning - Preferred for dense or wide codes...
    // MWB_setDirection(MWB_SCANDIRECTION_HORIZONTAL);
    // set the scanning rectangle based on scan direction(format in pct: x, y, width, height)
    // MWB_setScanningRect(MWB_CODE_MASK_25,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_39,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_93,     RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_128,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_AZTEC,  RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_DM,     RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_EANUPC, RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_PDF,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_QR,     RECT_LANDSCAPE_2D);
    // MWB_setScanningRect(MWB_CODE_MASK_RSS,    RECT_LANDSCAPE_1D);
    // MWB_setScanningRect(MWB_CODE_MASK_CODABAR,RECT_LANDSCAPE_1D);
    
    
    // set decoder effort level (1 - 5)
    // for live scanning scenarios, a setting between 1 to 3 will suffice
    // levels 4 and 5 are typically reserved for batch scanning
    MWB_setLevel(2);
    
    //get and print Library version
    int ver = MWB_getLibVersion();
    int v1 = (ver >> 16);
    int v2 = (ver >> 8) & 0xff;
    int v3 = (ver & 0xff);
    NSString *libVersion = [NSString stringWithFormat:@"%d.%d.%d", v1, v2, v3];
    NSLog(@"Lib version: %@", libVersion);
}

-(void) resetFrameBuffer:(CMSampleBufferRef) sampleBuffer
{
	unsigned char *baseAddress;
	int bytesPerRow;
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    //Lock the image buffer
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    //Get information about the image
    baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer,0);
    int pixelFormat = CVPixelBufferGetPixelFormatType(imageBuffer);
	switch (pixelFormat) {
		case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
			bytesPerRow = (int) CVPixelBufferGetBytesPerRowOfPlane(imageBuffer,0);
			_width = bytesPerRow;//CVPixelBufferGetWidthOfPlane(imageBuffer,0);
			_height = (int) CVPixelBufferGetHeightOfPlane(imageBuffer,0);
			break;
		case kCVPixelFormatType_422YpCbCr8:
			//NSLog(@"Capture pixel format=UYUY422");
			bytesPerRow = (int) CVPixelBufferGetBytesPerRowOfPlane(imageBuffer,0);
			_width = (int) CVPixelBufferGetWidth(imageBuffer);
			_height = (int) CVPixelBufferGetHeight(imageBuffer);
			int len = _width*_height;
			int dstpos=1;
			for (int i=0;i<len;i++){
				baseAddress[i]=baseAddress[dstpos];
				dstpos+=2;
			}
			
			break;
		default:
			break;
	}
	
    self.frameBuffer = [[NSData alloc] initWithBytes:baseAddress length:_width*_height ];
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
}

-(NSString *) scanBuffer
{
    _scannig = YES;
    NSString *result = nil;
    NSString * lastFormat;
	CGImageRef	decodeImage = nil;
    
#if 1
	unsigned char *pResult=NULL;
    int resLength = MWB_scanGrayscaleImage([self.frameBuffer bytes], _width, _height, &pResult);

    //ignore results less than 4 characters - probably false detection
    if (resLength > 4 || ((resLength > 0 && MWB_getLastType() != FOUND_39 && MWB_getLastType() != FOUND_25_INTERLEAVED && MWB_getLastType() != FOUND_25_STANDARD)))
	{
        
		int bcType = MWB_getLastType();
    	NSString *typeName=@"";
    	switch (bcType) {
            case FOUND_25_INTERLEAVED: typeName = @"Code 25 Interleaved";break;
            case FOUND_25_STANDARD: typeName = @"Code 25 Standard";break;
    		case FOUND_128: typeName = @"Code 128";break;
    		case FOUND_39: typeName = @"Code 39";break;
            case FOUND_93: typeName = @"Code 93";break;
    		case FOUND_AZTEC: typeName = @"AZTEC";break;
    		case FOUND_DM: typeName = @"Datamatrix";break;
            case FOUND_QR: typeName = @"QR";break;
    		case FOUND_EAN_13: typeName = @"EAN 13";break;
    		case FOUND_EAN_8: typeName = @"EAN 8";break;
    		case FOUND_NONE: typeName = @"None";break;
    		case FOUND_RSS_14: typeName = @"Databar 14";break;
    		case FOUND_RSS_14_STACK: typeName = @"Databar 14 Stacked";break;
    		case FOUND_RSS_EXP: typeName = @"Databar Expanded";break;
    		case FOUND_RSS_LIM: typeName = @"Databar Limited";break;
    		case FOUND_UPC_A: typeName = @"UPC A";break;
    		case FOUND_UPC_E: typeName = @"UPC E";break;
            case FOUND_PDF: typeName = @"PDF417";break;
            case FOUND_CODABAR: typeName = @"Codabar";break;
        }
        
#warning IMPORTANT
        lastFormat = typeName;
        
        
        
        
		
		int size=resLength;
		
		char *temp = (char *)malloc(size+1);
		memcpy(temp, pResult, size+1);
		NSString *resultString = [[NSString alloc] initWithBytes: temp length: size encoding: NSUTF8StringEncoding];
        
        NSLog(@"Detected %@: %@", lastFormat, resultString);
        
        NSMutableString *binString = [[NSMutableString alloc] init];
        
        for (int i = 0; i < size; i++)
            [binString appendString:[NSString stringWithFormat:@"%c", temp[i]]];
        
        if (MWB_getLastType() == FOUND_PDF || resultString == nil)
            resultString = [binString copy];
        else
            resultString = [resultString copy];
        
		free(temp);
		
		free(pResult);
        
	    if (decodeImage != nil)
	    {
			CGImageRelease(decodeImage);
			decodeImage = nil;
		}
		
        result = resultString;

	}
              
#endif
    
    _scannig = NO;
    return result;
}

@end
