// DemoDlg.h : header file
//
//{{AFX_INCLUDES()
#include "qclick.h"
//}}AFX_INCLUDES
#if !defined(AFX_DEMODLG_H__303007AE_762D_4913_AE4E_6FBAAE3A5163__INCLUDED_)
#define AFX_DEMODLG_H__303007AE_762D_4913_AE4E_6FBAAE3A5163__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

enum CONTROLER_CMD
{
	KEY_NULL = 0,
	KEY_F1,
	KEY_F2,
	KEY_OK,
	KEY_PREVIOUS,
	KEY_NEXT,
	KEY_START_QUESTION,
	KEY_STOP_QUESTION,
	KEY_RESULT,
	KEY_REPORT,
	KEY_EXTI
};
enum HOST_MODEL
{
	MODEL_NO_HOST = 0,
	MODEL_QRF900,
	MODEL_QRF700,
	MODEL_QRF600,
	MODEL_QRF500,
	MODEL_QRF300,
	MODEL_QIR300
};
enum SESSION_TYPE
{
	NORMAL_QUIZ = 0,
	RUSH_QUIZ,
	ELIMAINATION,
	SURVEY,
	VOTE,
	PAPER_QUIZ,
	HOMEWORK
};

#define TEACHER_DEVICE_NUMBER 0
#define STRING_TEACHER_LOGIN_FLAG "Teacher"


#define COLUMN_DEVICE_NUMBER 0
#define COLUMN_STUDENT_ID	1
#define COLUMN_ANSWER		2
#define COLUMN_LOGIN_FLAG	3


/////////////////////////////////////////////////////////////////////////////
// CDemoDlg dialog

class CDemoDlg : public CDialog
{
// Construction
public:
	void InitListStudent();
	void InitQuestionInfo();
	void InitExamTitleInfo();
	void InitSessionInfo();
	void InitDeviceInfo();
	void SetHomeworkMode(BOOL bFlag);
	void SetStudentAnswerInfo(int nRow,CString strKeypadNumber,CString strStudentID,CString strAllAnswer,CString strLoginFlag);
	int GetRowInList(CString strStudentID);
	CDemoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CDemoDlg)
	enum { IDD = IDD_DEMO_DIALOG };
	CEdit	m_EditReanswerTimes;
	CButton	m_RandomPaper;
	CButton	m_AutoLoginFlag;
	CButton	m_PaperSendQuestionFlag;
	CEdit	m_Model;
	CEdit	m_Version;
	CListCtrl	m_ListStudent;
	CButton	m_LoginFlag;
	CButton	m_SendQuestionFlag;
	CComboBox	m_OptionNum;
	CComboBox	m_QuestionType;
	CComboBox	m_QuestionNum;
	CComboBox	m_SessionType;
	CComboBox	m_ChannelNum;
	CString	m_ClassName;
	UINT	m_MaxStudent;
	CString	m_TeacherName;
	CString	m_QuestionInfo;
	CString	m_MsgBox;
	CString	m_CorrectAnswer;
	CQClick	m_QClickControl;
	UINT	m_nExamID;
	CString	m_ExamTitle;
	UINT	m_nPaperOption;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDemoDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CDemoDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	afx_msg void OnInit();
	afx_msg void OnStartSession();
	afx_msg void OnStopSession();
	afx_msg void OnClose();
	afx_msg void OnStartQuestion();
	afx_msg void OnStopQuestion();
	afx_msg void OnSetChannel();
	afx_msg void OnAnswerReceivedQclickctrl1(long lKeypadNO, LPCTSTR pStudentID, LPCTSTR pAnswer, short nReceivedType);
	afx_msg void OnKeypadLoginQclickctrl1(long lSerialNO, long lKeypadNO, LPCTSTR pStudentID, LPCTSTR pStudentName);
	afx_msg void OnKeypadLogoutQclickctrl1(long lKeypadNO, LPCTSTR pStudentID);
	afx_msg void OnControlerReceivedQclickctrl1(short nCmd);
	afx_msg void OnDeviceChangedQclickctrl1(short nHostModel,LPCTSTR pChannelNO, LPCTSTR pHostVersion);
	afx_msg void OnHomeworkAnswerReceivedQclickctrl1(long lKeyPadNO, LPCTSTR pStudentID);
	afx_msg void OnHomeworkAskForQuestionsQclickctrl1(long lKeyPadNO, LPCTSTR pStudentID);
	afx_msg void OnQueNOChangedQclickctrl1(long lKeypadNO, short nQueNO);
	afx_msg void OnBUTTONSetTitle();
	afx_msg void OnButtonPaperSetquestion();
	afx_msg void OnButtonSendquestion();
	afx_msg void OnSelchangeSessionType();
	afx_msg void OnButtonKeypad();
	afx_msg void OnButtonTest();
	DECLARE_EVENTSINK_MAP()
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()

private:
	BOOL m_bStartTestFlag;
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEMODLG_H__303007AE_762D_4913_AE4E_6FBAAE3A5163__INCLUDED_)
