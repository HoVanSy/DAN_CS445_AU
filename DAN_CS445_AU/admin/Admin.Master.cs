using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU.admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // BỎ HẾT PHẦN KIỂM TRA ĐĂNG NHẬP
            // Không cần làm gì ở đây
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Giữ lại để tránh lỗi nếu có button logout trong Master
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/admin/QuanLyDanhMuc.aspx");
        }
    }
}