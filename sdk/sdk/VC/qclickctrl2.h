#pragma once

// ������������� Microsoft Visual C++ ������ IDispatch ��װ��

// ע��: ��Ҫ�޸Ĵ��ļ������ݡ����������
//  Microsoft Visual C++ �������ɣ������޸Ľ������ǡ�

/////////////////////////////////////////////////////////////////////////////
// CQclickctrl2 ��װ��

class CQclickctrl2 : public CWnd
{
protected:
	DECLARE_DYNCREATE(CQclickctrl2)
public:
	CLSID const& GetClsid()
	{
		static CLSID const clsid
			= { 0xBD6A45F7, 0xF9A6, 0x4A94, { 0x9A, 0x9E, 0x61, 0x92, 0x48, 0xD7, 0x83, 0x81 } };
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

// ����
public:


// ����
public:
	BOOL InitHost();
	CString GetHostInfo(long lFlag);
	long SetHostChannel(short nChannelNo);
	long StartSession(LPCTSTR pClassName, LPCTSTR pTeacherName, long lMaxStudents, short nSessionType, BOOL bLoginFlag, BOOL bAutoLoginFlag);
	long StartQuestion(short nQuestionNo, short nQuestionType, short nNumberOfOption, BOOL bIsSendQuestion, LPCTSTR pQuestionInfo, LPCTSTR pCorrectAnswer, short nQuestionSessionType);
	long StopQuestion();
	long StopSession();
	BOOL AllowLogin(LPCTSTR pStudentID, BOOL bAllowLogin, BOOL bIsSendStudentName, LPCTSTR pStudentName);
	BOOL CloseHost();
	long SetKeypadNO(long lKeypadNO);
	long HomeworkSetExamTitle(short nExamID, LPCTSTR pExamTitle, short nQuestionNum);
	long HomeworkSetQuestionInfo(short nQuestionNo, short nQuestionType, LPCTSTR pQuestionInfo, LPCTSTR pAnswer);
	CString GetStudentAnswer(LPCTSTR pStudentID, short nQuestionNo);
	long HomeworkSendExamInfo();
	void AboutBox();


};
