using System;
using System.Data;
using System.Data.SqlClient; // Thư viện kết nối SQL
using System.Web.UI;

namespace DAN_CS445_AU
{
    public partial class Timkiem : System.Web.UI.Page
    {
        // ==================================================================================
        // CẤU HÌNH CHUỖI KẾT NỐI (CONNECTION STRING)
        // ==================================================================================
        // Lưu ý: Dấu @ đằng trước giúp C# hiểu dấu \ là ký tự thường
        // Nếu bạn dùng SQL Express: Data Source=.\SQLEXPRESS
        // Nếu bạn dùng SQL Full:    Data Source=.
        string MyConnectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tuKhoa = Request.QueryString["q"];
                if (!string.IsNullOrEmpty(tuKhoa))
                {
                    lblTuKhoa.Text = "\"" + tuKhoa + "\"";
                    LayDuLieuTuSQL(tuKhoa);
                }
                else
                {
                    lblTuKhoa.Text = "Tất cả sản phẩm";
                    LayDuLieuTuSQL(""); // Lấy hết
                }
            }
        }

        private void LayDuLieuTuSQL(string keyword)
        {
            // Bọc trong Try-Catch để bắt lỗi nếu kết nối thất bại
            try
            {
                using (SqlConnection conn = new SqlConnection(MyConnectionString))
                {
                    // Câu lệnh SQL lấy dữ liệu
                    string query = @"SELECT sp_id, TieuDe as TenSP, [Giá] as Giá, HinhAnh, 
                                     (SELECT TOP 1 TieuDe FROM DanhMucSp WHERE DanhMucSp.dm_id = SanPham.dm_id) as TenNongTrai 
                                     FROM SanPham 
                                     WHERE TieuDe LIKE @keyword";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Thêm tham số để tránh SQL Injection
                        cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

                        conn.Open(); // Mở kết nối (Nếu sai tên Server sẽ lỗi tại đây)

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt); // Đổ dữ liệu vào bảng ảo

                        // Đổ dữ liệu ra giao diện (Repeater)
                        if (dt.Rows.Count > 0)
                        {
                            rptKetQuaTimKiem.DataSource = dt;
                            rptKetQuaTimKiem.DataBind();
                            lblSoLuong.Text = dt.Rows.Count.ToString();
                            pnlKhongTimThay.Visible = false;
                        }
                        else
                        {
                            rptKetQuaTimKiem.Visible = false;
                            lblSoLuong.Text = "0";
                            pnlKhongTimThay.Visible = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Nếu có lỗi, hiện thông báo lỗi lên màn hình thay vì sập web
                lblTuKhoa.Text = "LỖI KẾT NỐI: " + ex.Message;
                lblTuKhoa.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}