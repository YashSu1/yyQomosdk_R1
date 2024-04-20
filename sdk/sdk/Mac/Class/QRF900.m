//
//  QRF900.m
//  QARS900
//
//  Created by yxg on 09-11-28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QRF900.h"

@implementation QRF900

- (BOOL)openDevice
{
	return [super openPort:m_bsdPath withBuadRate:RF_900_BAUD];
}

- (int)detectDevice:(const char*)bsdPath
{
	BOOL bOpened;
	m_fileDescriptor = -1;
	
	if([super openPort:bsdPath withBuadRate:RF_900_BAUD])
		bOpened = TRUE;
	else
		bOpened = FALSE;
	
	if(bOpened)
	{
	    unsigned  char rdMessage[10];
		unsigned char data[5]={0xf0,0x00,0x00,0x00,0xf0};
		bOpened = FALSE;
		
		[super sendData:data withSize:5];
		usleep(1000000); // 10 ms
		if([super readDataWaiting]>=5)
		{
			if([super readData:rdMessage withLen:5])
			{
				if(rdMessage[0]==0xf0&&rdMessage[3]==0x9f)
				{
					bOpened = TRUE;
					type = RF_900;
				}
			}
		}
		[super clearBuf];
		[super closePort];
	}
	
	if(bOpened)
		strcpy(m_bsdPath, bsdPath);
	
	return bOpened;
}

@end
