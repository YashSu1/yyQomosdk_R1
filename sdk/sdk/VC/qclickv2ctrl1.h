#pragma once

// 计算机生成了由 Microsoft Visual C++ 创建的 IDispatch 包装类

// 注意: 不要修改此文件的内容。如果此类由
//  Microsoft Visual C++ 重新生成，您的修改将被覆盖。

/////////////////////////////////////////////////////////////////////////////
// CQclickv2ctrl1 包装类

class CQclickv2ctrl1 : public CWnd
{
protected:
	DECLARE_DYNCREATE(CQclickv2ctrl1)
public:
	CLSID const& GetClsid()
	{
		static CLSID const clsid
			= { 0xB0C7E054, 0x1C3A, 0x4FF6, { 0x8C, 0x86, 0x91, 0x3C, 0xD6, 0xB1, 0xA6, 0x57 } };
		return clsid;
	}
	virtual BOOL Create(LPCTSTR lpszClassName, LPCTSTR lpszWindowName, DWORD dwStyle,
						const RECT& rect, CWnd* pParentWnd, UINT nID, 
						CCreateContext* pContext = NULL)
	{ 
		return CreateControl(GetClsid(), lpszWindowName, dwStyle, rect, pParentWnd, nID); 
	}

    BOOL Create(LPCTSTR lpszWindowName, DWORD dwStyle, const RECT& rect, CWnd* pParentWnd, 
				UINT nID, CFile* pPersist = NULL, BOOL bStorage = FALSE,
				BSTR bstrLicKey = NULL)
	{ 
		return CreateControl(GetClsid(), lpszWindowName, dwStyle, rect, pParentWnd, nID,
		pPersist, bStorage, bstrLicKey); 
	}

// 特性
public:


// 操作
public:

// _DQClickV2

// Functions
//

	BOOL InitHost()
	{
		BOOL result;
		InvokeHelper(0x1, DISPATCH_METHOD, VT_BOOL, (void*)&result, NULL);
		return result;
	}
	CString GetHostInfo(long lFlag)
	{
		CString result;
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0x2, DISPATCH_METHOD, VT_BSTR, (void*)&result, parms, lFlag);
		return result;
	}
	long SetHostChannel(short nChannelNo)
	{
		long result;
		static BYTE parms[] = VTS_I2 ;
		InvokeHelper(0x3, DISPATCH_METHOD, VT_I4, (void*)&result, parms, nChannelNo);
		return result;
	}
	long StartSession(LPCTSTR pClassName, LPCTSTR pTeacherName, long lMaxStudents, short nSessionType, BOOL bLoginFlag, BOOL bAutoLoginFlag)
	{
		long result;
		static BYTE parms[] = VTS_BSTR VTS_BSTR VTS_I4 VTS_I2 VTS_BOOL VTS_BOOL ;
		InvokeHelper(0x4, DISPATCH_METHOD, VT_I4, (void*)&result, parms, pClassName, pTeacherName, lMaxStudents, nSessionType, bLoginFlag, bAutoLoginFlag);
		return result;
	}
	long StartQuestion(short nQuestionNo, short nQuestionType, short nNumberOfOption, BOOL bIsSendQuestion, LPCTSTR pQuestionInfo, LPCTSTR pCorrectAnswer, short nQuestionSessionType, short nReanswerTimes)
	{
		long result;
		static BYTE parms[] = VTS_I2 VTS_I2 VTS_I2 VTS_BOOL VTS_BSTR VTS_BSTR VTS_I2 VTS_I2 ;
		InvokeHelper(0x5, DISPATCH_METHOD, VT_I4, (void*)&result, parms, nQuestionNo, nQuestionType, nNumberOfOption, bIsSendQuestion, pQuestionInfo, pCorrectAnswer, nQuestionSessionType, nReanswerTimes);
		return result;
	}
	long StopQuestion()
	{
		long result;
		InvokeHelper(0x6, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	long StopSession()
	{
		long result;
		InvokeHelper(0x7, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	BOOL AllowLogin(long lSerialNO, long lNewKeypadNo, LPCTSTR pStudentID, BOOL bAllowLogin, BOOL bIsSendStudentName, LPCTSTR pStudentName, long nLoginStudentNum)
	{
		BOOL result;
		static BYTE parms[] = VTS_I4 VTS_I4 VTS_BSTR VTS_BOOL VTS_BOOL VTS_BSTR VTS_I4 ;
		InvokeHelper(0x8, DISPATCH_METHOD, VT_BOOL, (void*)&result, parms, lSerialNO, lNewKeypadNo, pStudentID, bAllowLogin, bIsSendStudentName, pStudentName, nLoginStudentNum);
		return result;
	}
	BOOL CloseHost()
	{
		BOOL result;
		InvokeHelper(0x9, DISPATCH_METHOD, VT_BOOL, (void*)&result, NULL);
		return result;
	}
	long SetKeypadNO(long lKeypadNO)
	{
		long result;
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0xa, DISPATCH_METHOD, VT_I4, (void*)&result, parms, lKeypadNO);
		return result;
	}
	long HomeworkSetExamTitle(short nExamID, LPCTSTR pExamTitle, short nQuestionNum, BOOL bRandomPaper)
	{
		long result;
		static BYTE parms[] = VTS_I2 VTS_BSTR VTS_I2 VTS_BOOL ;
		InvokeHelper(0xb, DISPATCH_METHOD, VT_I4, (void*)&result, parms, nExamID, pExamTitle, nQuestionNum, bRandomPaper);
		return result;
	}
	long HomeworkSetQuestionInfo(short nQuestionNo, short nQuestionType, LPCTSTR pQuestionInfo, LPCTSTR pAnswer)
	{
		long result;
		static BYTE parms[] = VTS_I2 VTS_I2 VTS_BSTR VTS_BSTR ;
		InvokeHelper(0xc, DISPATCH_METHOD, VT_I4, (void*)&result, parms, nQuestionNo, nQuestionType, pQuestionInfo, pAnswer);
		return result;
	}
	CString GetStudentAnswer(LPCTSTR pStudentID, short nQuestionNo)
	{
		CString result;
		static BYTE parms[] = VTS_BSTR VTS_I2 ;
		InvokeHelper(0xd, DISPATCH_METHOD, VT_BSTR, (void*)&result, parms, pStudentID, nQuestionNo);
		return result;
	}
	long HomeworkSendExamInfo()
	{
		long result;
		InvokeHelper(0xe, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	long StartSessionRF500(LPCTSTR pClassName, LPCTSTR pTeacherName, long lMaxStudents, short nSessionType, BOOL bLoginFlag, BOOL bAutoLoginFlag, short nReanswerTimes)
	{
		long result;
		static BYTE parms[] = VTS_BSTR VTS_BSTR VTS_I4 VTS_I2 VTS_BOOL VTS_BOOL VTS_I2 ;
		InvokeHelper(0xf, DISPATCH_METHOD, VT_I4, (void*)&result, parms, pClassName, pTeacherName, lMaxStudents, nSessionType, bLoginFlag, bAutoLoginFlag, nReanswerTimes);
		return result;
	}
	long StartTestKeypad()
	{
		long result;
		InvokeHelper(0x10, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	long StopTestKeypad()
	{
		long result;
		InvokeHelper(0x11, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	void LanguageCodeChanged(LPCTSTR pLangPath, long lLangCode)
	{
		static BYTE parms[] = VTS_BSTR VTS_I4 ;
		InvokeHelper(0x12, DISPATCH_METHOD, VT_EMPTY, NULL, parms, pLangPath, lLangCode);
	}
	long AllowRush(long lDeviceNo)
	{
		long result;
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0x13, DISPATCH_METHOD, VT_I4, (void*)&result, parms, lDeviceNo);
		return result;
	}
	void SendStudentIDAndName(long lIndex, LPCTSTR pStudentID, LPCTSTR pStudentName)
	{
		static BYTE parms[] = VTS_I4 VTS_BSTR VTS_BSTR ;
		InvokeHelper(0x14, DISPATCH_METHOD, VT_EMPTY, NULL, parms, lIndex, pStudentID, pStudentName);
	}
	void SendLoginStudentStoreIndex(short nCurFrame, LPCTSTR pStortIndex, short nSize)
	{
		static BYTE parms[] = VTS_I2 VTS_BSTR VTS_I2 ;
		InvokeHelper(0x15, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nCurFrame, pStortIndex, nSize);
	}
	void SendQueStudentName(BOOL bComplete, LPCTSTR pStudentName)
	{
		static BYTE parms[] = VTS_BOOL VTS_BSTR ;
		InvokeHelper(0x16, DISPATCH_METHOD, VT_EMPTY, NULL, parms, bComplete, pStudentName);
	}
	void SendSutdentAnswerReslut(long lKeypadNO, long lQueNo, BOOL bCorrect, LPCTSTR pStudentAnswer)
	{
		static BYTE parms[] = VTS_I4 VTS_I4 VTS_BOOL VTS_BSTR ;
		InvokeHelper(0x17, DISPATCH_METHOD, VT_EMPTY, NULL, parms, lKeypadNO, lQueNo, bCorrect, pStudentAnswer);
	}
	void SendRushClassResult(BOOL bCorrect, long lParticipateNum, LPCTSTR pCorrectAnswer, LPCTSTR pStudentAnswer, LPCTSTR pStudentName)
	{
		static BYTE parms[] = VTS_BOOL VTS_I4 VTS_BSTR VTS_BSTR VTS_BSTR ;
		InvokeHelper(0x18, DISPATCH_METHOD, VT_EMPTY, NULL, parms, bCorrect, lParticipateNum, pCorrectAnswer, pStudentAnswer, pStudentName);
	}
	void SendClassReslut(short nQueType, LPCTSTR pCorrectAnswer, long lRightNum, LPCTSTR pStuNum, short nSize)
	{
		static BYTE parms[] = VTS_I2 VTS_BSTR VTS_I4 VTS_BSTR VTS_I2 ;
		InvokeHelper(0x19, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nQueType, pCorrectAnswer, lRightNum, pStuNum, nSize);
	}
	void SendKeypadTestIndex(long nDeviceNO, long nRegisterID, LPCTSTR strStuID)
	{
		static BYTE parms[] = VTS_I4 VTS_I4 VTS_BSTR ;
		InvokeHelper(0x1a, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nDeviceNO, nRegisterID, strStuID);
	}
	void SendLoginStudentStoreIndexEnd(long nLoginStudentNum)
	{
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0x1b, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nLoginStudentNum);
	}
	void AllowTeacherLogin(long nLoginStudentNum)
	{
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0x1c, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nLoginStudentNum);
	}
	void SendLoginStudengNum(long nLoginStudentNum)
	{
		static BYTE parms[] = VTS_I4 ;
		InvokeHelper(0x1d, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nLoginStudentNum);
	}
	void SendReportAnswerEnd()
	{
		InvokeHelper(0x1e, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
	}
	void SendPaperInfo(short nQuestionNum, short nPaperID, BOOL bAnswerFlag, LPCTSTR pPaperName)
	{
		static BYTE parms[] = VTS_I2 VTS_I2 VTS_BOOL VTS_BSTR ;
		InvokeHelper(0x1f, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nQuestionNum, nPaperID, bAnswerFlag, pPaperName);
	}
	void SendQuestionInfo(short nQuestionNo, short nQuestionType, short nOptionNum, short nQueMode, LPCTSTR pCorrectAnswer)
	{
		static BYTE parms[] = VTS_I2 VTS_I2 VTS_I2 VTS_I2 VTS_BSTR ;
		InvokeHelper(0x20, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nQuestionNo, nQuestionType, nOptionNum, nQueMode, pCorrectAnswer);
	}
	void SendQuestionContentInfo(short nQuestionNo, short nOptionNum, LPCTSTR pQuestionContentInfo)
	{
		static BYTE parms[] = VTS_I2 VTS_I2 VTS_BSTR ;
		InvokeHelper(0x21, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nQuestionNo, nOptionNum, pQuestionContentInfo);
	}
	void SendOffsiteCmdReceived(short nCmd, short nIndex)
	{
		static BYTE parms[] = VTS_I2 VTS_I2 ;
		InvokeHelper(0x22, DISPATCH_METHOD, VT_EMPTY, NULL, parms, nCmd, nIndex);
	}
	long StartUploadSession()
	{
		long result;
		InvokeHelper(0x23, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	long StopUploadSession()
	{
		long result;
		InvokeHelper(0x24, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
		return result;
	}
	void AboutBox()
	{
		InvokeHelper(DISPID_ABOUTBOX, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
	}

// Properties
//



};
