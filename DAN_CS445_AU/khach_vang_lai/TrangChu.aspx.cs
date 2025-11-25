using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace DAN_CS445_AU
{
    public partial class TrangChu : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPhamChatLuong();
                LoadSanPhamBanChay();
            }
        }

        // 1. Hàm tải sản phẩm cho phần "Sản phẩm chất lượng" (Lấy 8 sản phẩm mới nhất)
        private void LoadSanPhamChatLuong()
        {
            // Query lấy: ID, Tiêu đề, Giá (đổi tên cột thành Gia), Hình ảnh
            string query = "SELECT TOP 8 sp_id, TieuDe, Giá as Giá, HinhAnh, SoLuong FROM SanPham ORDER BY sp_id DESC";

            DataTable dt = GetData(query);

            // Xử lý cột giảm giá (nếu DB không có thì tạo giả)
            if (!dt.Columns.Contains("PhanTramGiam"))
            {
                dt.Columns.Add("PhanTramGiam", typeof(int));
                foreach (DataRow dr in dt.Rows) dr["PhanTramGiam"] = 0; // Mặc định 0%
            }

            rptSanPham.DataSource = dt;
            rptSanPham.DataBind();
        }

        // 2. Hàm tải sản phẩm cho phần "Bán chạy" (Lấy 4 sản phẩm theo Số lượng)
        private void LoadSanPhamBanChay()
        {
            string query = "SELECT TOP 4 sp_id, TieuDe, Giá as Giá, HinhAnh, SoLuong FROM SanPham ORDER BY SoLuong DESC";

            DataTable dt = GetData(query);

            // Xử lý cột giảm giá giả lập
            if (!dt.Columns.Contains("PhanTramGiam"))
            {
                dt.Columns.Add("PhanTramGiam", typeof(int));
                foreach (DataRow dr in dt.Rows) dr["PhanTramGiam"] = 10; //bán chạy giảm 10%
            }

            Repeater1.DataSource = dt;
            Repeater1.DataBind();
        }

        // Hàm phụ trợ để lấy dữ liệu cho gọn code
        private DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Ghi log lỗi hoặc thông báo (nếu cần)
                // Response.Write(ex.Message);
            }
            return dt;
        }
    }
}