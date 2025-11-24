using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DAN_CS445_AU.admin
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối từ Web.config
        string strKetNoi = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiDuLieu();
            }
        }

        // Hàm hiển thị dữ liệu có hỗ trợ tìm kiếm
        private void HienThiDuLieu(string tuKhoa = "")
        {
            string query = @"
                SELECT 
                    s.sp_id, 
                    s.TieuDe, 
                    s.Gia, 
                    s.SoLuong, 
                    s.HinhAnh, 
                    d.TieuDe AS TenDanhMuc 
                FROM SanPham s 
                LEFT JOIN DanhMucSp d ON s.dm_id = d.dm_id
                WHERE 1=1 "; // Mẹo WHERE 1=1 để dễ nối chuỗi AND

            // Nếu có từ khóa tìm kiếm thì thêm điều kiện lọc
            if (!string.IsNullOrEmpty(tuKhoa))
            {
                query += " AND (s.TieuDe LIKE @tuKhoa OR d.TieuDe LIKE @tuKhoa)";
            }

            query += " ORDER BY s.sp_id DESC";

            using (SqlConnection conn = new SqlConnection(strKetNoi))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Thêm tham số nếu có tìm kiếm
                    if (!string.IsNullOrEmpty(tuKhoa))
                    {
                        cmd.Parameters.AddWithValue("@tuKhoa", "%" + tuKhoa + "%");
                    }

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptProducts.DataSource = dt;
                    rptProducts.DataBind();
                }
            }
        }

        // Sự kiện khi nhấn nút Xóa
        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int idSanPham = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(strKetNoi))
                {
                    // Xóa các ràng buộc khóa ngoại trước (nếu có, ví dụ NguonGocSp, QRCode)
                    // Ở đây làm đơn giản là xóa bảng SanPham
                    string query = "DELETE FROM SanPham WHERE sp_id = @id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", idSanPham);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Load lại dữ liệu và giữ nguyên từ khóa tìm kiếm (nếu đang tìm)
                HienThiDuLieu(txtSearch.Text.Trim());
            }
        }

        // Sự kiện Tìm kiếm: Khi người dùng gõ xong và nhấn Enter
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            string tuKhoa = txtSearch.Text.Trim();
            HienThiDuLieu(tuKhoa);
        }
    }
}