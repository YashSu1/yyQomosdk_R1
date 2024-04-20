using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace QClickSDKDemo
{
    public partial class frmMain : Form
    {
        public delegate void DelegatePrintLog( string s , Color  c );//write log
        public string studentList = "";
        public frmMain( )
        {
            InitializeComponent( );
            this.cboMode.SelectedIndex = 0;
            this.cboQuestionType.SelectedIndex = 0;
            this.cboQuestionOptions.SelectedIndex = 3;
            this.cboQuestionNo.SelectedIndex = cboQuestionNo.Items.Count-1;
        }

        /// <summary>
        /// Initialize the host
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnInit_Click( object sender , EventArgs e )
        {
            if ( Convert.ToBoolean(this.axQClick1.InitHost( )) )
            {
                this.btnSetChannel.Enabled = true;
                WriteLog( "Initialize successfully!" , Color.Green );
            }
            else
            {
                this.btnSetChannel.Enabled = false;
                WriteLog( "Initialize failed!" , Color.Red );
            }
            this.cboChannel.Text = this.axQClick1.GetHostInfo( 0 );
            this.lblModel.Text = this.axQClick1.GetHostInfo( 1 );
            this.lblVersion.Text = this.axQClick1.GetHostInfo( 2 );
        }

        /// <summary>
        /// Start a session
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnStartSession_Click( object sender , EventArgs e )
        {
            int result ;
            string className = this.txtClass.Text;
            string teacherName = this.txtTeacher.Text;
            int maxNumber = Convert.ToInt32( this.txtNumber.Text );
            short sessionType = Convert.ToInt16( cboMode.SelectedIndex );
            result = this.axQClick1.StartSession( className , 
                teacherName , maxNumber , sessionType , Convert.ToSByte(cbLogin.Checked), Convert.ToSByte(true) );

            switch ( result )
            {
                case 0:
                    WriteLog( "Session start successfully. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                case 2:
                    WriteLog( "Fail! Please stop session first! (2)" , Color.Red );
                    break;
                default:
                    WriteLog( "Result code"+result.ToString( ) , Color.Red );
                    break;
            }
        }

        /// <summary>
        /// Set the channel of receiver
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSetChannel_Click( object sender , EventArgs e )
        {
            short channel = Convert.ToInt16( this.cboChannel.Text );
            int result =  this.axQClick1.SetHostChannel( channel );

            switch ( result )
            {
                case 0:
                    WriteLog( "Set Channel successfully. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                default:
                    WriteLog( "Result code"+result.ToString( ) , Color.Red );
                    break;
            }
        }

        /// <summary>
        /// Stop current session
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnStop_Click( object sender , EventArgs e )
        {
            int result = this.axQClick1.StopSession( );

            switch ( result )
            {
                case 0:
                    WriteLog( "Session Stoped. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                case 2:
                    WriteLog( "Fail! Please start session first! (2)" , Color.Red );
                    break;
                default:
                    WriteLog( "Result code"+result.ToString() , Color.Red );
                    break;
            }
        }

        /// <summary>
        /// Send a question
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSendQuestion_Click( object sender , EventArgs e )
        {
            //set a new question no
            //every question need a unique questionNo during session   
            this.cboQuestionNo.SelectedIndex -=1;
            
            short questionNo = Convert.ToInt16( this.cboQuestionNo.Text );
            short questionType = Convert.ToInt16( this.cboQuestionType.SelectedIndex );
            short questionOptions = Convert.ToInt16( this.cboQuestionOptions.Text );
            bool isSendQuestion = Convert.ToBoolean(this.cbSend.Checked);
            string question = this.txtQuestion.Text;

            //Start question                     
            int result = axQClick1.StartQuestion( questionNo , questionType ,
                questionOptions , Convert.ToSByte(isSendQuestion) , question,"A",0, -1);

            //handle the result
            switch ( result )
            {
                case 0:
                    WriteLog( "Question start successfully. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                case 2:
                    WriteLog( "Fail! Please start session first! (2)" , Color.Red );
                    break;
                case 3:
                    WriteLog( "Fail! Please stop previous question first! (3)" , Color.Red );
                    break;
                default:
                    WriteLog( "Result code:"+result.ToString() , Color.Red );
                    break;
            }
        }

        /// <summary>
        /// Stop current question
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnStopQuestion_Click( object sender , EventArgs e )
        {
            int result = this.axQClick1.StopQuestion( );
            
            switch ( result )
            {
                case 0:
                    WriteLog( "Question Stoped. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                case 2:
                    WriteLog( "Fail! Please start session first! (2)" , Color.Red );
                    break;

                case 3:
                    WriteLog( "Fail! Please start question first! (3)" , Color.Red );
                    break;
                default:
                    break;
            }
        }

        /// <summary>
        /// set the NO of Keypad this method just for QRF300
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSetKeypadNO_Click( object sender , EventArgs e )
        {
            short keypadNO = Convert.ToInt16( this.cboKeypadNO.Text );
            int result = this.axQClick1.SetKeypadNO( keypadNO );

            switch ( result )
            {
                case 0:
                    WriteLog( "Set KeypadNO successfully. (0)" , Color.Green );
                    break;
                case 1:
                    WriteLog( "Fail! Please init first! (1)" , Color.Red );
                    break;
                default:
                    WriteLog( "KeypadNO Result code: "+result.ToString( ) , Color.Red );
                    break;
            }
        }

        private void axQClick1_OnDeviceChanged(object sender, AxQCLICKV2Lib._DQClickV2Events_OnDeviceChangedEvent e)
        {
            WriteLog( "Device changed! Model:"+e.nHostModel+" Version:"+e.pHostVersion+" Channel:"+e.pChannelNO , Color.DarkRed );
        }

        private void axQClick1_OnAnswerReceived(object sender, AxQCLICKV2Lib._DQClickV2Events_OnAnswerReceivedEvent e)
        {
            //anyone send a answer
            WriteLog( "Student(SessionID:"+e.lKeypadNO+") ID:"+e.pStudentID+" Answer:"+e.pAnswer , Color.Blue );
        }

        private void axQClick1_OnControlerReceived( object sender , AxQCLICKV2Lib._DQClickV2Events_OnControlerReceivedEvent e )
        {
            //teacher send a control signal
            WriteLog( "Teacher CMD:"+e.nCmd , Color.Firebrick );
        }

        private void axQClick1_OnKeypadLogin( object sender , AxQCLICKV2Lib._DQClickV2Events_OnKeypadLoginEvent e )
        {
            //you need start session with parameter bLoginFlag=true first.
            //if not need access control, bLoginFlag=false and ignore this event.
            if ( this.cbLogin.Checked )
            {
                //tell the host to allow or deny keypad login
                //this.axQClick1.AllowLogin( e.lKeypadNO , e.pStudentID , this.AllowLogin( e.pStudentID ) );

                if ( this.AllowLogin( e.pStudentID ) )
                    WriteLog( "Login allowed(SessionID:"+e.lKeypadNO+") StudentID:"+e.pStudentID , Color.LightSeaGreen );
                else
                    WriteLog( "Login denied(SessionID:"+e.lKeypadNO+") StudentID:"+e.pStudentID , Color.Red );
            }
            else
                WriteLog( "Login allowed(SessionID:"+e.lKeypadNO+") StudentID:"+e.pStudentID , Color.LightSeaGreen );

        }

        private void axQClick1_OnKeypadLogout( object sender , AxQCLICKV2Lib._DQClickV2Events_OnKeypadLogoutEvent e )
        {
            //anyone logout the session.
            WriteLog( "Logout(SessionID:"+e.lKeypadNO+") Student ID:"+e.pStudentID , Color.CornflowerBlue );
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="studentID"></param>
        /// <returns></returns>
        private bool AllowLogin( string studentID )
        {
            bool result = false;
            string sList = QClickSDKDemo.Properties.Settings.Default.StudentList+",";
            result=sList.Contains( studentID +",");
            return result;
        }

        #region Write operation log
        /// <summary>
        /// Write operation log
        /// </summary>
        /// <param name="status">Message</param>
        /// <param name="color">color of message</param>
        public void WriteLog( string status , Color color )
        {
            if ( this.InvokeRequired )
            {
                DelegatePrintLog mi = new DelegatePrintLog( WriteLog );
                this.BeginInvoke( mi , new object[] { status , color } );
            }
            else
            {
                lock ( this )
                {
                    lblStatus.ForeColor = color;
                    lblStatus.Text = status;
                    string time = DateTime.Now.TimeOfDay.ToString( );
                    time = time.Substring( 0 , time.Length-3 );
                    lstEvent.InsertItem( 0 , time +"  "+ status , 1 , color );
                }
            }
        }
        #endregion       

        private void clearToolStripMenuItem_Click( object sender , EventArgs e )
        {
            this.lstEvent.Clear( );
        }

        private void copyToolStripMenuItem_Click( object sender , EventArgs e )
        {
            if ( lstEvent.InternalListBox.SelectedItems.Count>0 )
            {
                string selected = "";
                for ( int i=0 ; i<lstEvent.InternalListBox.SelectedItems.Count ; i++ )
                {
                    selected += lstEvent.InternalListBox.SelectedItems[i] + Environment.NewLine;
                }
                Clipboard.SetDataObject( selected );
            }
        }

        private void cbLogin_CheckedChanged( object sender , EventArgs e )
        {
            if ( cbLogin.Checked )
            {
                frmStudentList frmSL = new frmStudentList( QClickSDKDemo.Properties.Settings.Default.StudentList );
                if ( frmSL.ShowDialog( ) == DialogResult.OK )
                {
                    Properties.Settings.Default.StudentList = frmSL.studentList;
                    Properties.Settings.Default.Save( );
                }
            }
        }

        /// <summary>
        /// Close the host
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnClose_Click( object sender , EventArgs e )
        {
            this.axQClick1.CloseHost( );
        }

    }
}
