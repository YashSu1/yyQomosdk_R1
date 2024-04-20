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

namespace DotNetRemoting
{
	public delegate void SelectedIndexDeleg(object Item, int ItemIndex);

	public class DotNetListBox : System.Windows.Forms.UserControl
	{
		public event SelectedIndexDeleg					SelIndexChanged;
		private System.Windows.Forms.HScrollBar			hScrollBar1;
		private Lbox 									listBox;
		private int										MaxStrignLen;
		private int										DrawingPos;
		private	 DoubleBuffer							DoubleBuff;
		private System.Windows.Forms.ImageList			imageList1 = null;
		private	int										XOffset_forIcon = 0;
		private Color									_HighLightColor = Color.FromArgb(235,237,249);
		
	 
		private System.ComponentModel.IContainer		components;

		private class ObjectHolder
		{
			public int			IconIndex;
			public object		Item;
			public Color		TxtColor;

			public ObjectHolder(int IconIndex, object Item, Color TxtColor)
			{
				this.IconIndex = IconIndex;
				this.Item = Item;
				this.TxtColor = TxtColor;
			}

			public override string ToString()
			{
				try
				{
					return Item.ToString ();
				}
				catch
				{
					return "item is null";
				}
			}
		}

		public DotNetListBox()
		{
			InitializeComponent();

			listBox.DrawMode = DrawMode.OwnerDrawVariable;
			listBox.DrawItem +=new DrawItemEventHandler(listBox_DrawItem);
			listBox.MeasureItem +=new MeasureItemEventHandler(listBox_MeasureItem);
			listBox.SelectedIndexChanged +=new EventHandler(listBox_SelectedIndexChanged);
			listBox.UpdateEv +=new EventHandler(listBox_UpdateEv);
			
			listBox.LostFocus +=new EventHandler(listBox_LostFocus);			 
			
			hScrollBar1.ValueChanged +=new EventHandler(hScrollBar1_ValueChanged);

			this.Paint += new PaintEventHandler(ColorListBox_Paint);

			DoubleBuff = new  DoubleBuffer(listBox);
			imageList1 = null;// to kill the imagelist created by the designer 
			ResizeComponets();
		}

		public ListBox InternalListBox
		{
			get
			{
				return this.listBox;
			}
		}

		public int SelectedIndex
		{
			get
			{
				return this.listBox.SelectedIndex;
			}
		}

		private bool UseDoubleBuffering
		{
			get
			{
				return listBox.BlockEraseBackGnd;
			}
			set
			{
				if (value)
				{
					DoubleBuff.CheckIfRefreshBufferRequired();
				}

				listBox.BlockEraseBackGnd = value;
			}
		}

		public ImageList IconImageList
		{
			get
			{
				return imageList1;
			}
			set
			{
				imageList1 = value;

				if (imageList1 != null)
				{
					imageList1.TransparentColor = System.Drawing.Color.Transparent;
				}
				else
				{
					XOffset_forIcon = 0;
				}
			}
		}

		public Color HighLightColor
		{
			get
			{
				return _HighLightColor;
			}
			set
			{
				_HighLightColor = value;
			}
		}

		public int Count
		{
			get
			{
				return listBox.Items.Count;
			}
		}

		public void RemoveAt(int Index)
		{
			listBox.Items.RemoveAt(Index);
			RefreshBox();
		}

		public void RefreshBox()
		{
			UseDoubleBuffering = false;
			listBox.Refresh();
			this.Refresh();
		}

		public void InsertItem(int InsertAfter, object Item, int IconIndex, Color TxtColor)
		{
			ObjectHolder oh = new ObjectHolder(IconIndex, Item, TxtColor);
			listBox.Items.Insert(InsertAfter, oh);
			UseDoubleBuffering = false;
			//listBox.Items.Add(oh);	
			ResizeListBoxAndHScrollBar();
		}

		public void AddItem(object Item)
		{
			AddItem(Item, Color.Black);
		}

		public void AddItem(object Item, Color TxtColor)
		{
			AddItem(Item, -1, TxtColor);
		}

		public void AddItem(object Item, int IconIndex, Color TxtColor)
		{
			ObjectHolder oh = new ObjectHolder(IconIndex, Item, TxtColor);
			
			UseDoubleBuffering = false;
			listBox.Items.Add(oh);	
			ResizeListBoxAndHScrollBar();
		}

		public HScrollBar InternalHScrolBar
		{
			get
			{
				return this.hScrollBar1;
			}
		}

		public void Clear()
		{
			listBox.Items.Clear();
			MaxStrignLen = 0;
			UseDoubleBuffering = false;
			ResizeListBoxAndHScrollBar();
		}

		public override Color BackColor
		{
			get
			{
				return listBox.BackColor; 
			}
			set
			{
				listBox.BackColor = value; 
			}
		}

		private void EraseMemBackGround()
		{
			if (!UseDoubleBuffering)
				return;

			DoubleBuff.BuffGraph.FillRectangle(new SolidBrush(BackColor), 0, 0, this.listBox.Width, this.listBox.Height);
		}

		protected void DrawListBoxItem(Graphics g, Rectangle bounds, int Index, bool selected)
		{	
			if (Index == -1)
		 		return;
 
			if (bounds.Top < 0)
				return;

			if (bounds.Bottom > (listBox.Bottom + listBox.ItemHeight))
				return;

			Graphics gr = null;

			if (UseDoubleBuffering)
			{
				gr = DoubleBuff.BuffGraph;
			}
			else
			{
				gr = g;
			}

			int IconIndex;
			Color TextColor;
			string Text = GetObjString(Index, out IconIndex, out TextColor);

			Image img = null;

			if (selected)
			{
				if (this.listBox.Focused)
				{
					using(Brush b = new SolidBrush(_HighLightColor)) 
					{
						gr.FillRectangle(b, 0, 
							bounds.Top + 1, this.listBox.Width, bounds.Height - 1);
					}
				}
				else
				{
					using(Brush b = new SolidBrush(Color.Gainsboro))
					{
						gr.FillRectangle(b, 0, 
							bounds.Top, this.listBox.Width, bounds.Height);
					}
				}

				if (this.listBox.Focused)
				{
					using(Pen p = new Pen(Color.RoyalBlue))
					{
 						gr.DrawRectangle(p, new Rectangle(0, 
							bounds.Top, this.listBox.Width, bounds.Height));
					}
				}
			}

			if (IconIndex != -1 && imageList1 != null) 
			{
				img = imageList1.Images[IconIndex];
				Rectangle imgRect = new Rectangle(bounds.Left - DrawingPos, bounds.Top , img.Width, img.Height);
				gr.DrawImage(img, imgRect, 0, 0, img.Width, img.Height, GraphicsUnit.Pixel); 
			}

			using(Brush b = new SolidBrush(TextColor))
			{
				gr.DrawString(Text, this.Font, b, 
					new Point(bounds.Left - DrawingPos + XOffset_forIcon + 2, bounds.Top + 2));	
			}
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if( components != null )
					components.Dispose();
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
			this.components = new System.ComponentModel.Container();
			this.listBox = new DotNetRemoting.Lbox();
			this.hScrollBar1 = new System.Windows.Forms.HScrollBar();
			this.SuspendLayout();
			// 
			// listBox
			// 
			this.listBox.Location = new System.Drawing.Point(0, 0);
			this.listBox.Name = "listBox";
			this.listBox.Size = new System.Drawing.Size(192, 277);
			this.listBox.TabIndex = 0;
			// 
			// hScrollBar1
			// 
			this.hScrollBar1.Location = new System.Drawing.Point(0, 312);
			this.hScrollBar1.Name = "hScrollBar1";
			this.hScrollBar1.Size = new System.Drawing.Size(192, 16);
			this.hScrollBar1.TabIndex = 1;
			// 
			// timer1
			// 
			// 
			// DotNetListBox
			// 
			this.Controls.Add(this.hScrollBar1);
			this.Controls.Add(this.listBox);
			this.Name = "DotNetListBox";
			this.Size = new System.Drawing.Size(192, 328);
			this.SizeChanged += new System.EventHandler(this.ColorListBox_SizeChanged);
			this.ResumeLayout(false);

		}
		#endregion

		private void ColorListBox_SizeChanged(object sender, System.EventArgs e)
		{
			ResizeComponets();
		}

		private void ResizeComponets()
		{	
			ResizeListBoxAndHScrollBar();
			DoubleBuff.RefreshBuffer(); 
			UseDoubleBuffering = true;
			EraseMemBackGround();
			listBox.Refresh();
			DoubleBuff.Render();
		}

		private void ResizeListBoxAndHScrollBar()
		{
			listBox.Width = this.Width;

			if (this.listBox.Width > (MaxStrignLen + XOffset_forIcon + 15))
			{
				hScrollBar1.Visible = false;
				listBox.Height = this.Height;
			}
			else
			{
				hScrollBar1.Height = 18;
				listBox.Height = this.Height - this.hScrollBar1.Height;
				hScrollBar1.Top = this.Height - this.hScrollBar1.Height - 1;
				hScrollBar1.Width = this.Width;	

				hScrollBar1.Visible = true;
				hScrollBar1.Minimum = 0;
				hScrollBar1.Maximum = MaxStrignLen  + XOffset_forIcon + 15;
				hScrollBar1.LargeChange = this.listBox.Width; 
				hScrollBar1.Value = 0;
			}		
		}

		private void listBox_DrawItem(object sender, DrawItemEventArgs e)
		{				
			Rectangle r = new Rectangle(e.Bounds.X, e.Bounds.Y, listBox.Width, listBox.ItemHeight);
			bool selected = (e.State & DrawItemState.Selected) > 0;			
			DrawListBoxItem(e.Graphics,e.Bounds, e.Index, selected);
		}

		private string GetObjString(int Index, out int IconIndex, out Color clr)
		{
			clr = Color.Black;
			IconIndex = -1;

			ObjectHolder oh = listBox.Items[Index] as ObjectHolder;

			if (oh == null)
			{
				try
				{
					return listBox.Items[Index].ToString();
				}
				catch
				{
					return "error: the object is null";
				}
			}
			else
			{
				clr = oh.TxtColor;
				IconIndex = oh.IconIndex;
				return oh.ToString(); 
 			}
		}

		private void listBox_MeasureItem(object sender, MeasureItemEventArgs e)
		{
			int IconIndex;
			Color clr;

			string s = GetObjString(e.Index, out IconIndex, out clr); 
			
			SizeF sf = e.Graphics.MeasureString(s, this.listBox.Font);
			
			if (imageList1 != null)
			{
				XOffset_forIcon = 16;
				e.ItemHeight = 18;
			}
			else
			{
				e.ItemHeight = (int)sf.Height + 2;
			}

			if (sf.Width > MaxStrignLen)
			{
				MaxStrignLen = (int)sf.Width; 
			}
		}

		private void hScrollBar1_ValueChanged(object sender, EventArgs e)
		{
			UseDoubleBuffering = true;
			DrawingPos = hScrollBar1.Value;	
			EraseMemBackGround();
			listBox.Refresh();		
			DoubleBuff.Render();
		}

		private void listBox_SelectedIndexChanged(object sender, EventArgs e)
		{
			 
			UseDoubleBuffering = true;
			EraseMemBackGround();
			listBox.Refresh();
			DoubleBuff.Render();	
			
			if (SelIndexChanged != null)
			{
				int SelIndex = listBox.SelectedIndex;
				if (SelIndex != -1)
				{
					object o = listBox.Items[SelIndex];
					SelIndexChanged(o, SelIndex); 
				}
			}
		}

		private void ColorListBox_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
		{
			UseDoubleBuffering = true;
			EraseMemBackGround();
			listBox.Refresh();
			DoubleBuff.Render();	
		}

		private void listBox_UpdateEv(object sender, EventArgs e)
		{
			UseDoubleBuffering = false;
		}

		private void listBox_LostFocus(object sender, EventArgs e)
		{
			UseDoubleBuffering = false;
			listBox.Refresh();
		}
	}
}
