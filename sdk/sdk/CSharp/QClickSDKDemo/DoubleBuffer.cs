using System;
using System.Drawing;
using System.Windows.Forms;

namespace DotNetRemoting
{
 	public class DoubleBuffer : IDisposable
	{
		private	Graphics	graphics;
		private Bitmap		bitmap;
 		private Control		_ParentCtl;
		private Graphics	CtlGraphics;

 		public DoubleBuffer(Control ParentCtl)
		{
			_ParentCtl = ParentCtl;
			bitmap	= new Bitmap(_ParentCtl.Width , _ParentCtl.Height);
			graphics		= Graphics.FromImage(bitmap);
			CtlGraphics =	_ParentCtl.CreateGraphics();
 		}

		public void CheckIfRefreshBufferRequired()
		{
			if ((_ParentCtl.Width != bitmap.Width) || (_ParentCtl.Height != bitmap.Height))
			{
				RefreshBuffer();
			}
		}

		public void RefreshBuffer()
		{
			if (_ParentCtl == null)
				return;

			if (_ParentCtl.Width == 0 || _ParentCtl.Height == 0)// restoring event
				return;

			if (bitmap != null)
			{
				bitmap.Dispose();
				bitmap = null;
			}

			if (graphics != null)
			{
				graphics.Dispose();
				graphics = null;
			}

			bitmap	= new Bitmap(_ParentCtl.Width, _ParentCtl.Height);
			graphics = Graphics.FromImage(bitmap);

			if (CtlGraphics != null)
			{
				CtlGraphics.Dispose(); 
			}
			
			CtlGraphics =	_ParentCtl.CreateGraphics();
		}

 		public void Render()
		{
			CtlGraphics.DrawImage(
				bitmap, 
				_ParentCtl.Bounds,
				0, 
				0, 
				_ParentCtl.Width, 
				_ParentCtl.Height, 
				GraphicsUnit.Pixel);
 		}

		public Graphics BuffGraph 
		{
			get 
			{ 
				return graphics; 
			}
		}	
	
		#region IDisposable Members

		public void Dispose()
		{
			if (bitmap != null)
			{
				bitmap.Dispose(); 
			}

			if (graphics != null)
			{
				graphics.Dispose();  
			}

			if (CtlGraphics != null)
			{
				CtlGraphics.Dispose(); 
			}
		}

		#endregion
	}
}
