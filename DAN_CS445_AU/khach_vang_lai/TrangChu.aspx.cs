using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace DAN_CS445_AU
{
    public partial class TrangChu : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối từ Web.config
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPhamChatLuong();
                LoadSanPhamBanChay();
            }
        }

        // 1. Sản phẩm mới nhất (Sản phẩm chất lượng)
        private void LoadSanPhamChatLuong()
        {
            // Lấy 8 sản phẩm mới nhất
            string query = "SELECT TOP 8 sp_id, TieuDe, [Gia] as Gia, HinhAnh, SoLuong, TenNongTrai FROM SanPham ORDER BY sp_id DESC";
            DataTable dt = GetData(query);
            if (dt != null)
            {
                rptSanPham.DataSource = dt;
                rptSanPham.DataBind();
            }
        }

        // 2. Sản phẩm bán chạy
        private void LoadSanPhamBanChay()
        {
            // Lấy 4 sản phẩm bán chạy (theo số lượng)
            string query = "SELECT TOP 4 sp_id, TieuDe, [Gia] as Gia, HinhAnh, SoLuong, TenNongTrai FROM SanPham ORDER BY SoLuong DESC";
            DataTable dt = GetData(query);
            if (dt != null)
            {
                rptSanPhamBanChay.DataSource = dt;
                rptSanPhamBanChay.DataBind();
            }
        }

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
                // Ghi log lỗi vào Output window để kiểm tra nếu cần
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
            return dt;
        }
    }
}