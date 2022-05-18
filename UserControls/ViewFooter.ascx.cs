using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LSA.UserControls
{
    public partial class ViewFooter : System.Web.UI.UserControl
    {
        public string CreateBy
        {
            get { return TbCreateBy.Text; }
            set => TbCreateBy.Text = value;
        }
        public string CreateDate
        {
            get { return TbCreateDate.Text; }
            set => TbCreateDate.Text = CommonBL.DateTimeMapper(value) == new DateTime()? "" : value;
        }
        public string AmendBy
        {
            get { return TbAmendBy.Text; }
            set => TbAmendBy.Text = value;
        }
        public string AmendDate
        {
            get { return TbAmendDate.Text; }
            set => TbAmendDate.Text = CommonBL.DateTimeMapper(value) == new DateTime() ? "" : value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            TbCreateBy.Enabled = TbCreateDate.Enabled = TbAmendBy.Enabled = TbAmendDate.Enabled = false;
        }
    }

}