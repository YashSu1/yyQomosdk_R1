namespace QClickSDKDemo
{
    partial class frmMain
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose( bool disposing )
        {
            if ( disposing && ( components != null ) )
            {
                components.Dispose( );
            }
            base.Dispose( disposing );
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent( )
        {
            this.components = new System.ComponentModel.Container( );
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager( typeof( frmMain ) );
            this.btnInit = new System.Windows.Forms.Button( );
            this.groupBox1 = new System.Windows.Forms.GroupBox( );
            this.btnSetChannel = new System.Windows.Forms.Button( );
            this.lblVersion = new System.Windows.Forms.Label( );
            this.lblModel = new System.Windows.Forms.Label( );
            this.cboChannel = new System.Windows.Forms.ComboBox( );
            this.label3 = new System.Windows.Forms.Label( );
            this.axQClick1 = new AxQCLICKV2Lib.AxQClickV2();
            this.label2 = new System.Windows.Forms.Label( );
            this.label1 = new System.Windows.Forms.Label( );
            this.groupBox2 = new System.Windows.Forms.GroupBox( );
            this.btnStop = new System.Windows.Forms.Button( );
            this.cbLogin = new System.Windows.Forms.CheckBox( );
            this.txtNumber = new System.Windows.Forms.TextBox( );
            this.cboMode = new System.Windows.Forms.ComboBox( );
            this.label7 = new System.Windows.Forms.Label( );
            this.label6 = new System.Windows.Forms.Label( );
            this.txtTeacher = new System.Windows.Forms.TextBox( );
            this.txtClass = new System.Windows.Forms.TextBox( );
            this.label5 = new System.Windows.Forms.Label( );
            this.label4 = new System.Windows.Forms.Label( );
            this.btnStartSession = new System.Windows.Forms.Button( );
            this.groupBox3 = new System.Windows.Forms.GroupBox( );
            this.label10 = new System.Windows.Forms.Label( );
            this.cbSend = new System.Windows.Forms.CheckBox( );
            this.cboQuestionOptions = new System.Windows.Forms.ComboBox( );
            this.label9 = new System.Windows.Forms.Label( );
            this.cboQuestionType = new System.Windows.Forms.ComboBox( );
            this.label8 = new System.Windows.Forms.Label( );
            this.cboQuestionNo = new System.Windows.Forms.DomainUpDown( );
            this.No = new System.Windows.Forms.Label( );
            this.btnStopQuestion = new System.Windows.Forms.Button( );
            this.txtAnswer = new System.Windows.Forms.TextBox( );
            this.txtQuestion = new System.Windows.Forms.TextBox( );
            this.btnSendQuestion = new System.Windows.Forms.Button( );
            this.statusStrip1 = new System.Windows.Forms.StatusStrip( );
            this.lblStatus = new System.Windows.Forms.ToolStripStatusLabel( );
            this.groupBox4 = new System.Windows.Forms.GroupBox( );
            this.lstEvent = new DotNetRemoting.DotNetListBox( );
            this.cMenuEvent = new System.Windows.Forms.ContextMenuStrip( this.components );
            this.copyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem( );
            this.clearToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem( );
            this.groupBox5 = new System.Windows.Forms.GroupBox( );
            this.btnSetKeypadNO = new System.Windows.Forms.Button( );
            this.cboKeypadNO = new System.Windows.Forms.ComboBox( );
            this.label11 = new System.Windows.Forms.Label( );
            this.groupBox1.SuspendLayout( );
            ( (System.ComponentModel.ISupportInitialize)( this.axQClick1 ) ).BeginInit( );
            this.groupBox2.SuspendLayout( );
            this.groupBox3.SuspendLayout( );
            this.statusStrip1.SuspendLayout( );
            this.groupBox4.SuspendLayout( );
            this.cMenuEvent.SuspendLayout( );
            this.groupBox5.SuspendLayout( );
            this.SuspendLayout( );
            // 
            // btnInit
            // 
            this.btnInit.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnInit.Location = new System.Drawing.Point( 306 , 53 );
            this.btnInit.Name = "btnInit";
            this.btnInit.Size = new System.Drawing.Size( 75 , 23 );
            this.btnInit.TabIndex = 1;
            this.btnInit.Text = "Init";
            this.btnInit.UseVisualStyleBackColor = true;
            this.btnInit.Click += new System.EventHandler( this.btnInit_Click );
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add( this.btnSetChannel );
            this.groupBox1.Controls.Add( this.lblVersion );
            this.groupBox1.Controls.Add( this.btnInit );
            this.groupBox1.Controls.Add( this.lblModel );
            this.groupBox1.Controls.Add( this.cboChannel );
            this.groupBox1.Controls.Add( this.label3 );
            this.groupBox1.Controls.Add( this.axQClick1 );
            this.groupBox1.Controls.Add( this.label2 );
            this.groupBox1.Controls.Add( this.label1 );
            this.groupBox1.Location = new System.Drawing.Point( 12 , 12 );
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size( 387 , 84 );
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "1.Init Device";
            // 
            // btnSetChannel
            // 
            this.btnSetChannel.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.btnSetChannel.Enabled = false;
            this.btnSetChannel.Location = new System.Drawing.Point( 116 , 55 );
            this.btnSetChannel.Name = "btnSetChannel";
            this.btnSetChannel.Size = new System.Drawing.Size( 51 , 23 );
            this.btnSetChannel.TabIndex = 8;
            this.btnSetChannel.Text = "Set";
            this.btnSetChannel.UseVisualStyleBackColor = true;
            this.btnSetChannel.Click += new System.EventHandler( this.btnSetChannel_Click );
            // 
            // lblVersion
            // 
            this.lblVersion.AutoSize = true;
            this.lblVersion.Location = new System.Drawing.Point( 188 , 24 );
            this.lblVersion.Name = "lblVersion";
            this.lblVersion.Size = new System.Drawing.Size( 0 , 12 );
            this.lblVersion.TabIndex = 7;
            // 
            // lblModel
            // 
            this.lblModel.AutoSize = true;
            this.lblModel.Location = new System.Drawing.Point( 63 , 24 );
            this.lblModel.Name = "lblModel";
            this.lblModel.Size = new System.Drawing.Size( 0 , 12 );
            this.lblModel.TabIndex = 6;
            // 
            // cboChannel
            // 
            this.cboChannel.FormattingEnabled = true;
            this.cboChannel.Items.AddRange( new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",
            "34",
            "35",
            "36",
            "37",
            "38",
            "39",
            "40"} );
            this.cboChannel.Location = new System.Drawing.Point( 63 , 56 );
            this.cboChannel.Name = "cboChannel";
            this.cboChannel.Size = new System.Drawing.Size( 47 , 20 );
            this.cboChannel.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point( 135 , 24 );
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size( 53 , 12 );
            this.label3.TabIndex = 4;
            this.label3.Text = "Version:";
            // 
            // axQClick1
            // 
            this.axQClick1.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.axQClick1.Enabled = true;
            this.axQClick1.Location = new System.Drawing.Point( 243 , 20 );
            this.axQClick1.Name = "axQClick1";
            this.axQClick1.OcxState = ( (System.Windows.Forms.AxHost.State)( resources.GetObject( "axQClick1.OcxState" ) ) );
            this.axQClick1.Size = new System.Drawing.Size( 42 , 37 );
            this.axQClick1.TabIndex = 3;
            this.axQClick1.OnKeypadLogin += new AxQCLICKV2Lib._DQClickV2Events_OnKeypadLoginEventHandler( this.axQClick1_OnKeypadLogin );
            this.axQClick1.OnDeviceChanged += new AxQCLICKV2Lib._DQClickV2Events_OnDeviceChangedEventHandler( this.axQClick1_OnDeviceChanged );
            this.axQClick1.OnKeypadLogout += new AxQCLICKV2Lib._DQClickV2Events_OnKeypadLogoutEventHandler( this.axQClick1_OnKeypadLogout );
            this.axQClick1.OnAnswerReceived += new AxQCLICKV2Lib._DQClickV2Events_OnAnswerReceivedEventHandler( this.axQClick1_OnAnswerReceived );
            this.axQClick1.OnControlerReceived += new AxQCLICKV2Lib._DQClickV2Events_OnControlerReceivedEventHandler( this.axQClick1_OnControlerReceived );
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point( 20 , 24 );
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size( 41 , 12 );
            this.label2.TabIndex = 3;
            this.label2.Text = "Model:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point( 8 , 60 );
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size( 53 , 12 );
            this.label1.TabIndex = 2;
            this.label1.Text = "Channel:";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add( this.btnStop );
            this.groupBox2.Controls.Add( this.cbLogin );
            this.groupBox2.Controls.Add( this.txtNumber );
            this.groupBox2.Controls.Add( this.cboMode );
            this.groupBox2.Controls.Add( this.label7 );
            this.groupBox2.Controls.Add( this.label6 );
            this.groupBox2.Controls.Add( this.txtTeacher );
            this.groupBox2.Controls.Add( this.txtClass );
            this.groupBox2.Controls.Add( this.label5 );
            this.groupBox2.Controls.Add( this.label4 );
            this.groupBox2.Controls.Add( this.btnStartSession );
            this.groupBox2.Location = new System.Drawing.Point( 12 , 102 );
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size( 387 , 105 );
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "2.Start/Stop Session";
            // 
            // btnStop
            // 
            this.btnStop.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnStop.Location = new System.Drawing.Point( 301 , 78 );
            this.btnStop.Name = "btnStop";
            this.btnStop.Size = new System.Drawing.Size( 75 , 23 );
            this.btnStop.TabIndex = 10;
            this.btnStop.Text = "Stop";
            this.btnStop.UseVisualStyleBackColor = true;
            this.btnStop.Click += new System.EventHandler( this.btnStop_Click );
            // 
            // cbLogin
            // 
            this.cbLogin.AutoSize = true;
            this.cbLogin.Location = new System.Drawing.Point( 63 , 81 );
            this.cbLogin.Name = "cbLogin";
            this.cbLogin.Size = new System.Drawing.Size( 108 , 16 );
            this.cbLogin.TabIndex = 9;
            this.cbLogin.Text = "Access control";
            this.cbLogin.UseVisualStyleBackColor = true;
            this.cbLogin.CheckedChanged += new System.EventHandler( this.cbLogin_CheckedChanged );
            // 
            // txtNumber
            // 
            this.txtNumber.Location = new System.Drawing.Point( 289 , 49 );
            this.txtNumber.Name = "txtNumber";
            this.txtNumber.Size = new System.Drawing.Size( 87 , 21 );
            this.txtNumber.TabIndex = 8;
            this.txtNumber.Text = "999";
            // 
            // cboMode
            // 
            this.cboMode.FormattingEnabled = true;
            this.cboMode.Items.AddRange( new object[] {
            "Normal",
            "Rush",
            "Elimination",
            "Survey",
            "Vote"} );
            this.cboMode.Location = new System.Drawing.Point( 289 , 20 );
            this.cboMode.Name = "cboMode";
            this.cboMode.Size = new System.Drawing.Size( 87 , 20 );
            this.cboMode.TabIndex = 7;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font( "宋体" , 9F , System.Drawing.FontStyle.Regular , System.Drawing.GraphicsUnit.Point , ( (byte)( 134 ) ) );
            this.label7.ForeColor = System.Drawing.Color.Red;
            this.label7.Location = new System.Drawing.Point( 202 , 24 );
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size( 83 , 12 );
            this.label7.TabIndex = 6;
            this.label7.Text = "Session Type:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point( 208 , 53 );
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size( 77 , 12 );
            this.label6.TabIndex = 5;
            this.label6.Text = "Max Student:";
            // 
            // txtTeacher
            // 
            this.txtTeacher.Location = new System.Drawing.Point( 63 , 49 );
            this.txtTeacher.Name = "txtTeacher";
            this.txtTeacher.Size = new System.Drawing.Size( 122 , 21 );
            this.txtTeacher.TabIndex = 4;
            this.txtTeacher.Text = "SDK Teacher";
            // 
            // txtClass
            // 
            this.txtClass.Location = new System.Drawing.Point( 63 , 20 );
            this.txtClass.Name = "txtClass";
            this.txtClass.Size = new System.Drawing.Size( 122 , 21 );
            this.txtClass.TabIndex = 3;
            this.txtClass.Text = "SDK Class";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font( "宋体" , 9F , System.Drawing.FontStyle.Regular , System.Drawing.GraphicsUnit.Point , ( (byte)( 134 ) ) );
            this.label5.ForeColor = System.Drawing.Color.Red;
            this.label5.Location = new System.Drawing.Point( 8 , 53 );
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size( 53 , 12 );
            this.label5.TabIndex = 2;
            this.label5.Text = "Teacher:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font( "宋体" , 9F , System.Drawing.FontStyle.Regular , System.Drawing.GraphicsUnit.Point , ( (byte)( 134 ) ) );
            this.label4.ForeColor = System.Drawing.Color.Red;
            this.label4.Location = new System.Drawing.Point( 20 , 24 );
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size( 41 , 12 );
            this.label4.TabIndex = 1;
            this.label4.Text = "Class:";
            // 
            // btnStartSession
            // 
            this.btnStartSession.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnStartSession.Location = new System.Drawing.Point( 206 , 78 );
            this.btnStartSession.Name = "btnStartSession";
            this.btnStartSession.Size = new System.Drawing.Size( 75 , 23 );
            this.btnStartSession.TabIndex = 0;
            this.btnStartSession.Text = "Start";
            this.btnStartSession.UseVisualStyleBackColor = true;
            this.btnStartSession.Click += new System.EventHandler( this.btnStartSession_Click );
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add( this.label10 );
            this.groupBox3.Controls.Add( this.cbSend );
            this.groupBox3.Controls.Add( this.cboQuestionOptions );
            this.groupBox3.Controls.Add( this.label9 );
            this.groupBox3.Controls.Add( this.cboQuestionType );
            this.groupBox3.Controls.Add( this.label8 );
            this.groupBox3.Controls.Add( this.cboQuestionNo );
            this.groupBox3.Controls.Add( this.No );
            this.groupBox3.Controls.Add( this.btnStopQuestion );
            this.groupBox3.Controls.Add( this.txtAnswer );
            this.groupBox3.Controls.Add( this.txtQuestion );
            this.groupBox3.Controls.Add( this.btnSendQuestion );
            this.groupBox3.Location = new System.Drawing.Point( 12 , 213 );
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size( 387 , 157 );
            this.groupBox3.TabIndex = 5;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "3.Start/Stop Question";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point( 4 , 49 );
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size( 59 , 12 );
            this.label10.TabIndex = 14;
            this.label10.Text = "Question:";
            // 
            // cbSend
            // 
            this.cbSend.AutoSize = true;
            this.cbSend.Location = new System.Drawing.Point( 63 , 131 );
            this.cbSend.Name = "cbSend";
            this.cbSend.Size = new System.Drawing.Size( 102 , 16 );
            this.cbSend.TabIndex = 13;
            this.cbSend.Text = "Send question";
            this.cbSend.UseVisualStyleBackColor = true;
            // 
            // cboQuestionOptions
            // 
            this.cboQuestionOptions.FormattingEnabled = true;
            this.cboQuestionOptions.Items.AddRange( new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10"} );
            this.cboQuestionOptions.Location = new System.Drawing.Point( 335 , 19 );
            this.cboQuestionOptions.Name = "cboQuestionOptions";
            this.cboQuestionOptions.Size = new System.Drawing.Size( 41 , 20 );
            this.cboQuestionOptions.TabIndex = 12;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.ForeColor = System.Drawing.Color.Red;
            this.label9.Location = new System.Drawing.Point( 282 , 23 );
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size( 53 , 12 );
            this.label9.TabIndex = 11;
            this.label9.Text = "Options:";
            // 
            // cboQuestionType
            // 
            this.cboQuestionType.FormattingEnabled = true;
            this.cboQuestionType.Items.AddRange( new object[] {
            "Single Choice",
            "Multi Choice",
            "Close Test",
            "True/False"} );
            this.cboQuestionType.Location = new System.Drawing.Point( 153 , 19 );
            this.cboQuestionType.Name = "cboQuestionType";
            this.cboQuestionType.Size = new System.Drawing.Size( 126 , 20 );
            this.cboQuestionType.TabIndex = 10;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.ForeColor = System.Drawing.Color.Red;
            this.label8.Location = new System.Drawing.Point( 116 , 23 );
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size( 35 , 12 );
            this.label8.TabIndex = 9;
            this.label8.Text = "Type:";
            // 
            // cboQuestionNo
            // 
            this.cboQuestionNo.Items.Add( "99" );
            this.cboQuestionNo.Items.Add( "98" );
            this.cboQuestionNo.Items.Add( "97" );
            this.cboQuestionNo.Items.Add( "96" );
            this.cboQuestionNo.Items.Add( "95" );
            this.cboQuestionNo.Items.Add( "94" );
            this.cboQuestionNo.Items.Add( "93" );
            this.cboQuestionNo.Items.Add( "92" );
            this.cboQuestionNo.Items.Add( "91" );
            this.cboQuestionNo.Items.Add( "90" );
            this.cboQuestionNo.Items.Add( "89" );
            this.cboQuestionNo.Items.Add( "88" );
            this.cboQuestionNo.Items.Add( "87" );
            this.cboQuestionNo.Items.Add( "86" );
            this.cboQuestionNo.Items.Add( "85" );
            this.cboQuestionNo.Items.Add( "84" );
            this.cboQuestionNo.Items.Add( "83" );
            this.cboQuestionNo.Items.Add( "82" );
            this.cboQuestionNo.Items.Add( "81" );
            this.cboQuestionNo.Items.Add( "80" );
            this.cboQuestionNo.Items.Add( "79" );
            this.cboQuestionNo.Items.Add( "78" );
            this.cboQuestionNo.Items.Add( "77" );
            this.cboQuestionNo.Items.Add( "76" );
            this.cboQuestionNo.Items.Add( "75" );
            this.cboQuestionNo.Items.Add( "74" );
            this.cboQuestionNo.Items.Add( "73" );
            this.cboQuestionNo.Items.Add( "72" );
            this.cboQuestionNo.Items.Add( "71" );
            this.cboQuestionNo.Items.Add( "70" );
            this.cboQuestionNo.Items.Add( "69" );
            this.cboQuestionNo.Items.Add( "68" );
            this.cboQuestionNo.Items.Add( "67" );
            this.cboQuestionNo.Items.Add( "66" );
            this.cboQuestionNo.Items.Add( "65" );
            this.cboQuestionNo.Items.Add( "64" );
            this.cboQuestionNo.Items.Add( "63" );
            this.cboQuestionNo.Items.Add( "62" );
            this.cboQuestionNo.Items.Add( "61" );
            this.cboQuestionNo.Items.Add( "60" );
            this.cboQuestionNo.Items.Add( "59" );
            this.cboQuestionNo.Items.Add( "58" );
            this.cboQuestionNo.Items.Add( "57" );
            this.cboQuestionNo.Items.Add( "56" );
            this.cboQuestionNo.Items.Add( "55" );
            this.cboQuestionNo.Items.Add( "54" );
            this.cboQuestionNo.Items.Add( "53" );
            this.cboQuestionNo.Items.Add( "52" );
            this.cboQuestionNo.Items.Add( "51" );
            this.cboQuestionNo.Items.Add( "50" );
            this.cboQuestionNo.Items.Add( "49" );
            this.cboQuestionNo.Items.Add( "48" );
            this.cboQuestionNo.Items.Add( "47" );
            this.cboQuestionNo.Items.Add( "46" );
            this.cboQuestionNo.Items.Add( "45" );
            this.cboQuestionNo.Items.Add( "44" );
            this.cboQuestionNo.Items.Add( "43" );
            this.cboQuestionNo.Items.Add( "42" );
            this.cboQuestionNo.Items.Add( "41" );
            this.cboQuestionNo.Items.Add( "40" );
            this.cboQuestionNo.Items.Add( "39" );
            this.cboQuestionNo.Items.Add( "38" );
            this.cboQuestionNo.Items.Add( "37" );
            this.cboQuestionNo.Items.Add( "36" );
            this.cboQuestionNo.Items.Add( "35" );
            this.cboQuestionNo.Items.Add( "34" );
            this.cboQuestionNo.Items.Add( "33" );
            this.cboQuestionNo.Items.Add( "32" );
            this.cboQuestionNo.Items.Add( "31" );
            this.cboQuestionNo.Items.Add( "30" );
            this.cboQuestionNo.Items.Add( "29" );
            this.cboQuestionNo.Items.Add( "28" );
            this.cboQuestionNo.Items.Add( "27" );
            this.cboQuestionNo.Items.Add( "26" );
            this.cboQuestionNo.Items.Add( "25" );
            this.cboQuestionNo.Items.Add( "24" );
            this.cboQuestionNo.Items.Add( "23" );
            this.cboQuestionNo.Items.Add( "22" );
            this.cboQuestionNo.Items.Add( "21" );
            this.cboQuestionNo.Items.Add( "20" );
            this.cboQuestionNo.Items.Add( "19" );
            this.cboQuestionNo.Items.Add( "18" );
            this.cboQuestionNo.Items.Add( "17" );
            this.cboQuestionNo.Items.Add( "16" );
            this.cboQuestionNo.Items.Add( "15" );
            this.cboQuestionNo.Items.Add( "14" );
            this.cboQuestionNo.Items.Add( "13" );
            this.cboQuestionNo.Items.Add( "12" );
            this.cboQuestionNo.Items.Add( "11" );
            this.cboQuestionNo.Items.Add( "10" );
            this.cboQuestionNo.Items.Add( "9" );
            this.cboQuestionNo.Items.Add( "8" );
            this.cboQuestionNo.Items.Add( "7" );
            this.cboQuestionNo.Items.Add( "6" );
            this.cboQuestionNo.Items.Add( "5" );
            this.cboQuestionNo.Items.Add( "4" );
            this.cboQuestionNo.Items.Add( "3" );
            this.cboQuestionNo.Items.Add( "2" );
            this.cboQuestionNo.Items.Add( "1" );
            this.cboQuestionNo.Items.Add( "0" );
            this.cboQuestionNo.Location = new System.Drawing.Point( 63 , 19 );
            this.cboQuestionNo.Name = "cboQuestionNo";
            this.cboQuestionNo.Size = new System.Drawing.Size( 43 , 21 );
            this.cboQuestionNo.TabIndex = 8;
            this.cboQuestionNo.Text = "0";
            // 
            // No
            // 
            this.No.AutoSize = true;
            this.No.ForeColor = System.Drawing.Color.Red;
            this.No.Location = new System.Drawing.Point( 36 , 23 );
            this.No.Name = "No";
            this.No.Size = new System.Drawing.Size( 23 , 12 );
            this.No.TabIndex = 7;
            this.No.Text = "No:";
            // 
            // btnStopQuestion
            // 
            this.btnStopQuestion.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.btnStopQuestion.Location = new System.Drawing.Point( 301 , 128 );
            this.btnStopQuestion.Name = "btnStopQuestion";
            this.btnStopQuestion.Size = new System.Drawing.Size( 75 , 23 );
            this.btnStopQuestion.TabIndex = 4;
            this.btnStopQuestion.Text = "Stop";
            this.btnStopQuestion.UseVisualStyleBackColor = true;
            this.btnStopQuestion.Click += new System.EventHandler( this.btnStopQuestion_Click );
            // 
            // txtAnswer
            // 
            this.txtAnswer.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( ( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom ) 
            | System.Windows.Forms.AnchorStyles.Left ) 
            | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.txtAnswer.Location = new System.Drawing.Point( 10 , 150 );
            this.txtAnswer.Multiline = true;
            this.txtAnswer.Name = "txtAnswer";
            this.txtAnswer.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtAnswer.Size = new System.Drawing.Size( 367 , 0 );
            this.txtAnswer.TabIndex = 3;
            // 
            // txtQuestion
            // 
            this.txtQuestion.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left ) 
            | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.txtQuestion.Location = new System.Drawing.Point( 63 , 46 );
            this.txtQuestion.Multiline = true;
            this.txtQuestion.Name = "txtQuestion";
            this.txtQuestion.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtQuestion.Size = new System.Drawing.Size( 313 , 76 );
            this.txtQuestion.TabIndex = 2;
            this.txtQuestion.Text = "Where are you?\r\nA.US\r\nB.UK\r\nC.CN\r\nD.AU\r\n";
            // 
            // btnSendQuestion
            // 
            this.btnSendQuestion.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.btnSendQuestion.Location = new System.Drawing.Point( 206 , 128 );
            this.btnSendQuestion.Name = "btnSendQuestion";
            this.btnSendQuestion.Size = new System.Drawing.Size( 75 , 23 );
            this.btnSendQuestion.TabIndex = 1;
            this.btnSendQuestion.Text = "Start";
            this.btnSendQuestion.UseVisualStyleBackColor = true;
            this.btnSendQuestion.Click += new System.EventHandler( this.btnSendQuestion_Click );
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange( new System.Windows.Forms.ToolStripItem[] {
            this.lblStatus} );
            this.statusStrip1.Location = new System.Drawing.Point( 0 , 438 );
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size( 719 , 22 );
            this.statusStrip1.TabIndex = 6;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // lblStatus
            // 
            this.lblStatus.ForeColor = System.Drawing.Color.FromArgb( ( (int)( ( (byte)( 192 ) ) ) ) , ( (int)( ( (byte)( 0 ) ) ) ) , ( (int)( ( (byte)( 0 ) ) ) ) );
            this.lblStatus.Name = "lblStatus";
            this.lblStatus.Size = new System.Drawing.Size( 0 , 17 );
            // 
            // groupBox4
            // 
            this.groupBox4.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( ( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom ) 
            | System.Windows.Forms.AnchorStyles.Left ) 
            | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.groupBox4.Controls.Add( this.lstEvent );
            this.groupBox4.Location = new System.Drawing.Point( 405 , 12 );
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size( 306 , 422 );
            this.groupBox4.TabIndex = 7;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Event History";
            // 
            // lstEvent
            // 
            this.lstEvent.ContextMenuStrip = this.cMenuEvent;
            this.lstEvent.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lstEvent.HighLightColor = System.Drawing.Color.FromArgb( ( (int)( ( (byte)( 235 ) ) ) ) , ( (int)( ( (byte)( 237 ) ) ) ) , ( (int)( ( (byte)( 249 ) ) ) ) );
            this.lstEvent.IconImageList = null;
            this.lstEvent.Location = new System.Drawing.Point( 3 , 17 );
            this.lstEvent.Name = "lstEvent";
            this.lstEvent.Size = new System.Drawing.Size( 300 , 402 );
            this.lstEvent.TabIndex = 0;
            // 
            // cMenuEvent
            // 
            this.cMenuEvent.Items.AddRange( new System.Windows.Forms.ToolStripItem[] {
            this.copyToolStripMenuItem,
            this.clearToolStripMenuItem} );
            this.cMenuEvent.Name = "cMenuEvent";
            this.cMenuEvent.Size = new System.Drawing.Size( 107 , 48 );
            // 
            // copyToolStripMenuItem
            // 
            this.copyToolStripMenuItem.Name = "copyToolStripMenuItem";
            this.copyToolStripMenuItem.Size = new System.Drawing.Size( 106 , 22 );
            this.copyToolStripMenuItem.Text = "Copy";
            this.copyToolStripMenuItem.Click += new System.EventHandler( this.copyToolStripMenuItem_Click );
            // 
            // clearToolStripMenuItem
            // 
            this.clearToolStripMenuItem.Name = "clearToolStripMenuItem";
            this.clearToolStripMenuItem.Size = new System.Drawing.Size( 106 , 22 );
            this.clearToolStripMenuItem.Text = "Clear";
            this.clearToolStripMenuItem.Click += new System.EventHandler( this.clearToolStripMenuItem_Click );
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add( this.btnSetKeypadNO );
            this.groupBox5.Controls.Add( this.cboKeypadNO );
            this.groupBox5.Controls.Add( this.label11 );
            this.groupBox5.Location = new System.Drawing.Point( 12 , 376 );
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size( 387 , 55 );
            this.groupBox5.TabIndex = 8;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "QRF300";
            // 
            // btnSetKeypadNO
            // 
            this.btnSetKeypadNO.Anchor = System.Windows.Forms.AnchorStyles.Left;
            this.btnSetKeypadNO.Location = new System.Drawing.Point( 116 , 20 );
            this.btnSetKeypadNO.Name = "btnSetKeypadNO";
            this.btnSetKeypadNO.Size = new System.Drawing.Size( 51 , 23 );
            this.btnSetKeypadNO.TabIndex = 11;
            this.btnSetKeypadNO.Text = "Set";
            this.btnSetKeypadNO.UseVisualStyleBackColor = true;
            this.btnSetKeypadNO.Click += new System.EventHandler( this.btnSetKeypadNO_Click );
            // 
            // cboKeypadNO
            // 
            this.cboKeypadNO.FormattingEnabled = true;
            this.cboKeypadNO.Items.AddRange( new object[] {
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",
            "34",
            "35",
            "36",
            "37",
            "38",
            "39",
            "40",
            "41",
            "42",
            "43",
            "44",
            "45",
            "46",
            "47",
            "48",
            "49",
            "50",
            "51",
            "52",
            "53",
            "54",
            "55",
            "56",
            "57",
            "58",
            "59",
            "60",
            "61",
            "62",
            "63",
            "64",
            "65",
            "66",
            "67",
            "68",
            "69",
            "70",
            "71",
            "72",
            "73",
            "74",
            "75",
            "76",
            "77",
            "78",
            "79",
            "80",
            "81",
            "82",
            "83",
            "84",
            "85",
            "86",
            "87",
            "88",
            "89",
            "90",
            "91",
            "92",
            "93",
            "94",
            "95",
            "96",
            "97",
            "98",
            "99"} );
            this.cboKeypadNO.Location = new System.Drawing.Point( 63 , 21 );
            this.cboKeypadNO.Name = "cboKeypadNO";
            this.cboKeypadNO.Size = new System.Drawing.Size( 47 , 20 );
            this.cboKeypadNO.TabIndex = 10;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point( 1 , 25 );
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size( 59 , 12 );
            this.label11.TabIndex = 9;
            this.label11.Text = "KeypadNO:";
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF( 6F , 12F );
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size( 719 , 460 );
            this.Controls.Add( this.groupBox5 );
            this.Controls.Add( this.groupBox4 );
            this.Controls.Add( this.statusStrip1 );
            this.Controls.Add( this.groupBox1 );
            this.Controls.Add( this.groupBox3 );
            this.Controls.Add( this.groupBox2 );
            this.MinimumSize = new System.Drawing.Size( 735 , 434 );
            this.Name = "frmMain";
            this.Text = "QClick SDK Demo";
            this.groupBox1.ResumeLayout( false );
            this.groupBox1.PerformLayout( );
            ( (System.ComponentModel.ISupportInitialize)( this.axQClick1 ) ).EndInit( );
            this.groupBox2.ResumeLayout( false );
            this.groupBox2.PerformLayout( );
            this.groupBox3.ResumeLayout( false );
            this.groupBox3.PerformLayout( );
            this.statusStrip1.ResumeLayout( false );
            this.statusStrip1.PerformLayout( );
            this.groupBox4.ResumeLayout( false );
            this.cMenuEvent.ResumeLayout( false );
            this.groupBox5.ResumeLayout( false );
            this.groupBox5.PerformLayout( );
            this.ResumeLayout( false );
            this.PerformLayout( );

        }

        #endregion

        private System.Windows.Forms.Button btnInit;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblModel;
        private System.Windows.Forms.ComboBox cboChannel;
        private System.Windows.Forms.Label lblVersion;
        private AxQCLICKV2Lib.AxQClickV2 axQClick1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.Button btnStartSession;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel lblStatus;
        private System.Windows.Forms.Button btnSendQuestion;
        private System.Windows.Forms.TextBox txtQuestion;
        private System.Windows.Forms.TextBox txtAnswer;
        private System.Windows.Forms.Button btnStopQuestion;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtTeacher;
        private System.Windows.Forms.TextBox txtClass;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.ComboBox cboMode;
        private System.Windows.Forms.TextBox txtNumber;
        private System.Windows.Forms.CheckBox cbLogin;
        private System.Windows.Forms.Button btnSetChannel;
        private System.Windows.Forms.Button btnStop;
        private System.Windows.Forms.Label No;
        private System.Windows.Forms.DomainUpDown cboQuestionNo;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.ComboBox cboQuestionType;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.ComboBox cboQuestionOptions;
        private System.Windows.Forms.CheckBox cbSend;
        private System.Windows.Forms.GroupBox groupBox4;
        private DotNetRemoting.DotNetListBox lstEvent;
        private System.Windows.Forms.ContextMenuStrip cMenuEvent;
        private System.Windows.Forms.ToolStripMenuItem copyToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem clearToolStripMenuItem;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Button btnSetKeypadNO;
        private System.Windows.Forms.ComboBox cboKeypadNO;
        private System.Windows.Forms.Label label11;
    }
}

