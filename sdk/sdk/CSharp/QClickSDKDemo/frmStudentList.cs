using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace QClickSDKDemo
{
    public partial class frmStudentList : Form
    {
        public string studentList
        {
            get;
            set;
        }
        public frmStudentList( )
        {
            InitializeComponent( );
            this.txtStudentList.Text = this.studentList;
        }

        public frmStudentList(string studentlist )
        {
            InitializeComponent( );
            this.txtStudentList.Text = studentlist;
        }

        private void frmStudentList_FormClosed( object sender , FormClosedEventArgs e )
        {
            this.studentList = this.txtStudentList.Text;
            DialogResult = DialogResult.OK;
        }
    }
}
