//
//  QRF700.m
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//

#import "QRF700.h"

@implementation QRF700
- (BOOL)openDevice
{
	return [super openPort:m_bsdPath withBuadRate:RF_700_BAUD];
}

- (int)detectDevice:(const char*)bsdPath
{
	BOOL bOpened;
	m_fileDescriptor = -1;
	
	if([super openPort:bsdPath withBuadRate:RF_700_BAUD])
		bOpened = TRUE;
	else
		bOpened = FALSE;
	
	if(bOpened)
	{
	    unsigned  char rdMessage[10];
		unsigned char data[5]={0xf0,0x00,0x00,0x00,0xf0};
		
		bOpened = FALSE;

		[super sendData:data withSize:5];
		usleep(100000); // 10 ms  因为700 所以变成300
		if([super readDataWaiting]>=5)
		{
			if([super readData:rdMessage withLen:5])
			{
				if(rdMessage[0]==0xf0&&rdMessage[3]==0x7f)
				{
					bOpened = TRUE;
					type = RF_700;
				}
				else if(rdMessage[0]==0xf0&&rdMessage[3]==0x9f)
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
