using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU.khach_hang
{
    public partial class DangNhap : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối từ Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Nếu đã đăng nhập rồi thì chuyển hướng luôn (tránh đăng nhập lại)
                if (Session["UserID"] != null)
                {
                    Response.Redirect("TrangChu.aspx"); // Hoặc trang Admin tùy logic
                }
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim();

            // 1. Kiểm tra rỗng
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(matKhau))
            {
                lblLoi.Text = "Vui lòng nhập Email và Mật khẩu.";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 2. Query kiểm tra Email và Mật khẩu
                    // Lấy thêm Role_ID để biết là Admin hay Khách hàng
                    string query = "SELECT tk_id, HoVaTen, role_id FROM TaiKhoan WHERE Email = @Email AND MatKhau = @MatKhau";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@MatKhau", matKhau);
                        // Lưu ý: Nếu sau này bạn mã hóa mật khẩu, bạn cần mã hóa 'matKhau' nhập vào rồi mới so sánh.

                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // --- ĐĂNG NHẬP THÀNH CÔNG ---

                            // 3. Lưu thông tin vào Session (Phiên làm việc)
                            Session["UserID"] = reader["tk_id"].ToString();
                            Session["UserName"] = reader["HoVaTen"].ToString();
                            Session["RoleID"] = reader["role_id"].ToString();

                            // 4. Kiểm tra phân quyền để chuyển hướng
                            int roleId = Convert.ToInt32(reader["role_id"]);

                            if (roleId == 1) // 1 là Admin (theo quy ước lúc tạo database)
                            {
                                Response.Redirect("~/admin/Dashboard.aspx"); // Đường dẫn đến trang Admin
                            }
                            else
                            {
                                Response.Redirect("~/khach_vang_lai/TrangChu.aspx"); // Đường dẫn đến trang chủ khách hàng
                            }
                        }
                        else
                        {
                            // --- ĐĂNG NHẬP THẤT BẠI ---
                            lblLoi.Text = "Tên đăng nhập hoặc mật khẩu không chính xác.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblLoi.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}