//
//  QRF300.m
//  QARSDrv900
//
//  Created by Frank Lin on 5/9/09.
//  Copyright 2009 Qomo. All rights reserved.
//

#import "QRF300.h"


@implementation QRF300
- (BOOL)openDevice
{
	return [super openPort:m_bsdPath withBuadRate:RF_300_BAUD];
}

- (int)detectDevice:(const char*)bsdPath
{
	BOOL bOpened;
	m_fileDescriptor = -1;
	
	if([super openPort:bsdPath withBuadRate:RF_300_BAUD])
		bOpened = TRUE;
	else
		bOpened = FALSE;
	
	if(bOpened)
	{
	    unsigned  char rdMessage[10];
		unsigned char data[11] = {0x5e,0x80,0xde,0xb2,0xb0,0xb0,0xb2,0xb0,0xb1,0xb1,0xb7};
		//5e 80 de b2 b0 b0 b2 b0 b1 b1 b7
		bOpened = FALSE;
		
		[super sendData:data withSize:11];
		usleep(10000); // 10 ms
		if([super readDataWaiting]>=3)
		{
			if([super readData:rdMessage withLen:3])
			{
				if(rdMessage[0]==0x7b&&rdMessage[2]==0xf8)
				{
					// it is 300 series, default is RF_300
					unsigned char rf_ir_data[3] = {0x5e, 0x83, 0xdd};//5e 83 (de)dd IR300 RF300
					[super sendData: rf_ir_data withSize: 3];
					usleep(10000);
					if([super readDataWaiting]>=3)
					{
						if([super readData:rdMessage withLen:3])
						{
							if(rdMessage[0]==0x7b && rdMessage[2]==0xfb)//rf300 7B 81 FB
							{
								bOpened = FALSE;
							}
							else// if(rdMessage[0]==0x7b&&rdMessage[2]==0xfb)//rf300 7B 80 FB
							{
								type = RF_300;
								bOpened = TRUE;
							}				
						}	
					}
					else
					{
						type = RF_300;
						bOpened = TRUE;						
					}

					[super clearBuf];	
				}
				else if(rdMessage[0]==0x7b && rdMessage[2]==0xfb)//rf300 ,7B 80 FB
				{
					type = RF_300;			
					bOpened = TRUE;
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
