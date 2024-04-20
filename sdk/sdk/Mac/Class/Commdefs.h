#ifndef __COMMUNICATION_H__
#define __COMMUNICATION_H__

//#define IR_300	0
#define RF_300	1
#define RF_700	2
#define RF_900	3

//300教师机命令
#define CMD300_PREV							0x80
#define CMD300_OK							0x81		
#define CMD300_RUN							0x82
#define CMD300_RESULT						0x83
#define	CMD300_REPORT						0x84
#define CMD300_START						0x85
#define CMD300_STOP							0x86
#define CMD300_NEXT							0x87
#define CMD300_F1							0x88	
#define CMD300_F2							0x89

///////////////////////////////////////////

#define HANDSHAKE                           0xf0
#define CMD700_DEVICE_VERSION				0xf1
#define CMD700_SET_CHANNEL_NO				0xf2
#define CMD700_SEND_CHANNEL_NO				0xf3
#define CMD700_TEACHER_COMMAND				0xf4
#define CMD700_GET_CURRENT_STATE			0xf5
#define CMD700_LOGOUT						0xf6
#define CMD700_COMMAND_OF_F7				0xf7
#define CMD700_COMMAND_OF_F8				0xf8
#define CMD700_SEARCH_CLASS					0xf9
#define CMD700_STUDENT_STD_EXAM_ANSWER		0xfa
#define CMD700_STUDENT_SIGNAL				0xfb
#define CMD700_MOUSE_CONTROL				0xfc
#define CMD700_HARDWARE_TEST				0xfd
#define CMD700_COMMAND_OF_FE				0xfe

#define CMD700_COMMAND_OF_F5				0xf5
#define CMD700_COMMAND_OF_F9                0xf9

////////////////////////////////////////////

#define RECEIVE_OK							0xe0
#define TEST_ID_WRONG						0xe1

#define TCOMMAND_BEGIN						0x10
#define TCOMMAND_F1							0x81
#define TCOMMAND_F2							0x82
#define TCOMMAND_PREVIOUS					0x84
#define TCOMMAND_EXIT						0x85
#define TCOMMAND_NEXT						0x86
#define TCOMMAND_SEND						0x87
#define TCOMMAND_RECEIVE					0x88
#define TCOMMAND_FORCE						0x89
#define TCOMMAND_START						0x8a
#define TCOMMAND_STOP						0x8b
#define TCOMMAND_REPORT						0x8c
#define TCOMMAND_RESULT						0x8d
#define TCOMMAND_RUSH						0x40
#define function_A                      0x41
#define function_F                      0x46
#define send_over                       0xff
#define answer_send_end                 0xe0
#define receive_true                    0xe0
#define title_send_end                  0xe1
#define receive_false                   0xee
#define STUDENT_OUT                     0xef

#define TEACHER_HIGH_ADDR				0xef
#define student_IDstart                 0x01
#define student_IDend                   0xe0
#define host_IDstart                    0xe8
#define host_IDend                      0xef
#define AES_BAUD							B115200
#define RF_900_BAUD							B115200
#define RF_700_BAUD							B115200
#define RF_300_BAUD							B28800
#define IR_300_BAUD							B28800

#define PC_NO_READY							0
#define PC_QUIZ_GENIUS						1
#define PC_READY_EXAM						2
#define PC_START_EXAM						3
#define PC_HARDWARE_TEST					4

#define MAX_STUDENT_ANSWER_LENGTH		5
#define MAX_CLASS_NAME_LENGTH700		14
#define MAX_CLASS_NAME_LENGTH900		14
#define MAX_TEACHER_NAME_LENGTH700		14
#define MAX_TEACHER_NAME_LENGTH900		14
#define MAX_STUDENT_NAME_LENGTH700		14
#define MAX_STUDENT_NAME_LENGTH900		14
#define MAX_EXAM_TITLE_LENGTH700		14
#define MAX_EXAM_TITLE_LENGTH900		14

//硬件设备里的活动模式
#define DEC_MODE_NORMAL_QUIZ			0
#define DEC_MODE_PAPER_QUIZ				1
#define DEC_MODE_HOMEWORK				2
#define DEC_MODE_RUSH_QUIZ				3
#define DEC_MODE_ELIMINATION			4
#define DEC_MODE_FREE_STYLE				5
#define DEC_MODE_GRADE1					6
#define DEC_MODE_SURVEY					7
#define DEC_MODE_VOTE					8
#define DEC_MODE_ROLLCALL				9
#define DEC_MODE_MULTIPLE				12
#define DEC_MODE_NORMAL_ANS_SHEET		13
#define DEC_MODE_LIB_ANS_SHEET			14

//学生设备里的活动模式
#define STU_DEC_FREE_STYLE				0x00
#define STU_DEC_NORMAL					0x01
#define STU_DEC_STD_EXAM				0x02
#define STU_DEC_RUSH_QUIZ				0x03
#define STU_DEC_ELIMINATION				0x04
#define STU_DEC_ROLLCALL				0x08
#define STU_DEC_VOTE					0x09
#define STU_DEC_CLOZE					0x0a
#define STU_DEC_HOMEWORK				0x0b
#define STU_DEC_MULTIPLE				0x0c

#endif