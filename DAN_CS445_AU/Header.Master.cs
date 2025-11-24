using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU
{
    public partial class Header : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            //string searchQuery = txtSearch.Text.Trim();
            //if (!string.IsNullOrEmpty(searchQuery))
            //{
            //    Response.Redirect($"~/search?q={Server.UrlEncode(searchQuery)}");
            //}
        }
    }
}