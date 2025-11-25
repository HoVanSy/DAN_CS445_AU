using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace DAN_CS445_AU.admin
{
    public partial class Orders : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadDonHang();
        }

        private void LoadDonHang()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Câu lệnh SQL:
                    // 1. Join DonHang với Users để lấy tên khách.
                    // 2. Tính tổng tiền từ bảng ChiTietDon (Gia * SoLuong).
                    // 3. Có điều kiện lọc theo Trạng thái và Từ khóa tìm kiếm.
                    string query = @"
                        SELECT 
                            d.Dh_id, 
                            d.NgayDat, 
                            d.TrangThai, 
                            d.PhuongThucTT,
                            u.HoVaTen,
                            (SELECT ISNULL(SUM(ct.Gia * ct.SoLuong), 0) FROM ChiTietDon ct WHERE ct.Dh_id = d.Dh_id) as TongTien
                        FROM DonHang d
                        JOIN Users u ON d.user_id = u.user_id
                        WHERE 1=1 
                    ";

                    // Thêm điều kiện lọc nếu có
                    if (ddlStatus.SelectedValue != "")
                    {
                        query += " AND d.TrangThai = @TrangThai";
                    }

                    if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                    {
                        query += " AND (d.Dh_id LIKE @Search OR u.HoVaTen LIKE @Search)";
                    }

                    query += " ORDER BY d.NgayDat DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        if (ddlStatus.SelectedValue != "")
                        {
                            cmd.Parameters.AddWithValue("@TrangThai", ddlStatus.SelectedValue);
                        }

                        if (!string.IsNullOrEmpty(txtSearch.Text.Trim()))
                        {
                            cmd.Parameters.AddWithValue("@Search", "%" + txtSearch.Text.Trim() + "%");
                        }

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                rptDonHang.DataSource = dt;
                                rptDonHang.DataBind();
                                pnlNoData.Visible = false;
                            }
                            else
                            {
                                rptDonHang.DataSource = null;
                                rptDonHang.DataBind();
                                pnlNoData.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi (ghi log hoặc hiện thông báo)
                Response.Write("<script>alert('Lỗi: " + ex.Message + "');</script>");
            }
        }

        // Hàm Helper: Trả về HTML chứa class màu sắc tương ứng với trạng thái
        // Được gọi trực tiếp từ file .aspx: <%# GetStatusHtml(...) %>
        public string GetStatusHtml(string status)
        {
            string cssClass = "";
            string statusText = status;

            switch (status)
            {
                case "Chờ xác nhận":
                    // Màu vàng (Warning)
                    cssClass = "bg-warning/10 text-yellow-600 dark:text-yellow-400";
                    break;
                case "Đang giao":
                    // Màu xanh dương (Info)
                    cssClass = "bg-info/10 text-info";
                    break;
                case "Đã giao":
                    // Màu xanh lá (Success)
                    cssClass = "bg-success/10 text-success";
                    break;
                case "Đã hủy":
                    // Màu đỏ (Danger)
                    cssClass = "bg-danger/10 text-danger";
                    break;
                default:
                    // Mặc định màu xám
                    cssClass = "bg-gray-100 text-gray-600";
                    break;
            }

            return String.Format("<span class='inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium {0}'>{1}</span>", cssClass, statusText);
        }
    }
}