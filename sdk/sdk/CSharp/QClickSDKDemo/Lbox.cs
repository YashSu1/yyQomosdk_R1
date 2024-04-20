/********************************************************************************				
*		http://DotNetRemoting.com												*
*																				*
*		DotNetListBox 															*
*																				*
*		Color ListBox implementation											*
*																				*
*		April 2005																*
*																				*
********************************************************************************/
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Windows.Forms;
using System.Runtime.InteropServices;

namespace DotNetRemoting
{
	public class Lbox : ListBox
	{
		[DllImport("user32.dll",CharSet=CharSet.Auto)]
		private static extern int SendMessage(IntPtr hWnd, int wMsg,IntPtr wParam, IntPtr lParam);

		private const int SB_LINEUP				= 0; // Scrolls one line up
		private const int SB_LINELEFT			= 0;// Scrolls one cell left
		private const int SB_LINEDOWN			= 1; // Scrolls one line down
		private const int WM_ERASEBKGND			= 0x0014;
		private const int WM_MOUSEWHEEL         = 0x020A;
		private const int WM_VSCROLL            = 0x0115;
		private const int WM_KEYDOWN            = 0x0100;

		private System.ComponentModel.Container components = null;

		public event EventHandler			UpdateEv;
		private bool						_BlockEraseBackGnd = true;

		public Lbox()
		{			 
			InitializeComponent();
		}

		internal bool BlockEraseBackGnd
		{
			set
			{
				_BlockEraseBackGnd = value;
			}
			get
			{
				return _BlockEraseBackGnd; 
			}
		}

		private void GetXY(IntPtr Param, out int X, out int Y)
		{
			byte[] byts = System.BitConverter.GetBytes((int)Param);
			X = BitConverter.ToInt16(byts, 0);
			Y = BitConverter.ToInt16(byts, 2);
		}
	
		protected override void WndProc(ref Message m)
		{
			switch (m.Msg)
			{
				case (int)WM_ERASEBKGND:

					if (_BlockEraseBackGnd)
					{
						return;
					}
				
					break;

				case (int)WM_MOUSEWHEEL:

					int X;
					int Y;

					_BlockEraseBackGnd = false;

					GetXY(m.WParam, out X, out Y);

					if (Y >0)
					{
						SendMessage(this.Handle, (int)WM_VSCROLL,(IntPtr)SB_LINEUP,IntPtr.Zero);
					}
					else
					{
						SendMessage(this.Handle, (int)WM_VSCROLL,(IntPtr)SB_LINEDOWN,IntPtr.Zero);
					}
					return;

				case (int)WM_VSCROLL:				
				case (int)WM_KEYDOWN:
				
					_BlockEraseBackGnd = false;

					if (UpdateEv != null)
					{
						UpdateEv(null, null); 
					}
					break;
			}

			base.WndProc (ref m);

		}

		/// <summary> 
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Component Designer generated code
		/// <summary> 
		/// Required method for Designer support - do not modify 
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
            this.SuspendLayout( );
            // 
            // Lbox
            // 
            this.SelectionMode = System.Windows.Forms.SelectionMode.MultiExtended;
            this.Size = new System.Drawing.Size( 248 , 150 );
            this.ResumeLayout( false );

		}
		#endregion
	}
}
