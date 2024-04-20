VERSION 5.00
Object = "{307F130D-5BDD-496D-9B64-2D35E0BF71C2}#1.0#0"; "QClick.ocx"
Begin VB.Form frmMain 
   Caption         =   "QClickSDK Demo"
   ClientHeight    =   6195
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11850
   LinkTopic       =   "Form1"
   ScaleHeight     =   6195
   ScaleWidth      =   11850
   StartUpPosition =   3  '´°¿ÚÈ±Ê¡
   Begin QCLICKLib.QClick QClick1 
      Left            =   5160
      Top             =   240
      _Version        =   65536
      _ExtentX        =   661
      _ExtentY        =   661
      _StockProps     =   0
   End
   Begin VB.Frame Frame4 
      Caption         =   "Event History"
      Height          =   6015
      Left            =   5760
      TabIndex        =   21
      Top             =   120
      Width           =   6015
      Begin VB.ListBox lstEvent 
         Height          =   5640
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   5775
      End
   End
   Begin VB.Frame vz 
      Caption         =   "3.Start/Stop Question"
      Height          =   2655
      Left            =   120
      TabIndex        =   20
      Top             =   3480
      Width           =   5535
      Begin VB.CheckBox cbSendQuestion 
         Caption         =   "Send question"
         Height          =   180
         Left            =   1080
         TabIndex        =   33
         Top             =   2280
         Width           =   1575
      End
      Begin VB.TextBox txtQuestion 
         Height          =   1335
         Left            =   1080
         MultiLine       =   -1  'True
         TabIndex        =   32
         Text            =   "Form1.frx":0000
         Top             =   720
         Width           =   4335
      End
      Begin VB.ComboBox cboOptions 
         Height          =   300
         Left            =   4680
         TabIndex        =   31
         Top             =   300
         Width           =   735
      End
      Begin VB.ComboBox cboQuestionType 
         Height          =   300
         ItemData        =   "Form1.frx":0027
         Left            =   2280
         List            =   "Form1.frx":0029
         TabIndex        =   30
         Top             =   300
         Width           =   1575
      End
      Begin VB.TextBox txtQuesNO 
         Height          =   270
         Left            =   1080
         TabIndex        =   29
         Text            =   "1"
         Top             =   315
         Width           =   615
      End
      Begin VB.CommandButton btnStopQuestion 
         Caption         =   "Stop"
         Height          =   375
         Left            =   4440
         TabIndex        =   25
         Top             =   2160
         Width           =   975
      End
      Begin VB.CommandButton btnStartQuestion 
         Caption         =   "Start"
         Height          =   375
         Left            =   3360
         TabIndex        =   23
         Top             =   2160
         Width           =   975
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Question:"
         Height          =   180
         Index           =   1
         Left            =   120
         TabIndex        =   34
         Top             =   720
         Width           =   810
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Options:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   3960
         TabIndex        =   28
         Top             =   360
         Width           =   720
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Type:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   1800
         TabIndex        =   27
         Top             =   360
         Width           =   450
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         Caption         =   "No:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   600
         TabIndex        =   26
         Top             =   360
         Width           =   270
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "2.Start/Stop Session"
      Height          =   1695
      Left            =   120
      TabIndex        =   8
      Top             =   1560
      Width           =   5535
      Begin VB.CommandButton btnStopSession 
         Caption         =   "Stop"
         Height          =   375
         Left            =   4440
         TabIndex        =   19
         Top             =   1140
         Width           =   975
      End
      Begin VB.CommandButton btnStartSession 
         Caption         =   "Start"
         Height          =   375
         Left            =   3360
         TabIndex        =   18
         Top             =   1140
         Width           =   975
      End
      Begin VB.CheckBox cbLogin 
         Caption         =   "Access Control"
         Height          =   255
         Left            =   960
         TabIndex        =   17
         Top             =   1200
         Width           =   1575
      End
      Begin VB.TextBox txtMaxStudent 
         Height          =   270
         Left            =   3960
         TabIndex        =   16
         Text            =   "30"
         Top             =   720
         Width           =   1455
      End
      Begin VB.ComboBox cboSessionType 
         Height          =   300
         Left            =   3960
         TabIndex        =   15
         Top             =   360
         Width           =   1455
      End
      Begin VB.TextBox txtTeacherName 
         Height          =   270
         Left            =   960
         TabIndex        =   14
         Text            =   "SDK Teacher"
         Top             =   720
         Width           =   1455
      End
      Begin VB.TextBox txtClassName 
         Height          =   270
         Left            =   960
         TabIndex        =   13
         Text            =   "SDK Class"
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Max Student:"
         Height          =   180
         Left            =   2760
         TabIndex        =   12
         Top             =   765
         Width           =   1080
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Session Type:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   2640
         TabIndex        =   11
         Top             =   420
         Width           =   1170
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Teacher:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   60
         TabIndex        =   10
         Top             =   765
         Width           =   720
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Class:"
         ForeColor       =   &H000000C0&
         Height          =   180
         Left            =   240
         TabIndex        =   9
         Top             =   420
         Width           =   540
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "1.Init device"
      Height          =   1215
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5535
      Begin VB.CommandButton btnSetChannel 
         Caption         =   "Set"
         Height          =   375
         Left            =   2160
         TabIndex        =   24
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton btnInit 
         Caption         =   "Init"
         Height          =   375
         Left            =   4440
         TabIndex        =   7
         Top             =   720
         Width           =   975
      End
      Begin VB.ComboBox cboChannel 
         Height          =   300
         ItemData        =   "Form1.frx":002B
         Left            =   960
         List            =   "Form1.frx":002D
         TabIndex        =   4
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblVersion 
         AutoSize        =   -1  'True
         Caption         =   "V1.0.0"
         Height          =   180
         Left            =   2520
         TabIndex        =   6
         Top             =   360
         Width           =   540
      End
      Begin VB.Label lblModel 
         AutoSize        =   -1  'True
         Caption         =   "RF900"
         Height          =   180
         Left            =   840
         TabIndex        =   5
         Top             =   360
         Width           =   450
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Version:"
         Height          =   180
         Left            =   1680
         TabIndex        =   3
         Top             =   360
         Width           =   720
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Model:"
         Height          =   180
         Left            =   120
         TabIndex        =   2
         Top             =   360
         Width           =   540
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Channel:"
         Height          =   180
         Index           =   0
         Left            =   60
         TabIndex        =   1
         Top             =   840
         Width           =   720
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub btnInit_Click()
    Dim result As Boolean
    
    result = Me.QClick1.InitHost
    Me.cboChannel.Text = Me.QClick1.GetHostInfo(0)
    Me.lblModel.Caption = Me.QClick1.GetHostInfo(1)
    Me.lblVersion.Caption = Me.QClick1.GetHostInfo(2)
    Me.btnSetChannel.Enabled = result
    
    If (result) Then
        WriteLog ("Initial successfully")
    Else
        WriteLog ("Initial failed")
    End If
    
    
    
End Sub

Private Sub btnSetChannel_Click()
    Dim result As Integer
    result = Me.QClick1.SetHostChannel(Me.cboChannel.Text)
    WriteLog ("SetChannel:" + CStr(result))
End Sub

Private Sub btnStartQuestion_Click()
    Dim result As Long
    Dim quesNO, quesType, quesOptions As Integer
    Dim isSend As Boolean
    Dim ques, answer As String
    
    quesNO = Me.txtQuesNO.Text
    quesType = Me.cboQuestionType.ListIndex
    quesOptions = Me.cboOptions.ListIndex
    isSend = Me.cbSendQuestion
    ques = Me.txtQuestion.Text
    answer = "A"
    
    result = Me.QClick1.StartQuestion(quesNO, quesType, quesOptions, isSend, ques, answer)
    
    WriteLog ("StartQuestion:" + CStr(result))
    
    
    
End Sub

Private Sub btnStartSession_Click()
    Dim className, teacherName As String
    Dim sessionType, maxStudent As Integer
    Dim isForceLogin
    Dim result As Long
        
    className = Me.txtClassName.Text
    teacherName = Me.txtTeacherName.Text
    sessionType = 0
    maxStudent = Me.txtMaxStudent.Text
    isForceLogin = Me.cbLogin.Value
    
    result = Me.QClick1.StartSession(className, teacherName, maxStudent, sessionType, isForceLogin)
    WriteLog ("StartSession:" + CStr(result))
End Sub

Private Sub btnStopQuestion_Click()
    Dim result As Integer
    result = Me.QClick1.StopQuestion
    WriteLog ("StopQuestion:" + CStr(result))
End Sub

Private Sub btnStopSession_Click()
    Dim result As Integer
    result = Me.QClick1.StopSession
    WriteLog ("StopSession:" + CStr(result))
End Sub

Private Sub Form_Load()
    For i = 1 To 40
        Me.cboChannel.AddItem (i)
    Next i
    cboChannel.ListIndex = 0
        
    Me.cboSessionType.AddItem ("Normal")
    Me.cboSessionType.AddItem ("Rush")
    Me.cboSessionType.AddItem ("Eliminaion")
    Me.cboSessionType.AddItem ("Survey")
    Me.cboSessionType.AddItem ("Vote")
    cboSessionType.ListIndex = 0
    
    Me.cboQuestionType.AddItem ("Simple Choice")
    Me.cboQuestionType.AddItem ("Multi Choice")
    Me.cboQuestionType.AddItem ("Close Test")
    Me.cboQuestionType.AddItem ("True/False")
    cboQuestionType.ListIndex = 0
    
    For i = 1 To 10
        Me.cboOptions.AddItem (i)
    Next i
    cboOptions.ListIndex = 3
    
End Sub

Private Function WriteLog(ByVal message As String)
    Me.lstEvent.AddItem (CStr(DateTime.Now) + "  " + message)
    Me.lstEvent.ListIndex = lstEvent.ListCount - 1
End Function

Private Sub QClick1_OnAnswerReceived(ByVal lKeypadNO As Long, ByVal pStudentID As String, ByVal pAnswer As String)
    WriteLog ("Student(" + CStr(lKeypadNO) + ") ID:" + CStr(pStudentID) + " Answer:" + pAnswer)
End Sub

Private Sub QClick1_OnControlerReceived(ByVal nCmd As Integer)
    WriteLog ("Teacher(" + CStr(lKeypadNO) + ") CMD:" + CStr(nCmd))
End Sub

