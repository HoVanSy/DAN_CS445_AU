using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU.khach_vang_lai
{
    public partial class DangKiTaiKhoan : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Code chạy khi trang tải lần đầu
            }
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            // 1. Lấy dữ liệu từ form
            string hoTen = txtHoTen.Text.Trim();
            string email = txtEmail.Text.Trim();
            string matKhau = txtMatKhau.Text.Trim(); // Lưu ý: Thực tế nên mã hóa (MD5/SHA) trước khi lưu
            string sdt = txtSDT.Text.Trim();
            string diaChi = txtDiaChi.Text.Trim();

            // 2. Validate cơ bản (Kiểm tra rỗng)
            if (string.IsNullOrEmpty(hoTen) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(matKhau))
            {
                lblThongBao.Text = "Vui lòng nhập đầy đủ thông tin bắt buộc!";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 3. Kiểm tra xem Email đã tồn tại chưa
                    string checkQuery = "SELECT COUNT(*) FROM TaiKhoan WHERE Email = @Email";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", email);
                        int exists = (int)checkCmd.ExecuteScalar();

                        if (exists > 0)
                        {
                            lblThongBao.Text = "Email này đã được sử dụng. Vui lòng chọn email khác.";
                            return;
                        }
                    }

                    // 4. Thêm tài khoản mới vào CSDL
                    // Giả sử RoleID = 2 là Khách hàng (như dữ liệu mẫu trước đó)
                    string insertQuery = @"INSERT INTO TaiKhoan (HoVaTen, Email, MatKhau, SoDienThoai, role_id) 
                                           VALUES (@HoTen, @Email, @MatKhau, @SDT, 2)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@HoTen", hoTen);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@MatKhau", matKhau);
                        cmd.Parameters.AddWithValue("@SDT", sdt);
                        // cmd.Parameters.AddWithValue("@DiaChi", diaChi); // Nếu bảng TaiKhoan chưa có cột DiaChi thì bỏ dòng này, hoặc thêm vào bảng Users

                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            // Đăng ký thành công -> Chuyển hướng về trang Đăng nhập
                            // Dùng JavaScript để hiện thông báo rồi mới chuyển trang
                            string script = "alert('Đăng ký thành công! Vui lòng đăng nhập.'); window.location='DangNhap.aspx';";
                            ClientScript.RegisterStartupScript(this.GetType(), "SuccessMessage", script, true);
                        }
                        else
                        {
                            lblThongBao.Text = "Đã xảy ra lỗi, vui lòng thử lại.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi nếu cần
                lblThongBao.Text = "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}