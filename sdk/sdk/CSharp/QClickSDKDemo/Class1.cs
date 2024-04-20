using System;
using System.ComponentModel;
using System.Windows.Forms;

namespace AxQCLICKLib
{
    [DefaultEvent( "OnDeviceChanged" )]
    [DesignTimeVisible( true )]
    public class AxQClick : AxHost
    {
        public AxQClick( );

        public event _DQClickEvents_OnAnswerReceivedEventHandler OnAnswerReceived;
        public event _DQClickEvents_OnControlerReceivedEventHandler OnControlerReceived;
        public event _DQClickEvents_OnDeviceChangedEventHandler OnDeviceChanged;
        public event _DQClickEvents_OnKeypadLoginEventHandler OnKeypadLogin;
        public event _DQClickEvents_OnKeypadLogoutEventHandler OnKeypadLogout;

        public virtual void AboutBox( );
        public virtual bool AllowLogin( int lDeviceNo , string pStudentID , bool bAllowLogin );
        protected override void AttachInterfaces( );
        public virtual bool CloseHost( );
        protected override void CreateSink( );
        protected override void DetachSink( );
        public virtual string GetHostInfo( int lFlag );
        public virtual bool InitHost( );
        public virtual bool SetHostChannel( short nChannelNo );
        public virtual int StartQuestion( short nQuestionNo , short nQuestionType , short nNumberOfOption , bool bIsSendQuestion , string pQuestionInfo , string pCorrectAnswer );
        public virtual int StartSession( string pClassName , string pTeacherName , int lMaxStudents , short nSessionType , bool bLoginFlag );
        public virtual int StopQuestion( );
        public virtual int StopSession( );
    }
}
