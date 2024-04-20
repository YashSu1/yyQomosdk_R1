namespace QClickSDKDemo
{
    partial class frmStudentList
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose( bool disposing )
        {
            if ( disposing && ( components != null ) )
            {
                components.Dispose( );
            }
            base.Dispose( disposing );
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent( )
        {
            this.txtStudentList = new System.Windows.Forms.TextBox( );
            this.label1 = new System.Windows.Forms.Label( );
            this.SuspendLayout( );
            // 
            // txtStudentList
            // 
            this.txtStudentList.Anchor = ( (System.Windows.Forms.AnchorStyles)( ( ( ( System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom ) 
            | System.Windows.Forms.AnchorStyles.Left ) 
            | System.Windows.Forms.AnchorStyles.Right ) ) );
            this.txtStudentList.Location = new System.Drawing.Point( 2 , 24 );
            this.txtStudentList.Multiline = true;
            this.txtStudentList.Name = "txtStudentList";
            this.txtStudentList.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtStudentList.Size = new System.Drawing.Size( 383 , 272 );
            this.txtStudentList.TabIndex = 0;
            this.txtStudentList.Text = "1,2,3,4,5";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point( 6 , 9 );
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size( 215 , 12 );
            this.label1.TabIndex = 1;
            this.label1.Text = "Login allowed students(student id):";
            // 
            // frmStudentList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF( 6F , 12F );
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size( 389 , 300 );
            this.Controls.Add( this.label1 );
            this.Controls.Add( this.txtStudentList );
            this.Name = "frmStudentList";
            this.Text = "StudentList";
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler( this.frmStudentList_FormClosed );
            this.ResumeLayout( false );
            this.PerformLayout( );

        }

        #endregion

        private System.Windows.Forms.TextBox txtStudentList;
        private System.Windows.Forms.Label label1;
    }
}