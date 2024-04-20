// DemoDlg.h : header file
//
//{{AFX_INCLUDES()
#include "qclick.h"
#include "qclickv2ctrl1.h"
#include "qclickctrl2.h"
//}}AFX_INCLUDES

#if !defined(AFX_DEMODLG_H__CF1469EA_0F83_4B25_9E5B_0FC31018A910__INCLUDED_)
#define AFX_DEMODLG_H__CF1469EA_0F83_4B25_9E5B_0FC31018A910__INCLUDED_

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
	KEY_EXTI,
	KEY_RUN
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
#define TEACHER_DEVICE_NUMBER 0



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
	void InitSessionInfo();
	void InitDeviceInfo();
	CDemoDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CDemoDlg)
	enum { IDD = IDD_DEMO_DIALOG };
	CButton	m_SetKeypadNo;
	CComboBox	m_KeypadNumber;
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
	afx_msg void OnKeypadLoginQclickctrl1(long lKeypadNO, LPCTSTR pStudentID);
	afx_msg void OnKeypadLogoutQclickctrl1(long lKeypadNO, LPCTSTR pStudentID);
	afx_msg void OnControlerReceivedQclickctrl1(short nCmd);
	afx_msg void OnDeviceChangedQclickctrl1(short nHostModel,LPCTSTR pChannelNO, LPCTSTR pHostVersion);
	afx_msg void OnSetKeypadNo();
	DECLARE_EVENTSINK_MAP()
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_DEMODLG_H__CF1469EA_0F83_4B25_9E5B_0FC31018A910__INCLUDED_)
