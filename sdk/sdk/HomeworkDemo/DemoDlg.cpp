// DemoDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Demo.h"
#include "DemoDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDemoDlg dialog

CDemoDlg::CDemoDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDemoDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDemoDlg)
	m_ClassName = _T("");
	m_MaxStudent = 0;
	m_TeacherName = _T("");
	m_QuestionInfo = _T("");
	m_MsgBox = _T("");
	m_CorrectAnswer = _T("");
	m_nExamID = 0;
	m_ExamTitle = _T("");
	m_nPaperOption = 0;
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CDemoDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDemoDlg)
	DDX_Control(pDX, IDC_EDIT_REANSWER_TIMES, m_EditReanswerTimes);
	DDX_Control(pDX, IDC_CHECK_RANDOM_PAPER, m_RandomPaper);
	DDX_Control(pDX, IDC_CHECK_AutoLogin, m_AutoLoginFlag);
	DDX_Control(pDX, IDC_CHECK_PaperSendQuestion, m_PaperSendQuestionFlag);
	DDX_Control(pDX, IDC_MODEL, m_Model);
	DDX_Control(pDX, IDC_VERSION, m_Version);
	DDX_Control(pDX, IDC_LIST_STUDENT, m_ListStudent);
	DDX_Control(pDX, IDC_LOGIN_FLAG, m_LoginFlag);
	DDX_Control(pDX, IDC_SEND_QUESTION_FLAG, m_SendQuestionFlag);
	DDX_Control(pDX, IDC_OPTION_NUM, m_OptionNum);
	DDX_Control(pDX, IDC_QUESTION_TYPE, m_QuestionType);
	DDX_Control(pDX, IDC_QUESTION_NUM, m_QuestionNum);
	DDX_Control(pDX, IDC_SESSION_TYPE, m_SessionType);
	DDX_Control(pDX, IDC_CHANNEL_NUM, m_ChannelNum);
	DDX_Text(pDX, IDC_CLASS, m_ClassName);
	DDX_Text(pDX, IDC_MAXSTUDENT, m_MaxStudent);
	DDV_MinMaxUInt(pDX, m_MaxStudent, 0, 999);
	DDX_Text(pDX, IDC_TEACHER, m_TeacherName);
	DDX_Text(pDX, IDC_QUESTION_INFO, m_QuestionInfo);
	DDX_Text(pDX, IDC_EDIT5, m_MsgBox);
	DDX_Text(pDX, IDC_CORRECT_ANSWER, m_CorrectAnswer);
	DDX_Control(pDX, IDC_QCLICKCTRL1, m_QClickControl);
	DDX_Text(pDX, IDC_EDIT_ExamTitleID, m_nExamID);
	DDX_Text(pDX, IDC_EDIT_ExamTitle, m_ExamTitle);
	DDX_Text(pDX, IDC_EDIT_PaperOption, m_nPaperOption);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDemoDlg, CDialog)
	//{{AFX_MSG_MAP(CDemoDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_INIT, OnInit)
	ON_BN_CLICKED(IDC_START_SESSION, OnStartSession)
	ON_BN_CLICKED(IDC_STOP_SESSION, OnStopSession)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_START_QUESTION, OnStartQuestion)
	ON_BN_CLICKED(IDC_STOP_QUESTION, OnStopQuestion)
	ON_BN_CLICKED(IDC_SET_CHANNEL, OnSetChannel)
	ON_BN_CLICKED(IDC_BUTTON_SetTitle, OnBUTTONSetTitle)
	ON_BN_CLICKED(IDC_BUTTON_PAPER_SETQUESTION, OnButtonPaperSetquestion)
	ON_BN_CLICKED(IDC_BUTTON_SENDQUESTION, OnButtonSendquestion)
	ON_CBN_SELCHANGE(IDC_SESSION_TYPE, OnSelchangeSessionType)
	ON_BN_CLICKED(IDC_BUTTON_KEYPAD, OnButtonKeypad)
	ON_BN_CLICKED(IDC_BUTTON_TEST, OnButtonTest)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDemoDlg message handlers

BOOL CDemoDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	//init list student
	m_ListStudent.InsertColumn(COLUMN_DEVICE_NUMBER,"DeviceID");
	m_ListStudent.InsertColumn(COLUMN_STUDENT_ID,"StudentID");
	m_ListStudent.InsertColumn(COLUMN_ANSWER,"StudentAnswer");
	m_ListStudent.InsertColumn(COLUMN_LOGIN_FLAG,"LoginFlag");
	m_ListStudent.SetColumnWidth(COLUMN_DEVICE_NUMBER,60);
	m_ListStudent.SetColumnWidth(COLUMN_STUDENT_ID,100);
	m_ListStudent.SetColumnWidth(COLUMN_ANSWER,100);
	m_ListStudent.SetColumnWidth(COLUMN_LOGIN_FLAG,50);

	//init dialog control
	InitDeviceInfo();
	InitExamTitleInfo();
	InitSessionInfo();
	InitQuestionInfo();
	InitListStudent();
	SetHomeworkMode(FALSE);
	GetDlgItem(IDC_BUTTON_KEYPAD)->EnableWindow(FALSE);
	m_bStartTestFlag = FALSE;
	m_EditReanswerTimes.SetWindowText(_T("-1"));
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CDemoDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CDemoDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CDemoDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

void CDemoDlg::OnOK() 
{
	// TODO: Add extra validation here
	
	CDialog::OnOK();
}


//////////////////////////////////////////////////////////////////////////////////////////

void CDemoDlg::InitDeviceInfo()
{
	UpdateData(TRUE);
	CString strChannelNum;
	m_Model.SetWindowText("No Host");
	m_Version.SetWindowText("");
	for(int i=0;i<=40;i++)
	{
		strChannelNum.Format("%d",i);
		m_ChannelNum.AddString(strChannelNum);
	}

	//////////////////////////////////////////////////////////////////////////
	// yxx 2011.12.27 Test Device No.
	CString strDeviceNo;
	for (i=995; i<1000; i++)
	{
		strDeviceNo.Format(_T("%d"), i);
		m_ChannelNum.AddString(strDeviceNo);
	}
	//////////////////////////////////////////////////////////////////////////

	m_ChannelNum.SetCurSel(0);
	UpdateData(FALSE);
}
//Init Exam Title,use in paper quiz or homework mode
void CDemoDlg::InitExamTitleInfo()
{
	UpdateData(TRUE);
	m_ExamTitle = "Exam Title";
	m_nPaperOption = 10;
	m_nExamID = 1;
	UpdateData(FALSE);
}

void CDemoDlg::InitSessionInfo()
{
	UpdateData(TRUE);
	m_ClassName="Class Name";
	m_TeacherName="Teacher Name";
	m_MaxStudent=100;
	m_SessionType.AddString("Normal Quiz");
	m_SessionType.AddString("Rush Quiz");
	m_SessionType.AddString("Elimination");
	m_SessionType.AddString("Survey");
	m_SessionType.AddString("Vote");
	m_SessionType.AddString("Paper Quiz");
	m_SessionType.AddString("HomeWork");
	m_SessionType.SetCurSel(0);
	UpdateData(FALSE);
}

void CDemoDlg::InitQuestionInfo()
{
	UpdateData(TRUE);
	CString strTemp;
	int i=0;
	m_QuestionInfo="Question Information";

	m_QuestionType.AddString("Single Choice");
	m_QuestionType.AddString("Multiple Choice");
	m_QuestionType.AddString("Cloze Test");
	m_QuestionType.AddString("True/False");
	m_QuestionType.SetCurSel(0);

	for(i=2; i<=10; i++)
	{
		strTemp.Format("%d",i);
		m_OptionNum.AddString(strTemp);
	}
	m_OptionNum.SetCurSel(2);
	
	for(i=1; i<=99; i++)
	{
		strTemp.Format("%d",i);
		m_QuestionNum.AddString(strTemp);
	}
	m_QuestionNum.SetCurSel(0);
	UpdateData(FALSE);
}

void CDemoDlg::InitListStudent()
{
	CString strTemp;
	m_ListStudent.DeleteAllItems();	
	for(int i=0; i<10; i++)
	{
		strTemp.Format("%d",i+1);
		m_ListStudent.InsertItem(i,"1");
		m_ListStudent.SetItemText(i,COLUMN_DEVICE_NUMBER,"NULL");
		m_ListStudent.SetItemText(i,COLUMN_STUDENT_ID,strTemp);
		m_ListStudent.SetItemText(i,COLUMN_ANSWER,"");
		m_ListStudent.SetItemText(i,COLUMN_LOGIN_FLAG,"");
	}

	m_ListStudent.InsertItem(10,"1");
	m_ListStudent.SetItemText(10,COLUMN_DEVICE_NUMBER,"NULL");
	m_ListStudent.SetItemText(10,COLUMN_STUDENT_ID,_T("Teacher"));
	m_ListStudent.SetItemText(10,COLUMN_ANSWER,"");
	m_ListStudent.SetItemText(10,COLUMN_LOGIN_FLAG,"");

	//////////////////////////////////////////////////////////////////////////
	// yxx 2011.12.27 Test Device No.
	i=11;
	for (int j=995; j<1000; j++, i++)
	{
		strTemp.Format("%d",j);
		m_ListStudent.InsertItem(i,"1");
		m_ListStudent.SetItemText(i,COLUMN_DEVICE_NUMBER,"NULL");
		m_ListStudent.SetItemText(i,COLUMN_STUDENT_ID,strTemp);
		m_ListStudent.SetItemText(i,COLUMN_ANSWER,"");
		m_ListStudent.SetItemText(i,COLUMN_LOGIN_FLAG,"");
	}
	//////////////////////////////////////////////////////////////////////////

	UpdateData(FALSE);

}

void CDemoDlg::SetHomeworkMode(BOOL bFlag)
{
	GetDlgItem(IDC_EDIT_ExamTitleID)->EnableWindow(bFlag);
	GetDlgItem(IDC_EDIT_ExamTitle)->EnableWindow(bFlag);
	GetDlgItem(IDC_EDIT_PaperOption)->EnableWindow(bFlag);
	GetDlgItem(IDC_CHECK_PaperSendQuestion)->EnableWindow(bFlag);
	GetDlgItem(IDC_BUTTON_SetTitle)->EnableWindow(bFlag);
	GetDlgItem(IDC_BUTTON_PAPER_SETQUESTION)->EnableWindow(bFlag);
	GetDlgItem(IDC_BUTTON_SENDQUESTION)->EnableWindow(bFlag);
}

void CDemoDlg::OnSelchangeSessionType() 
{
	// TODO: Add your control notification handler code here
	if(m_SessionType.GetCurSel() == PAPER_QUIZ || m_SessionType.GetCurSel() == HOMEWORK)
	{
		SetHomeworkMode(TRUE);
	}
	else
	{
		SetHomeworkMode(FALSE);
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////


void CDemoDlg::OnInit() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	int nChannelNum=0;
	CString strModel="";
	CString strVersionInfo="";
	int nInitFlag = m_QClickControl.InitHost();
	if(1 == nInitFlag)
	{		
		nChannelNum = atoi(m_QClickControl.GetHostInfo(0));
		strModel = m_QClickControl.GetHostInfo(1);
		strVersionInfo = m_QClickControl.GetHostInfo(2);
		
		m_ChannelNum.SetCurSel(nChannelNum);
		m_Model.SetWindowText(strModel);
		m_Version.SetWindowText(strVersionInfo);
		m_MsgBox = "Initialize successfully!";

		if (0 == strModel.CompareNoCase(_T("QRF300")) ||
			0 == strModel.CompareNoCase(_T("QRF500")))
		{
			GetDlgItem(IDC_BUTTON_KEYPAD)->EnableWindow(TRUE);
		}
		else
		{
			GetDlgItem(IDC_BUTTON_KEYPAD)->EnableWindow(FALSE);
		}
	}
	else
	{
		m_MsgBox = "Initialize failed!";
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnStartSession() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	long lMsgFlag;
	CString strClassName = m_ClassName;
	CString strTeacherName = m_TeacherName;
	int nNumberOfStudent = m_MaxStudent;
	int nSessionType = m_SessionType.GetCurSel();
	int nLoginFlag = m_LoginFlag.GetCheck();
	int nAutoLoginFlag = m_AutoLoginFlag.GetCheck();
	CString strModel;
	m_Model.GetWindowText(strModel);
	if (0 == strModel.CompareNoCase(_T("QRF500")))
	{
		lMsgFlag = m_QClickControl.StartSessionRF500(strClassName,strTeacherName,nNumberOfStudent,nSessionType,nLoginFlag, nAutoLoginFlag, 0);
	}
	else
	{
		lMsgFlag = m_QClickControl.StartSession(strClassName,strTeacherName,nNumberOfStudent,nSessionType,nLoginFlag, nAutoLoginFlag);
	}
	switch(lMsgFlag)
	{
	case 0:
		m_MsgBox = "Session start successfully!";
		break;
	case 1:
		m_MsgBox = "Session start failed! Please init first!";
		break;
	case 2:
		m_MsgBox = "Session start failed! Please Stop session first!";
		break;
	case 3:
		m_MsgBox = "Session start failed! Please Set Exam Title first in PaperQuiz or Homework!";
		break;
	default:break;
	}
	
	InitListStudent();
	UpdateData(FALSE);
}

void CDemoDlg::OnStopSession() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	long lMsgFlag;
	lMsgFlag = m_QClickControl.StopSession();
	switch(lMsgFlag)
	{
	case 0:
		m_MsgBox = "Session Stoped successfully";
		break;
	case 1:
		m_MsgBox = "Session Stoped failed! Please init first!";
		break;
	case 2:
		m_MsgBox = "Session Stoped failed! Please start session first!";
		break;
	default:break;
	}
	
	UpdateData(FALSE);
}



void CDemoDlg::OnStartQuestion() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	long lMsgFlag;
	int nQuestionNum = m_QuestionNum.GetCurSel()+1;
	int nQuestionType = m_QuestionType.GetCurSel();
	int nOptionNum = m_OptionNum.GetCurSel()+2;
	CString strQuestionInfo = m_QuestionInfo;
	int nSendQuestionFlag = m_SendQuestionFlag.GetCheck();
	CString strCorrectAnswer = m_CorrectAnswer;
	int nQuestionSessionType = 0;

	CString strReanswerTimes;
	m_EditReanswerTimes.GetWindowText(strReanswerTimes);
	int nReanswerTimes = _ttoi(strReanswerTimes);
	if (strReanswerTimes.IsEmpty())
	{
		nReanswerTimes = -1;
	}
	lMsgFlag = m_QClickControl.StartQuestion(nQuestionNum,nQuestionType,nOptionNum,nSendQuestionFlag,strQuestionInfo,strCorrectAnswer,nQuestionSessionType, nReanswerTimes);
	switch(lMsgFlag)
	{
	case 0:
		m_MsgBox = "Question start successfully!";
		break;
	case 1:
		m_MsgBox = "Question start failed! Please init first!";
		break;
	case 2:
		m_MsgBox = "Question start failed! Please start session first!";
		break;
	case 3:
		m_MsgBox = "Question start failed! Please stop question first!";
		break;
	default:break;
	}

	UpdateData(FALSE);
}

void CDemoDlg::OnStopQuestion() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	long lMsgFlag;
	lMsgFlag = m_QClickControl.StopQuestion();

	int nQuestionNum = m_QuestionNum.GetCurSel()+1;
	if(nQuestionNum>99)
	{
		nQuestionNum = 1;
	}
	m_QuestionNum.SetCurSel(nQuestionNum);
	switch(lMsgFlag)
	{
	case 0:
		m_MsgBox = "Question stoped successfully!";
		break;
	case 1:
		m_MsgBox = "Question stoped failed! Please init first!";
		break;
	case 2:
		m_MsgBox = "Question stoped failed! Please start session first!";
		break;
	case 3:
		m_MsgBox = "Question stoped failed! Please start question first!";
		break;
	default:break;
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnBUTTONSetTitle() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	int nExamID = m_nExamID;
	CString strExamTitle = m_ExamTitle;
	int nOption = m_nPaperOption;
	int nSendFlag = m_PaperSendQuestionFlag.GetCheck();
	BOOL bRandomPaper = m_RandomPaper.GetCheck();
	if (m_QClickControl.HomeworkSetExamTitle(nExamID, strExamTitle, nOption, bRandomPaper))
	{
		m_MsgBox = "Set Exam Title failed! Please init first!";
	}
	else
	{
		m_MsgBox = "Set Exam Title Sucess!";
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnButtonPaperSetquestion() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	int nQuestionNum = m_QuestionNum.GetCurSel()+1;
	int nQuestionType = m_QuestionType.GetCurSel();
	int nOptionNum = m_OptionNum.GetCurSel()+2;
	CString strQuestionInfo = m_QuestionInfo;
	int nSendQuestionFlag = m_SendQuestionFlag.GetCheck();
	CString strCorrectAnswer = m_CorrectAnswer;
	
	long lReturn = m_QClickControl.HomeworkSetQuestionInfo(nQuestionNum, nQuestionType, strQuestionInfo, strCorrectAnswer);
	switch (lReturn)
	{
	case 0:
		m_MsgBox = "Set Exam Question Information Sucess!";
		break;
	case 1:
		m_MsgBox = "Set Exam Question Information failed! Please init first!";
		break;
	case 2:
		m_MsgBox = "Set Exam Question Information failed! Please Set Exam Title first!";
		break;
	default:
		break;
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnButtonSendquestion() 
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	int nResturn  = m_QClickControl.HomeworkSendExamInfo();
	switch (nResturn)
	{
	case 0:
		m_MsgBox = "Send Question Information Sucess!";
		break;
	case 1:
		m_MsgBox = "Send Question Information failed! Please Set Question Info first!";
		break;
	case 2:
		m_MsgBox = "Send Question Information failed! Please Start Session first!";
		break;
	default:
		break;
	}
	UpdateData(FALSE);
}


void CDemoDlg::OnSetChannel() 
{
	// TODO: Add your control notification handler code here
	if(m_QClickControl.SetHostChannel(m_ChannelNum.GetCurSel()))
	{
		m_MsgBox = "Set channel faild!";
	}
	else
	{
		m_MsgBox = "Set channel successfully!";
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnClose() 
{
	// TODO: Add your message handler code here and/or call default
	m_QClickControl.CloseHost();
	CDialog::OnClose();
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
BEGIN_EVENTSINK_MAP(CDemoDlg, CDialog)
//{{AFX_EVENTSINK_MAP(CDemoDlg)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 3 /* OnAnswerReceived */, OnAnswerReceivedQclickctrl1, VTS_I4 VTS_BSTR VTS_BSTR VTS_I2)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 2 /* OnKeypadLogin */, OnKeypadLoginQclickctrl1, VTS_I4 VTS_I4 VTS_BSTR VTS_BSTR)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 5 /* OnKeypadLogout */, OnKeypadLogoutQclickctrl1, VTS_I4 VTS_BSTR)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 4 /* OnControlerReceived */, OnControlerReceivedQclickctrl1, VTS_I2)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 1 /* OnDeviceChanged */, OnDeviceChangedQclickctrl1, VTS_I2 VTS_BSTR VTS_BSTR)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 6/* OnHomeworkAnswerReceived */, OnHomeworkAnswerReceivedQclickctrl1, VTS_I4 VTS_BSTR)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 7/* OnHomeworkAskForQuestions */, OnHomeworkAskForQuestionsQclickctrl1, VTS_I4  VTS_BSTR)
	ON_EVENT(CDemoDlg, IDC_QCLICKCTRL1, 8 /* OnQueNOChanged */, OnQueNOChangedQclickctrl1, VTS_I4 VTS_I2)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

void CDemoDlg::OnAnswerReceivedQclickctrl1(long lKeypadNO, LPCTSTR pStudentID, LPCTSTR pAnswer, short nReceivedType) 
{
	// TODO: Add your control notification handler code here
	int nRow;
	CString strAnswerData = pAnswer;
	CString strStudentID = pStudentID;
	CString strKeypadNumber;
	strKeypadNumber.Format("%d",lKeypadNO);
	
	switch (nReceivedType)
	{
	case 1:
		strAnswerData = _T("RUSH");
		break;
	case 2:
		strAnswerData = _T("Ask Question");
		break;
	case 3:
		{
			strAnswerData.Format(_T("Test: %s"), pAnswer);
		}
		break;
	default:
		break;
	}
	
	nRow = GetRowInList(strStudentID);
	if(nRow >= 0)
	{
// 		m_ListStudent.SetItemText(nLine,COLUMN_DEVICE_NUMBER,strKeypadNumber);
// 		m_ListStudent.SetItemText(nLine,COLUMN_STUDENT_ID,strStudentID);
// 		m_ListStudent.SetItemText(nLine,COLUMN_ANSWER,strAnswerData);
// 		m_ListStudent.SetItemText(nLine,COLUMN_LOGIN_FLAG,"Login");
// 		m_ListStudent.Update(nLine);
		SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,strAnswerData,"Login");
	}
}

void CDemoDlg::OnKeypadLoginQclickctrl1(long lSerialNO, long lKeypadNO, LPCTSTR pStudentID, LPCTSTR pStudentName) 
{
	// TODO: Add your control notification handler code here
	int nRow;
	CString strStudentID = pStudentID;
	CString strKeypadNumber;	
	strKeypadNumber.Format("%d",lKeypadNO);
	if(TEACHER_DEVICE_NUMBER == lKeypadNO)
	{
		strStudentID = STRING_TEACHER_LOGIN_FLAG;
	}
	if(m_LoginFlag.GetCheck())//LoginFlag = TRUE
	{
		if(TEACHER_DEVICE_NUMBER == lKeypadNO) //Teacher keypad ,login allow
		{
			nRow = m_ListStudent.GetItemCount();
			m_ListStudent.InsertItem(nRow,strKeypadNumber);
			
			SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,"","Login");
		}
		else	//Student keypad, Check whether the student is in the selected class
		{
			nRow = GetRowInList(strStudentID);
			if(nRow >= 0) //Login allow,student in this class
			{		
				m_QClickControl.AllowLogin(lSerialNO, pStudentID, TRUE, FALSE, _T(""));

				SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,"","Login");
			}
			else	//Login denied
			{
				m_QClickControl.AllowLogin(lSerialNO, pStudentID, FALSE, FALSE, _T(""));	
			}
		}
		
	}
	else //LoginFlag = FALSE ,login allow
	{
		nRow = GetRowInList(strStudentID);
		if(nRow < 0) //the student is not in m_ListStudent
		{
			nRow = m_ListStudent.GetItemCount();
			m_ListStudent.InsertItem(nRow,strKeypadNumber);
		}
		
		SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,"","Login");
	}
}

void CDemoDlg::OnKeypadLogoutQclickctrl1(long lKeypadNO, LPCTSTR pStudentID) 
{
	// TODO: Add your control notification handler code here
	int nRow;
	CString strStudentID = pStudentID;

	nRow = GetRowInList(strStudentID);
	if(nRow>=0)//studentID in m_ListStudent
	{
		m_ListStudent.SetItemText(nRow,COLUMN_LOGIN_FLAG,"Logout");
		m_ListStudent.Update(nRow);
	}
}

void CDemoDlg::OnControlerReceivedQclickctrl1(short nCmd) 
{
	// TODO: Add your control notification handler code here
	int nRow;
	CString strStudentID = STRING_TEACHER_LOGIN_FLAG;
	CString strKeypadNumber = "0";
	CString strCmdData;
	switch(nCmd)
	{
	case KEY_F1:
		strCmdData = "F1";
		break;
	case KEY_F2:
		strCmdData = "F2";
		break;
	case KEY_OK:
		strCmdData = "OK";
		break;
	case KEY_PREVIOUS:
		strCmdData = "Previous";
		break;
	case KEY_NEXT:
		strCmdData = "Next";
		break;
	case KEY_START_QUESTION:
		strCmdData = "Start Question";
		break;
	case KEY_STOP_QUESTION:
		strCmdData = "Stop Question";
		break;
	case KEY_RESULT:
		strCmdData = "Result";
		break;
	case KEY_REPORT:
		strCmdData = "Report";
		break;
	case KEY_EXTI:
		strCmdData = "Exit";
		break;
	default:break;
	}
	nRow = GetRowInList(strStudentID);
	if(nRow < 0)
	{
		nRow = m_ListStudent.GetItemCount();
		m_ListStudent.InsertItem(nRow,strKeypadNumber);
	}
	
	SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,strCmdData,"Login");
}

void CDemoDlg::OnDeviceChangedQclickctrl1(short nHostModel,LPCTSTR pChannelNO, LPCTSTR pHostVersion) 
{
	// TODO: Add your control notification handler code here
	CString strHostModel;
	int nChannelNum;
	CString strVersionInfo;
	switch(nHostModel)
	{
	case MODEL_NO_HOST:
		strHostModel = "No Host";
		break;
	case MODEL_QRF900:
		strHostModel = "QRF900";
		break;
	case MODEL_QRF700:
		strHostModel = "QRF700";
		break;
	case MODEL_QRF600:
		strHostModel = "QRF600";
		break;
	case MODEL_QRF500:
		strHostModel = "QRF500";
		break;
	case MODEL_QRF300:
		strHostModel = "QRF300";
		break;
	case MODEL_QIR300:
		strHostModel = "QIR300";
		break;
	default:
		strHostModel = "No Host";
		break;
	}

	nChannelNum = atoi(pChannelNO);
	strVersionInfo = pHostVersion;
	
	m_ChannelNum.SetCurSel(nChannelNum);
	m_Model.SetWindowText(strHostModel);	
	m_Version.SetWindowText(strVersionInfo);
}

void CDemoDlg::OnHomeworkAnswerReceivedQclickctrl1(long lKeyPadNO, LPCTSTR pStudentID)
{
	CString strAnswer="";
	CString strAllAnswer="";
	CString strQuestionNumber;
	CString strStudentID = pStudentID;
	CString strKeypadNumber;	
	strKeypadNumber.Format("%d",lKeyPadNO);

	int nRow = GetRowInList(strStudentID);
	if(nRow>=0)//Student in class
	{
		for (int i=0; i< m_nPaperOption; i++)
		{
			strAnswer = m_QClickControl.GetStudentAnswer(pStudentID, i+1);//
			strQuestionNumber.Format("%d",i+1);
			strAllAnswer = strAllAnswer+strQuestionNumber+':'+strAnswer+" | ";
		}
		SetStudentAnswerInfo(nRow,strKeypadNumber,strStudentID,strAllAnswer,"Login");//show student answers in listcontrol
	}
	
}

void CDemoDlg::OnHomeworkAskForQuestionsQclickctrl1(long lKeyPadNO, LPCTSTR pStudentID)
{
	CString strMsg;
	int nResturn  = m_QClickControl.HomeworkSendExamInfo();
	switch (nResturn)
	{
	case 0:
		strMsg = "Send Question Information Sucess!";
		break;
	case 1:
		strMsg = "Send Question Information failed! Please Set Question Info first!";
		break;
	case 2:
		strMsg = "Send Question Information failed! Please Start Session first!";
		break;
	default:
		break;
	}
	TRACE(_T("Ask For Question Result: %s\n"), strMsg);
}

void CDemoDlg::OnQueNOChangedQclickctrl1(long lKeypadNO, short nQueNO)
{
	CString strStudentID, strQueNO;
	strStudentID.Format(_T("%d"), lKeypadNO);
	strQueNO.Format(_T("Que NO. %d"), nQueNO);
	int nRow = GetRowInList(strStudentID);
	if (nRow >= 0)
	{
		SetStudentAnswerInfo(nRow, strStudentID, strStudentID, strQueNO, _T("Login"));
	}
}

//update student answer to listcontrol
void CDemoDlg::SetStudentAnswerInfo(int nRow,CString strKeypadNumber,CString strStudentID,CString strAllAnswer,CString strLoginFlag)
{
	m_ListStudent.SetItemText(nRow,COLUMN_DEVICE_NUMBER,strKeypadNumber);
	m_ListStudent.SetItemText(nRow,COLUMN_STUDENT_ID,strStudentID);
	m_ListStudent.SetItemText(nRow,COLUMN_ANSWER,strAllAnswer);
	m_ListStudent.SetItemText(nRow,COLUMN_LOGIN_FLAG,strLoginFlag);
	m_ListStudent.Update(nRow);
}


//get student Row in m_ListStudent,
//if the student is not in m_ListStudent return -1
int CDemoDlg:: GetRowInList(CString strStudentID)
{
	int nRowNumber = -1;
	for(int j=0;j<m_ListStudent.GetItemCount();j++)
	{
		if(0 == strStudentID.CompareNoCase(m_ListStudent.GetItemText(j,COLUMN_STUDENT_ID)))
		{
			nRowNumber = j;
			break;
		}
	}
	return nRowNumber;
}

void CDemoDlg::OnButtonKeypad() 
{
	// TODO: Add your control notification handler code here
	CString strKeypadNo = _T("");
	int nCurSel = m_ChannelNum.GetCurSel();
	if (-1 != nCurSel)
	{
		m_ChannelNum.GetLBText(nCurSel, strKeypadNo);
	}

	if(m_QClickControl.SetKeypadNO(_ttoi(strKeypadNo)))
	{
		m_MsgBox = "Set Keypad faild!";
	}
	else
	{
		m_MsgBox = "Set Keypad successfully!";
	}
	UpdateData(FALSE);
}

void CDemoDlg::OnButtonTest() 
{
	// TODO: Add your control notification handler code here
	m_bStartTestFlag = !m_bStartTestFlag;
	if (m_bStartTestFlag)
	{
		int nRet = m_QClickControl.StartTestKeypad();
		if (0 == nRet)
		{
			GetDlgItem(IDC_BUTTON_TEST)->SetWindowText(_T("Stop Test"));
			m_MsgBox = _T("Start Test Keypad");
		}
		else if (1 == nRet)
		{
			m_MsgBox = _T("Firt Init host");
		}
		else
		{
			m_MsgBox = _T("Not Support this Method");
		}
	}
	else
	{
		m_QClickControl.StopTestKeypad();
		GetDlgItem(IDC_BUTTON_TEST)->SetWindowText(_T("Start Test"));
	}
}
