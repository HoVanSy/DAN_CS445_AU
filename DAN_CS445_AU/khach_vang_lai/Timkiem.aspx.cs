using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace DAN_CS445_AU
{
    public partial class Timkiem : System.Web.UI.Page
    {
        // Chuỗi kết nối LocalDB chuẩn
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
            try
            {
                using (SqlConnection conn = new SqlConnection(MyConnectionString))
                {
                    // LƯU Ý: Đảm bảo cột trong DB tên là 'Gia' (không dấu) hoặc 'Giá' (có dấu)
                    // Nếu DB là 'Gia' -> dùng [Gia]
                    // Nếu DB là 'Giá' -> dùng [Giá] as Gia
                    string query = @"SELECT sp_id, TieuDe as TenSP, [Gia] as Gia, HinhAnh, 
                                     (SELECT TOP 1 TieuDe FROM DanhMucSp WHERE DanhMucSp.dm_id = SanPham.dm_id) as TenNongTrai 
                                     FROM SanPham 
                                     WHERE TieuDe LIKE @keyword";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

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
                lblTuKhoa.Text = "LỖI: " + ex.Message;
                lblTuKhoa.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}