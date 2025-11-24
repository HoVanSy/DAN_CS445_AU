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
            // 1. Lấy từ khóa từ ô nhập liệu
            string keyword = txtSearch.Text.Trim();

            // 2. Nếu có từ khóa, chuyển hướng sang trang Timkiem.aspx với tham số query 'q'
            if (!string.IsNullOrEmpty(keyword))
            {
                Response.Redirect("/khach_vang_lai/Timkiem.aspx?q=" + Server.UrlEncode(keyword));
            }
        }
    }
}